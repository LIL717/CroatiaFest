//
//  VersionController.m
//  CroatiaFest
//
//  Created by Lori Hill on 9/28/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import "VersionController.h"
#import "Version.h"
#import "CroatiaFestAppDelegate.h"

#pragma mark -
#pragma mark VersionController

@implementation VersionController

@synthesize version = version_; 
@synthesize managedObjectContext = managedObjectContext_;


- (id)init
{
//    LogMethod();
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (BOOL)compareVersion: (NSString *) newVersionString
{
	CroatiaFestAppDelegate *appDelegate = (CroatiaFestAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    int savedVersion;
    BOOL versionChanged;
    NSLog (@"newVersionString is %@", newVersionString);
        
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Version"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
//    NSLog(@"entity retrieved is %@", entity);
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects == nil) {
        // Handle the error
        NSLog (@"fetch error");
    }
    
    //if there is not an object, set flag that version is changed, but version number will be saved after core data persistent store is reinitialized
    if ([fetchedObjects count] == 0) {
//        NSLog (@"no objects fetched");
//        [self insertVersion:newVersionNumber];
        versionChanged = YES;
    } else {
        //if there is an object, need to get the Version Number 
        Version *currentManagedObject = [fetchedObjects objectAtIndex:0];
        savedVersion = [[[currentManagedObject valueForKey:@"number"] description] intValue];
        NSLog (@"savedVersion is %d", savedVersion);

        if (savedVersion == [[self convertStringToNumber: newVersionString] intValue]) {
//            NSLog(@"version number is the same");
            versionChanged = NO;
        } else {
            //set flag, but version number will be saved after core data persistent store is reinitialized
            NSLog(@"savedVersion is %d while newVersionNumber is %@", savedVersion, [self convertStringToNumber: newVersionString]);
            versionChanged = YES;
        }
    }
    return versionChanged;
}

- (void) insertVersion: (NSArray *) version {  
//    LogMethod();
    //this is an array of dictionaries
    
    for (id newVersion in version) {
        
        NSError *error = nil;
        
        self.version = [NSEntityDescription insertNewObjectForEntityForName:@"Version" inManagedObjectContext:self.managedObjectContext];
        self.version.number = [self convertStringToNumber:[newVersion valueForKey: @"Version"]];

        if (![self.managedObjectContext save:&error]) {
        NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
    }
}

-(NSNumber *) convertStringToNumber: (NSString *) newVersionString {
    
    //localization allows other thousands separators, also.
    NSNumberFormatter * myNumFormatter = [[NSNumberFormatter alloc] init];
    [myNumFormatter setLocale:[NSLocale currentLocale]];
 
    
    NSNumber *newVersionNumber = [myNumFormatter numberFromString:newVersionString];
    //    NSLog(@"string '%@' gives NSNumber '%@' with intValue '%i'", 
    //          newVersionString, newVersionNumber, [newVersionNumber intValue]);
    
    return newVersionNumber;
}
@end
