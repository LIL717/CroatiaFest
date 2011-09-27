//
//  Version.m
//  CroatiaFest
//
//  Created by Lori Hill on 9/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Version.h"

@implementation Version

@dynamic number;

- (id)init {
    
    if ((self = [super init])) {
        self.number = 0;
    }
    
    return self;
}

@end
