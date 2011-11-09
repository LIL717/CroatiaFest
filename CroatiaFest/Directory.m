//
//  Directory.m
//  CroatiaFest
//
//  Created by Lori Hill on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Directory.h"

@implementation Directory

@dynamic name;
@dynamic desc_1;
@dynamic contact;
@dynamic addr_1;
@dynamic addr_2;
@dynamic phone_1;
@dynamic phone_2;
@dynamic website;
@dynamic email;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (void)addDirectoryToCoreData:directory {
}
@end