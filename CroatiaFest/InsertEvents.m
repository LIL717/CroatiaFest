//
//  InsertEvents.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InsertEvents.h"
#import "InsertSchedule.h"
#import "Event.h"

@implementation InsertEvents

@synthesize managedObjectContext = managedObjectContext_;

- (void)addEventsToCoreData:(NSArray *)events forKey: (NSString *) eventType {
    LogMethod();
    //this is an array of dictionaries
    
    NSError *error = nil;
    // insert the events into Core Data
    for (id newEvent in events) {

        Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
        event.name = [newEvent valueForKey: @"Name"];
        event.desc1 = [newEvent valueForKey: @"Desc_1"];
        event.desc2 =[newEvent valueForKey: @"Desc_2"];
        event.addr1 = [newEvent valueForKey: @"Addr_1"];
        event.addr2 = [newEvent valueForKey: @"Addr_2"];
        event.phone1 = [newEvent valueForKey: @"Phone_1"];
        event.phone2 = [newEvent valueForKey: @"Phone_2"];
        event.website = [newEvent valueForKey: @"Website"];
        event.email = [newEvent valueForKey: @"Email"];
        event.video = [newEvent valueForKey: @"Video"];
        event.eventType = eventType;
        
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
        if (![[newEvent valueForKey: @"Performance_Date_1"] isEqualToString: @"0000-00-00"]) {
            NSDictionary *scheduleDataDictionary1 = [[[NSDictionary alloc] initWithObjectsAndKeys:
                  event, @"event",                    
                  [newEvent valueForKey: @"Performance_Location_1"], @"location",                     
                  [newEvent valueForKey: @"Performance_Date_1"], @"dateString",
                  [newEvent valueForKey: @"Performance_Begin_Time_1"], @"beginTimeString",
                  [newEvent valueForKey: @"Performance_End_Time_1"], @"endTimeString", nil] autorelease];
            
            InsertSchedule *scheduleDateFormatter1 = [[InsertSchedule alloc] autorelease];
            scheduleDateFormatter1.managedObjectContext = self.managedObjectContext;
            [scheduleDateFormatter1 formatScheduleData: scheduleDataDictionary1];
            
        }            
        
        if (![[newEvent valueForKey: @"Performance_Date_2"] isEqualToString: @"0000-00-00"]) {
            
            NSDictionary *scheduleDataDictionary2 = [[[NSDictionary alloc] initWithObjectsAndKeys:
                  event, @"event", 
                  [newEvent valueForKey: @"Performance_Location_2"], @"location",                     
                  [newEvent valueForKey: @"Performance_Date_2"], @"dateString",
                  [newEvent valueForKey: @"Performance_Begin_Time_2"], @"beginTimeString",
                  [newEvent valueForKey: @"Performance_End_Time_2"], @"endTimeString", nil] autorelease];
            
            InsertSchedule *scheduleDateFormatter2 = [[InsertSchedule alloc] autorelease];
            scheduleDateFormatter2.managedObjectContext = self.managedObjectContext;
            [scheduleDateFormatter2 formatScheduleData: scheduleDataDictionary2];
        }  
        
    }
    
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
@end
