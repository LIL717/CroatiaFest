//
//  Vendor.m
//  CroatiaFest
//
//  Created by Lori Hill on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Vendor.h"

@implementation Vendor

@dynamic name;
@dynamic desc_1;
@dynamic desc_2;
@dynamic contact;
@dynamic addr_1;
@dynamic addr_2;
@dynamic phone;
@dynamic website;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (void)addVendorsToCoreData:vendors {
    
}

@end
