//
//  Schedule.h
//  CroatiaFest
//
//  Created by Lori Hill on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Performer;

@interface Schedule : NSManagedObject

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSDate * beginTime;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) Performer *performer;

@end
