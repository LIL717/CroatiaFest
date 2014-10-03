//
//  Directory.m
//  CroatiaFest
//
//  Created by Lori Hill on 10/11/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import "Directory.h"
#import "CroatiaFestAppDelegate.h"

@implementation Directory

@dynamic name;
@dynamic desc1;
@dynamic desc2;
@dynamic addr1;
@dynamic addr2;
@dynamic phone1;
@dynamic phone2;
@dynamic website;
@dynamic email;


- (void)addDirectoryToCoreData:(NSArray *)directory {
    //LogMethod();
	CroatiaFestAppDelegate *appDelegate = (CroatiaFestAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    //this is an array of dictionaries
    
    NSError *error = nil;
    // insert the directory into Core Data
    for (id newDirectory in directory) {
        
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Directory" inManagedObjectContext:managedObjectContext];
        [newManagedObject setValue: [newDirectory valueForKey: @"Name"] forKey:@"name"];
        [newManagedObject setValue: [newDirectory valueForKey: @"Desc_1"] forKey:@"desc1"];
        [newManagedObject setValue: [newDirectory valueForKey: @"Desc_2"] forKey:@"desc2"];
        [newManagedObject setValue: [newDirectory valueForKey: @"Addr_1"] forKey:@"addr1"];
        [newManagedObject setValue: [newDirectory valueForKey: @"Addr_2"] forKey:@"addr2"];
        [newManagedObject setValue: [newDirectory valueForKey: @"Phone_1"] forKey:@"phone1"];
        [newManagedObject setValue: [newDirectory valueForKey: @"Phone_2"] forKey:@"phone2"];
        [newManagedObject setValue: [newDirectory valueForKey: @"Website"] forKey:@"website"];
        [newManagedObject setValue: [newDirectory valueForKey: @"Email"] forKey:@"email"];
        
//        NSLog(@" newManagedObject is %@", newManagedObject);
        if (![managedObjectContext save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
    }
    
}

@end