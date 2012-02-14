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
@property (nonatomic, retain) NSString *desc1;
@property (nonatomic, retain) NSString *desc2;
@property (nonatomic, retain) NSString *contact;
@property (nonatomic, retain) NSString *addr1;
@property (nonatomic, retain) NSString *addr2;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *website;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)addVendorsToCoreData:(NSArray *)vendors;

@end
