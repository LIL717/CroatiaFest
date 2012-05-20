//
//  InsertSchedule.h
//  CroatiaFest
//
//  Created by Lori Hill on 3/18/12.
//  Copyright (c) 2012 CroatiaFest. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface InsertSchedule : NSManagedObject

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

-(void) formatScheduleData: scheduleData;


@end
