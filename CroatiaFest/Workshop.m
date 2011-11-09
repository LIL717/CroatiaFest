//
//  Workshop.m
//  CroatiaFest
//
//  Created by Lori Hill on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Workshop.h"

@implementation Workshop
@dynamic name;
@dynamic presenter;
@dynamic website;
@dynamic desc;
@dynamic panel_1;
@dynamic panel_2;
@dynamic panel_3;
@dynamic panel_4;
@dynamic panel_5;
@dynamic panel_6;
@dynamic link_text;
@dynamic link;
@dynamic time;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (void)addWorkshopsToCoreData:workshops {
    
}

@end
