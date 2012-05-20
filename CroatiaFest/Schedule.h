//
//  Schedule.h
//  CroatiaFest
//
//  Created by Lori Hill on 3/16/12.
//  Copyright (c) 2012 CroatiaFest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

@interface Schedule : NSManagedObject

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSDate * beginTime;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) Event *event;


@end
