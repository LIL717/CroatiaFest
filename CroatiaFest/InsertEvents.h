//
//  InsertEvents.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface InsertEvents : NSManagedObject 

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)addEventsToCoreData:(NSArray *)events forKey: (NSString *) eventType;


@end