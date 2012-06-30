//
//  InsertSchedule.m
//  CroatiaFest
//
//  Created by Lori Hill on 3/18/12.
//  Copyright (c) 2012 CroatiaFest. All rights reserved.
//

#import "InsertSchedule.h"
#import "Schedule.h"

@implementation InsertSchedule

@synthesize managedObjectContext = managedObjectContext_;

- (void)dealloc {
    
    [managedObjectContext_ release];
    [super dealloc];
    
} 

-(void) formatScheduleData: scheduleData {

//    LogMethod();
    NSError *error = nil;
    
//    NSManagedObjectContext *context = self.managedObjectContext;
    // Convert beginDate and BeginTime to an NSDate Object
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"PDT"]];


    NSString *beginDateTimeString = [NSString stringWithFormat: @"%@ %@", [scheduleData valueForKey: @"dateString"], [scheduleData valueForKey: @"beginTimeString"]];
    NSString *endDateTimeString = [NSString stringWithFormat: @"%@ %@", [scheduleData valueForKey: @"dateString"], [scheduleData valueForKey: @"endTimeString"]];

    // the date from the xml file is assumed to be pm - the date formatter is already added 7 hours to adjust for local time zone, need to add 5 more hours to get correct time
    NSDate *beginTime = [dateFormatter dateFromString: beginDateTimeString];
    NSDate *endTime = [dateFormatter dateFromString: endDateTimeString];

    //this is ugly but it works - dates come in in the format 12:30:00 everything is assumed to be pm because CroatiaFest is only in the afternoon, the time needs to be manipulated so that the times that begin with 12:00 convert to pm rather than am  so the hour is checked and if its 12 it is set back 12 hours 
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:beginTime];
    NSInteger hour = [components hour];
    
    NSTimeInterval timeInterval = 0;
    if (hour == 12) {
        timeInterval = -7 * 60 * 60;
    }
    else {
        timeInterval = 5 * 60 * 60;
    }
    
    NSDate *correctedBeginTime = [beginTime dateByAddingTimeInterval:timeInterval];
    NSDate *correctedEndTime = [endTime dateByAddingTimeInterval:timeInterval];
    
    Schedule *schedule = [NSEntityDescription insertNewObjectForEntityForName:@"Schedule" inManagedObjectContext:self.managedObjectContext];

    schedule.location = [scheduleData valueForKey: @"location"];
    schedule.beginTime = correctedBeginTime;
    schedule.endTime = correctedEndTime;
    schedule.event = [scheduleData valueForKey: @"event"];

    //            performer.performanceTime = schedule; ^^ OMG only need one of these - don't use both!!! 
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
    }

    return;

}
@end
