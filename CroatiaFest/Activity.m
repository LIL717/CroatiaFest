//
//  Activity.m
//  CroatiaFest
//
//  Created by Lori Hill on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Activity.h"

@implementation Activity
@dynamic name;
@dynamic desc1;
@dynamic desc2;
@dynamic addr1;
@dynamic addr2;
@dynamic phone1;
@dynamic phone2;
@dynamic website;
@dynamic email;
@dynamic video;

@synthesize managedObjectContext = managedObjectContext_;


- (void)addActivitiesToCoreData:(NSArray *)activities {
    LogMethod();
    //this is an array of dictionaries
    
    NSError *error = nil;
    // insert the performers into Core Data
    for (id newActivity in activities) {
        
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:self.managedObjectContext];
        [newManagedObject setValue: [newActivity valueForKey: @"Name"] forKey:@"name"];
        [newManagedObject setValue: [newActivity valueForKey: @"Desc_1"] forKey:@"desc1"];
        [newManagedObject setValue: [newActivity valueForKey: @"Desc_2"] forKey:@"desc2"];
        [newManagedObject setValue: [newActivity valueForKey: @"Addr_1"] forKey:@"addr1"];
        [newManagedObject setValue: [newActivity valueForKey: @"Addr_2"] forKey:@"addr2"];
        [newManagedObject setValue: [newActivity valueForKey: @"Phone_1"] forKey:@"phone1"];
        [newManagedObject setValue: [newActivity valueForKey: @"Phone_2"] forKey:@"phone2"];
        [newManagedObject setValue: [newActivity valueForKey: @"Website"] forKey:@"website"];
        [newManagedObject setValue: [newActivity valueForKey: @"Email"] forKey:@"email"];
        [newManagedObject setValue: [newActivity valueForKey: @"Video"] forKey:@"video"];
        
        //        // Convert string to date object
        //        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        //        [dateFormatter setDateFormat:@"hh:mm:ss"];
        //        [newManagedObject setValue: [dateFormatter dateFromString: [newActivity valueForKey: @"Time"]] forKey:@"presentationTime"];
        
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
        
    }
    
}

@end
