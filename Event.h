//
//  Event.h
//  CroatiaFest
//
//  Created by Lori Hill on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Schedule;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * phone1;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * addr1;
@property (nonatomic, retain) NSString * phone2;
@property (nonatomic, retain) NSString * desc1;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * addr2;
@property (nonatomic, retain) NSString * video;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc2;
@property (nonatomic, retain) NSString * eventType;
@property (nonatomic, retain) NSSet *eventTimes;
@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addEventTimeObject:(Schedule *)value;
- (void)removeEventTimeObject:(Schedule *)value;
- (void)addEventTime:(NSSet *)values;
- (void)removeEventTime:(NSSet *)values;
@end
