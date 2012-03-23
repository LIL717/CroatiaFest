//
//  Performer.h
//  CroatiaFest
//
//  Created by Lori Hill on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

//@class Schedule;

@interface Performer : NSManagedObject

@property (nonatomic, retain) NSString * phone1;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * addr1;
@property (nonatomic, retain) NSString * phone2;
@property (nonatomic, retain) NSString * desc2;
@property (nonatomic, retain) NSString * desc1;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * addr2;
@property (nonatomic, retain) NSString * video;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *performanceTimes;

@end

//@interface Performer (CoreDataGeneratedAccessors)
//- (void)addPerformanceTimes:(NSSet *)value;
//@end
