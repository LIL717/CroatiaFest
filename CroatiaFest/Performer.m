//
//  Performer.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Performer.h"

@implementation Performer
@dynamic name;
@dynamic desc;
@dynamic city;
@dynamic website;
@dynamic websiteDesc;
@dynamic performanceTime;

@synthesize managedObjectContext = managedObjectContext_;

- (void)addPerformersToCoreData:(NSArray *)performers {
    LogMethod();
    //this is an array of dictionaries
    
    NSError *error = nil;
    // insert the performers into Core Data
    for (id newPerformer in performers) {

        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Performer" inManagedObjectContext:self.managedObjectContext];
        [newManagedObject setValue: [newPerformer valueForKey: @"Name"] forKey:@"name"];
        [newManagedObject setValue: [newPerformer valueForKey: @"Desc"] forKey:@"desc"];
        [newManagedObject setValue: [newPerformer valueForKey: @"City"] forKey:@"city"];
        [newManagedObject setValue: [newPerformer valueForKey: @"Website"] forKey:@"website"];
        
        // Convert string to date object
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"hh:mm:ss"];
        [newManagedObject setValue: [dateFormatter dateFromString: [newPerformer valueForKey: @"Performance_Time"]] forKey:@"performanceTime"];
        
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
        
    }

}

@end
