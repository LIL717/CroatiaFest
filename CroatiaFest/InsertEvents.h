//
//  InsertEvents.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import <CoreData/CoreData.h>
@class Schedule;
@class Event;

@interface InsertEvents : NSManagedObject {

    Schedule *schedule_;
    Event *event_;
}
@property (nonatomic, strong) Schedule *schedule;
@property (nonatomic, strong) Event *event;

- (void)addEventsToCoreData:(NSArray *)events forKey: (NSString *) eventType;


@end