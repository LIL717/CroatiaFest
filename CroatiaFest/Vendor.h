//
//  Vendor.h
//  CroatiaFest
//
//  Created by Lori Hill on 10/9/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Vendor : NSManagedObject

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

- (void)addVendorsToCoreData:(NSArray *)vendors;

@end
