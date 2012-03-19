//
//  Performer.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface InsertPerformers : NSManagedObject 

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)addPerformersToCoreData:(NSArray *)performers;

@end