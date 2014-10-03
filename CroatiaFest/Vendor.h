//
//  Vendor.h
//  CroatiaFest
//
//  Created by Lori Hill on 10/9/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Vendor : NSManagedObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc1;
@property (nonatomic, strong) NSString *desc2;
@property (nonatomic, strong) NSString *addr1;
@property (nonatomic, strong) NSString *addr2;
@property (nonatomic, strong) NSString *phone1;
@property (nonatomic, strong) NSString *phone2;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *email;

- (void)addVendorsToCoreData:(NSArray *)vendors;

@end
