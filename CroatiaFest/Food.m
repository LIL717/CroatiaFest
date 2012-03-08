//
//  Food.m
//  CroatiaFest
//
//  Created by Lori Hill on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Food.h"

@implementation Food
@dynamic name;
@dynamic desc1;
@dynamic desc2;
@dynamic addr1;
@dynamic addr2;
@dynamic phone1;
@dynamic phone2;
@dynamic website;
@dynamic email;

@synthesize managedObjectContext = managedObjectContext_;

- (void)addFoodToCoreData:(NSArray *)food {
    LogMethod();
    //this is an array of dictionaries
    
    NSError *error = nil;
    // insert the directory into Core Data
    for (id newFood in food) {
        
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:self.managedObjectContext];
        [newManagedObject setValue: [newFood valueForKey: @"Name"] forKey:@"name"];
        [newManagedObject setValue: [newFood valueForKey: @"Desc_1"] forKey:@"desc1"];
        [newManagedObject setValue: [newFood valueForKey: @"Desc_2"] forKey:@"desc2"];
        [newManagedObject setValue: [newFood valueForKey: @"Addr_1"] forKey:@"addr1"];
        [newManagedObject setValue: [newFood valueForKey: @"Addr_2"] forKey:@"addr2"];
        [newManagedObject setValue: [newFood valueForKey: @"Phone_1"] forKey:@"phone1"];
        [newManagedObject setValue: [newFood valueForKey: @"Phone_2"] forKey:@"phone2"];
        [newManagedObject setValue: [newFood valueForKey: @"Website"] forKey:@"website"];
        [newManagedObject setValue: [newFood valueForKey: @"Email"] forKey:@"email"];

        
        //        NSLog(@" newManagedObject is %@", newManagedObject);
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
    }
    
}

@end
