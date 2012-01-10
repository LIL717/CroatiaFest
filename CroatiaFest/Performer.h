//
//  Performer.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Performer : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSString *websiteDesc;
@property (nonatomic, retain) NSDate *performanceTime;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)addPerformersToCoreData:(NSArray *)performers;

@end