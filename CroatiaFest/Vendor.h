//
//  Vendor.h
//  CroatiaFest
//
//  Created by Lori Hill on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Vendor : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *desc_1;
@property (nonatomic, retain) NSString *desc_2;
@property (nonatomic, retain) NSString *contact;
@property (nonatomic, retain) NSString *addr_1;
@property (nonatomic, retain) NSString *addr_2;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *website;

- (void)addVendorsToCoreData:(NSDictionary *)vendors;
@end
