//
//  Workshop.h
//  CroatiaFest
//
//  Created by Lori Hill on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Workshop : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *presenter;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *panel1;
@property (nonatomic, retain) NSString *panel2;
@property (nonatomic, retain) NSString *panel3;
@property (nonatomic, retain) NSString *panel4;
@property (nonatomic, retain) NSString *panel5;
@property (nonatomic, retain) NSString *panel6;
@property (nonatomic, retain) NSString *linkText;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSDate *presentationTime;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)addWorkshopsToCoreData:(NSArray *)workshops;

@end
