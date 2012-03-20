//
//  ScheduleDateFormatter.m
//  CroatiaFest
//
//  Created by Lori Hill on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleDateFormatter.h"

@implementation ScheduleDateFormatter

-(NSDictionary *) formatScheduleData: scheduleData {
    
    // Convert beginDate and BeginTime to an NSDate Object
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //        NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    //        [dateFormatter setLocale:usLocale];
    //        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"PDT"]];


    NSString *beginDateTimeString = [NSString stringWithFormat: @"%@ %@", [scheduleData valueForKey: @"dateString"], [scheduleData valueForKey: @"beginTimeString"]];
    NSString *endDateTimeString = [NSString stringWithFormat: @"%@ %@", [scheduleData valueForKey: @"dateString"], [scheduleData valueForKey: @"endTimeString"]];

    // the date from the xml file is assumed to be pm - the date formatter is already added 7 hours to adjust for local time zone, need to add 5 more hours to get correct time
    NSDate *beginTime = [dateFormatter dateFromString: beginDateTimeString];
    NSDate *endTime = [dateFormatter dateFromString: endDateTimeString];

    NSTimeInterval secondsInFiveHours = 5 * 60 * 60;
    NSDate *correctedBeginTime = [beginTime dateByAddingTimeInterval:secondsInFiveHours];
    NSDate *correctedEndTime = [endTime dateByAddingTimeInterval:secondsInFiveHours];
    
    NSDictionary *scheduleDataDictionary = [[[NSDictionary alloc] initWithObjectsAndKeys:
             correctedBeginTime, @"beginTime",
             correctedEndTime, @"endTime", nil] autorelease];
    
    return scheduleDataDictionary;

    //        NSLog (@"begin time is %@, end time is %@", beginDateTimeString, endDateTimeString);
}
@end
