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
@dynamic desc;
@dynamic sponsor;

@synthesize managedObjectContext = managedObjectContext_;

- (void)addFoodToCoreData:(NSArray *)food {
    LogMethod();
    //this is an array of dictionaries
    
    NSError *error = nil;
    // insert the directory into Core Data
    for (id newFood in food) {
        
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:self.managedObjectContext];
        [newManagedObject setValue: [newFood valueForKey: @"Name"] forKey:@"name"];
        [newManagedObject setValue: [newFood valueForKey: @"Desc"] forKey:@"desc"];
        [newManagedObject setValue: [newFood valueForKey: @"Contributing_sponsor"] forKey:@"sponsor"];

        
        //        NSLog(@" newManagedObject is %@", newManagedObject);
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
    }
    
}

@end
