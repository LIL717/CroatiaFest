//
//  PerformerDataModel.h
//  CroatiaFest
//
//  Created by Lori Hill on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerformerDataModel : NSObject {
@private

    // Name of performer.
    NSString *name;
    // Description of performer.
    NSString *desc;
    // City of performer.
    NSString *city;
    // Holds the URL to the performer's own web page.  The application uses this URL to open that page in Safari.
    NSURL *website;
    NSString *websiteDesc;
    //Date and time of performance
    NSDate *performanceTime;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSURL *website;
@property (nonatomic, retain) NSString *websiteDesc;
@property (nonatomic, retain) NSDate *performanceTime;
@end
