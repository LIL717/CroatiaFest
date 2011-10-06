//
//  VersionController.m
//  CroatiaFest
//
//  Created by Lori Hill on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VersionController.h"
#import "Version.h"

#pragma mark -
#pragma mark VersionController

@implementation VersionController

@synthesize version = version_; 
@synthesize managedObjectContext = __managedObjectContext;

- (void)dealloc {
    
    [version_ release];
    [__managedObjectContext release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (BOOL)updateSavedVersion: (NSString *) newVersionString
{
    int savedVersion;
    BOOL versionChanged;
    // use NSNumberFormatter to change string to int
    //localization allows other thousands separators, also.
    NSNumberFormatter * myNumFormatter = [[NSNumberFormatter alloc] init];
    [myNumFormatter setLocale:[NSLocale currentLocale]];
//    [myNumFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
//    [myNumFormatter setNumberStyle:NSNumberFormatterDecimalStyle]; 
    
    NSNumber *newVersionNumber = [myNumFormatter numberFromString:newVersionString];
//    NSLog(@"string '%@' gives NSNumber '%@' with intValue '%i'", 
//          newVersionString, newVersionNumber, [newVersionNumber intValue]);
    [myNumFormatter release];
        
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Version"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
//    NSLog(@"entity retrieved is %@", entity);
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects == nil) {
        // Handle the error
        NSLog (@"fetch error");
    }
    
    //if there is not an object, need to insert one with the new Version Number
    if ([fetchedObjects count] == 0) {
//        NSLog (@"no objects fetched");
        [self insertVersion:newVersionNumber];
        versionChanged = YES;
    } else {
        //if there is an object, need to get the Version Number 
        Version *currentManagedObject = [fetchedObjects objectAtIndex:0];
        savedVersion = [[[currentManagedObject valueForKey:@"number"] description] intValue];
//        NSLog (@"savedVersion is %d", savedVersion);

        if (savedVersion == [newVersionNumber intValue]) {
//            NSLog(@"version number is the same");
            versionChanged = NO;
        } else {
//            NSLog(@"savedVersion is %d while newVersionNumber is %@", savedVersion, newVersionNumber);
            // update version number
            currentManagedObject.number = newVersionNumber;
            //save
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
            }
            versionChanged = YES;
        }
    }
    return versionChanged;
}

- (void) insertVersion: (NSNumber *) newVersionNumber {
    
    NSError *error = nil;

    self.version= [NSEntityDescription insertNewObjectForEntityForName:@"Version" inManagedObjectContext:self.managedObjectContext];
    self.version.number = newVersionNumber;

    if (![self.managedObjectContext save:&error]) {
    NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
    }
}

@end
