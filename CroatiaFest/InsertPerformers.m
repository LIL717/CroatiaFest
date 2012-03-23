//
//  Performer.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InsertPerformers.h"
#import "InsertSchedule.h"
//#import "Schedule.h"
#import "Performer.h"

@implementation InsertPerformers

@synthesize managedObjectContext = managedObjectContext_;

- (void)addPerformersToCoreData:(NSArray *)performers {
    LogMethod();
    //this is an array of dictionaries
    
    // insert the performers into Core Data
    for (id newPerformer in performers) {
        NSError *error = nil;

        NSManagedObjectContext *context = self.managedObjectContext;
        Performer *performer = [NSEntityDescription insertNewObjectForEntityForName:@"Performer" inManagedObjectContext:context];
        performer.name =  [newPerformer valueForKey: @"Name"];
        performer.desc1 = [newPerformer valueForKey: @"Desc_1"];
        performer.desc2 = [newPerformer valueForKey: @"Desc_2"];
        performer.addr1 = [newPerformer valueForKey: @"Addr_1"];
        performer.addr2 = [newPerformer valueForKey: @"Addr_2"];
        performer.phone1 = [newPerformer valueForKey: @"Phone_1"];
        performer.phone2 = [newPerformer valueForKey: @"Phone_2"];
        performer.website = [newPerformer valueForKey: @"Website"];
        performer.email = [newPerformer valueForKey: @"Email"];
        performer.video = [newPerformer valueForKey: @"Video"];
        
        if (![context save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
                
        if (![[newPerformer valueForKey: @"Performance_Date_1"] isEqualToString: @"0000-00-00"]) {
            NSDictionary *scheduleDataDictionary1 = [[[NSDictionary alloc] initWithObjectsAndKeys:
                         performer, @"performer",                    
                         [newPerformer valueForKey: @"Performance_Location_1"], @"location",                     
                         [newPerformer valueForKey: @"Performance_Date_1"], @"dateString",
                         [newPerformer valueForKey: @"Performance_Begin_Time_1"], @"beginTimeString",
                         [newPerformer valueForKey: @"Performance_End_Time_1"], @"endTimeString", nil] autorelease];

            InsertSchedule *scheduleDateFormatter1 = [[InsertSchedule alloc] autorelease];
            scheduleDateFormatter1.managedObjectContext = self.managedObjectContext;
            [scheduleDateFormatter1 formatScheduleData: scheduleDataDictionary1];

        }            

        if (![[newPerformer valueForKey: @"Performance_Date_2"] isEqualToString: @"0000-00-00"]) {

            
            NSDictionary *scheduleDataDictionary2 = [[[NSDictionary alloc] initWithObjectsAndKeys:
                      performer, @"performer", 
                      [newPerformer valueForKey: @"Performance_Location_2"], @"location",                     
                      [newPerformer valueForKey: @"Performance_Date_2"], @"dateString",
                      [newPerformer valueForKey: @"Performance_Begin_Time_2"], @"beginTimeString",
                      [newPerformer valueForKey: @"Performance_End_Time_2"], @"endTimeString", nil] autorelease];
            
            InsertSchedule *scheduleDateFormatter2 = [[InsertSchedule alloc] autorelease];
            scheduleDateFormatter2.managedObjectContext = self.managedObjectContext;
            [scheduleDateFormatter2 formatScheduleData: scheduleDataDictionary2];
            
        }    

//// Test listing all Performers from the store
//        NSSet *set=[performer performanceTimes];
//
//        NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
//        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Performer" 
//                                                  inManagedObjectContext:context];
//        [fetchRequest setEntity:entity];
//        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
////        for (Performer *performer in fetchedObjects) {
//        for (Performer *performer in fetchedObjects) {
//
//            NSLog(@"Name: %@", performer.name);
//            //        NSArray *timesArray = [performer.performanceTimes allObjects];
//            for (Schedule *schedule in set) {
//                NSLog(@"Begin Time: %@", schedule.beginTime);
//            }
//        }    
//// end test 
//        // Test listing all Schedule from the store
////        NSManagedObjectContext *context = self.managedObjectContext;
////        NSError *error = nil;
//        
//        NSFetchRequest *fetchRequest2 = [[[NSFetchRequest alloc] init] autorelease];
//        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Schedule" 
//                                                  inManagedObjectContext:context];
//        [fetchRequest2 setEntity:entity2];
//        NSArray *fetchedObjects2 = [context executeFetchRequest:fetchRequest2 error:&error];
//        for (Schedule *schedule in fetchedObjects2) {
//            NSLog(@"Begin Time: %@", schedule.beginTime);
//            Performer *performer = schedule.performer;
//            NSLog(@"Performer name: %@", performer.name);
//        }        
//        // end test        
    }

}

@end
