//
//  Food.h
//  CroatiaFest
//
//  Created by Lori Hill on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Food : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *sponsor;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)addFoodToCoreData:(NSArray *)food;

@end
