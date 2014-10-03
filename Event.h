//
//  Event.h
//  CroatiaFest
//
//  Created by Lori Hill on 3/24/12.
//  Copyright (c) 2012 CroatiaFest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Schedule;

@interface Event : NSManagedObject

@property (nonatomic, strong) NSString * phone1;
@property (nonatomic, strong) NSString * website;
@property (nonatomic, strong) NSString * addr1;
@property (nonatomic, strong) NSString * phone2;
@property (nonatomic, strong) NSString * desc1;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * addr2;
@property (nonatomic, strong) NSString * video;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * desc2;
@property (nonatomic, strong) NSString * eventType;
@property (nonatomic, strong) NSSet *eventTimes;
@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addEventTimeObject:(Schedule *)value;
- (void)removeEventTimeObject:(Schedule *)value;
- (void)addEventTime:(NSSet *)values;
- (void)removeEventTime:(NSSet *)values;
@end
