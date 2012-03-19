//
//  Performer.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InsertPerformers.h"
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

//            NSDictionary *scheduleDataDictionary1 = [[NSDictionary alloc] initWithObjectsAndKeys:
            NSDictionary *scheduleData = [[NSDictionary alloc] initWithObjectsAndKeys:

                                 [newPerformer valueForKey: @"Performance_Location_1"], @"location",
                                 [newPerformer valueForKey: @"Performance_Date_1"], @"dateString",
                                 [newPerformer valueForKey: @"Performance_Begin_Time_1"], @"beginTimeString",
                                 [newPerformer valueForKey: @"Performance_End_Time_1"], @"endTimeString", nil];
        
//            [schedule addScheduleToCoreData: scheduleDataDictionary1];
            // Convert beginDate and BeginTime to an NSDate Object
            NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            //        NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
            //        [dateFormatter setLocale:usLocale];
            //        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"PDT"]];
            
            
            NSString *beginDateTimeString = [NSString stringWithFormat: @"%@ %@", [scheduleData valueForKey: @"dateString"], [scheduleData valueForKey: @"beginTimeString"]];
            NSString *endDateTimeString = [NSString stringWithFormat: @"%@ %@", [scheduleData valueForKey: @"dateString"], [scheduleData valueForKey: @"endTimeString"]];
            
            // the date from the xml file is assumed to be pm - the date formatter is already added 7 hours to adjust for local time zone, need to add 5 more hours to get correct time
            NSDate *beginDate = [dateFormatter dateFromString: beginDateTimeString];
            NSDate *endDate = [dateFormatter dateFromString: endDateTimeString];
            
            NSTimeInterval secondsInFiveHours = 5 * 60 * 60;
            NSDate *correctedBeginDate = [beginDate dateByAddingTimeInterval:secondsInFiveHours];
            NSDate *correctedEndDate = [endDate dateByAddingTimeInterval:secondsInFiveHours];
            
            //        NSLog (@"begin time is %@, end time is %@", beginDateTimeString, endDateTimeString);
            
            Schedule *schedule = [NSEntityDescription insertNewObjectForEntityForName:@"Schedule" inManagedObjectContext:context];
            schedule.location = [scheduleData valueForKey: @"location"];
            schedule.beginTime = correctedBeginDate;
            schedule.endTime = correctedEndDate;
           
//            performer.performanceTime = schedule; OMG only need one of these - don't use both!!!
            schedule.performer = performer;

            [scheduleData release];
//            [scheduleDataDictionary1 release];

        }
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
//        if (![[newPerformer valueForKey: @"Performance_Date_2"] isEqualToString: @"0000-00-00"]) {
//            Schedule *schedule = [[Schedule alloc] autorelease];
//            schedule.managedObjectContext = self.managedObjectContext;
//            
//            NSDictionary *scheduleDataDictionary2 = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                [newPerformer valueForKey: @"Performance_Location_2"], @"location",
//                                [newPerformer valueForKey: @"Performance_Date_2"], @"dateString",
//                                [newPerformer valueForKey: @"Performance_Begin_Time_2"], @"beginTimeString",
//                                [newPerformer valueForKey: @"Performance_End_Time_2"], @"endTimeString", nil];
//            
//            [schedule addScheduleToCoreData: scheduleDataDictionary2];
//            [scheduleDataDictionary2 release];
//            performer.performanceTime = schedule; 
//
//        }
        
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

@end
