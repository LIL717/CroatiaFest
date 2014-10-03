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

@property (nonatomic, strong) NSDate * endTime;
@property (nonatomic, strong) NSDate * beginTime;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) Event *event;


@end
