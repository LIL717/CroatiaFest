//
//  PerformerDataModel.m
//  CroatiaFest
//
//  Created by Lori Hill on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PerformerDataModel.h"

@implementation PerformerDataModel
@synthesize name;
@synthesize desc;
@synthesize city;
@synthesize website;
@synthesize websiteDesc;
@synthesize performanceTime;



- (void)dealloc {
    [name release];
    [desc release];
    [city release];
    [website release];
    [websiteDesc release];
    [performanceTime release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
