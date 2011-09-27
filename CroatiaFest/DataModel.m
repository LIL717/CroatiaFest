//
//  DataModel.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataModel.h"


@implementation DataModel
@synthesize itemsArray;

- (id)init {
    
    if ((self = [super init])) {
        itemsArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)dealloc {
    
    [itemsArray release];
    
    [super dealloc];
}

@end
