//
//  Performer.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InsertPerformers.h"
#import "ScheduleDateFormatter.h"
#import "Schedule.h"
#import "Performer.h"

@implementation InsertPerformers

@synthesize managedObjectContext = managedObjectContext_;

- (void)addPerformersToCoreData:(NSArray *)performers {
    LogMethod();
    //this is an array of dictionaries
    

    // insert the performers into Core Data
    for (id newPerformer in performers) {

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
                
        
        if (![[newPerformer valueForKey: @"Performance_Date_1"] isEqualToString: @"0000-00-00"]) {

            NSDictionary *scheduleDataDictionary1 = [[[NSDictionary alloc] initWithObjectsAndKeys:
                                 [newPerformer valueForKey: @"Performance_Date_1"], @"dateString",
                                 [newPerformer valueForKey: @"Performance_Begin_Time_1"], @"beginTimeString",
                                 [newPerformer valueForKey: @"Performance_End_Time_1"], @"endTimeString", nil] autorelease];
        
            ScheduleDateFormatter *scheduleDateFormatter = [[ScheduleDateFormatter alloc] autorelease];
            NSDictionary *scheduleDates =[scheduleDateFormatter formatScheduleData: scheduleDataDictionary1];

            Schedule *schedule1 = [NSEntityDescription insertNewObjectForEntityForName:@"Schedule" inManagedObjectContext:context];
            schedule1.location = [newPerformer valueForKey: @"Performance_Location_1"];
            schedule1.beginTime = [scheduleDates valueForKey: @"beginTime"];
            schedule1.endTime = [scheduleDates valueForKey: @"endTime"];
           
            schedule1.performer = performer;
////            performer.performanceTime = schedule; ^^ OMG only need one of these - don't use both!!! 
            
//            [schedule1 setPerformer:performer];
        }

        if (![[newPerformer valueForKey: @"Performance_Date_2"] isEqualToString: @"0000-00-00"]) {
            
            NSDictionary *scheduleDataDictionary2 = [[[NSDictionary alloc] initWithObjectsAndKeys:
                                                      [newPerformer valueForKey: @"Performance_Date_1"], @"dateString",
                                                      [newPerformer valueForKey: @"Performance_Begin_Time_2"], @"beginTimeString",
                                                      [newPerformer valueForKey: @"Performance_End_Time_2"], @"endTimeString", nil] autorelease];
            
            ScheduleDateFormatter *scheduleDateFormatter = [[ScheduleDateFormatter alloc] autorelease];
            NSDictionary *scheduleDates =[scheduleDateFormatter formatScheduleData: scheduleDataDictionary2];
            
            Schedule *schedule2 = [NSEntityDescription insertNewObjectForEntityForName:@"Schedule" inManagedObjectContext:context];
            schedule2.location = [newPerformer valueForKey: @"Performance_Location_2"];
            schedule2.beginTime = [scheduleDates valueForKey: @"beginTime"];
            schedule2.endTime = [scheduleDates valueForKey: @"endTime"];
            
            schedule2.performer = performer;
////            performer.performanceTime = schedule; ^^ OMG only need one of these - don't use both!!! 
            
//            [schedule2 setPerformer:performer];
        }
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
        NSSet *set=[performer performanceTimes];
// Test listing all Performers from the store
        
        NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Performer" 
                                                  inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//        for (Performer *performer in fetchedObjects) {
        for (Performer *performer in fetchedObjects) {

            NSLog(@"Name: %@", performer.name);
            //        NSArray *timesArray = [performer.performanceTimes allObjects];
            for (Schedule *schedule in set) {
                NSLog(@"Begin Time: %@", schedule.beginTime);
            }
        }    
// end test 
        
    }
// Test listing all FailedBankInfos from the store
//    NSManagedObjectContext *context = self.managedObjectContext;
//    NSError *error = nil;
//
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Schedule" 
//                                              inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    for (Schedule *schedule in fetchedObjects) {
//        NSLog(@"Begin Time: %@", schedule.beginTime);
//        Performer *performer = schedule.performer;
//        NSLog(@"Performer name: %@", performer.name);
//    }        
//    [fetchRequest release];
}

//Entity1 *entity1=[NSEntityDescription insertNewObjectForEntityForName:@"Entity1" inManagedObjectContext:self.managedObjectContext];
//Entity2 *entity2=[NSEntityDescription insertNewObjectForEntityForName:@"Entity2" inManagedObjectContext:self.managedObjectContext];
//Entity2 *entity3=[NSEntityDescription insertNewObjectForEntityForName:@"Entity2" inManagedObjectContext:self.managedObjectContext];
//
//[entity2 setParentEntity:entity1];
//[entity3 setParentEntity:entity1];
//NSError *error;
//[[self managedObjectContext]save:&error];
//
//NSSet *set=[performer children];
@end
