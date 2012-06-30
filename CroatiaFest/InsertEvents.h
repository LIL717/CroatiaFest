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
@property (nonatomic, retain) Schedule *schedule;
@property (nonatomic, retain) Event *event;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)addEventsToCoreData:(NSArray *)events forKey: (NSString *) eventType;


@end