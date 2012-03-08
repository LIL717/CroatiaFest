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

- (void)addPerformersToCoreData:(NSArray *)performers {
    LogMethod();
    //this is an array of dictionaries
    
    NSError *error = nil;
    // insert the performers into Core Data
    for (id newPerformer in performers) {

        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Performer" inManagedObjectContext:self.managedObjectContext];
        [newManagedObject setValue: [newPerformer valueForKey: @"Name"] forKey:@"name"];
        [newManagedObject setValue: [newPerformer valueForKey: @"Desc_1"] forKey:@"desc1"];
        [newManagedObject setValue: [newPerformer valueForKey: @"Desc_2"] forKey:@"desc2"];
        [newManagedObject setValue: [newPerformer valueForKey: @"Addr_1"] forKey:@"addr1"];
        [newManagedObject setValue: [newPerformer valueForKey: @"Addr_2"] forKey:@"addr2"];
        [newManagedObject setValue: [newPerformer valueForKey: @"Phone_1"] forKey:@"phone1"];
        [newManagedObject setValue: [newPerformer valueForKey: @"Phone_2"] forKey:@"phone2"];
        [newManagedObject setValue: [newPerformer valueForKey: @"Website"] forKey:@"website"];
        [newManagedObject setValue: [newPerformer valueForKey: @"Email"] forKey:@"email"];
        [newManagedObject setValue: [newPerformer valueForKey: @"Video"] forKey:@"video"];

//        
//        // Convert string to date object
//        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
//        [dateFormatter setDateFormat:@"hh:mm:ss"];

//        [newManagedObject setValue: [dateFormatter dateFromString: [newPerformer valueForKey: @"Performance_Time"]] forKey:@"performanceTime"];
//        NSLog (@"newPerformer is %@ newManagedObject is %@", newPerformer, newManagedObject);
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
        
    }

}

@end
