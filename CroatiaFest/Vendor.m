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
@dynamic desc1;
@dynamic desc2;
@dynamic contact;
@dynamic addr1;
@dynamic addr2;
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
