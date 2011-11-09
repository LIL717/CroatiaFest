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
@property (nonatomic, retain) NSString *panel_1;
@property (nonatomic, retain) NSString *panel_2;
@property (nonatomic, retain) NSString *panel_3;
@property (nonatomic, retain) NSString *panel_4;
@property (nonatomic, retain) NSString *panel_5;
@property (nonatomic, retain) NSString *panel_6;
@property (nonatomic, retain) NSString *link_text;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSDate *time;

- (void)addWorkshopsToCoreData:(NSDictionary *)workshops;

@end
