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
@dynamic desc1;
@dynamic desc2;
@dynamic contact;
@dynamic addr1;
@dynamic addr2;
@dynamic phone1;
@dynamic phone2;
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