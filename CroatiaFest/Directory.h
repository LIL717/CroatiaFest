//
//  Directory.h
//  CroatiaFest
//
//  Created by Lori Hill on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Directory : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *desc1;
@property (nonatomic, retain) NSString *desc2;
@property (nonatomic, retain) NSString *addr1;
@property (nonatomic, retain) NSString *addr2;
@property (nonatomic, retain) NSString *phone1;
@property (nonatomic, retain) NSString *phone2;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSString *email;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)addDirectoryToCoreData:(NSArray *)directory;
@end
