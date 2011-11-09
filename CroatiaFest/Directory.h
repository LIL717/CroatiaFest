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
@property (nonatomic, retain) NSString *desc_1;
@property (nonatomic, retain) NSString *contact;
@property (nonatomic, retain) NSString *addr_1;
@property (nonatomic, retain) NSString *addr_2;
@property (nonatomic, retain) NSString *phone_1;
@property (nonatomic, retain) NSString *phone_2;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSString *email;

- (void)addDirectoryToCoreData:(NSDictionary *)directory;
@end
