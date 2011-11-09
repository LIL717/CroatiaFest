//
//  DataModel.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataModel.h"


@implementation DataModel
@synthesize itemsType;
@synthesize itemsArray;

- (id)init {
    
    if ((self = [super init])) {
        itemsType = [[NSString alloc] init];
        itemsArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)dealloc {
    
    [itemsType release];
    [itemsArray release];
    
    [super dealloc];
}

@end
