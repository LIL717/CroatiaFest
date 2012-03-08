//
//  Activity.h
//  CroatiaFest
//
//  Created by Lori Hill on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Activity : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *desc1;
@property (nonatomic, retain) NSString *desc2;
@property (nonatomic, retain) NSString *addr1;
@property (nonatomic, retain) NSString *addr2;
@property (nonatomic, retain) NSString *phone1;
@property (nonatomic, retain) NSString *phone2;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *video;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)addActivitiesToCoreData:(NSArray *)activities;

@end