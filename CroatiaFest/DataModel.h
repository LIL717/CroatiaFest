//
//  DataModel.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModel : NSObject {
    NSString *itemsType;
    NSMutableArray *itemsArray;
    
}
@property (nonatomic, retain) NSString *itemsType;
@property (nonatomic, retain) NSMutableArray *itemsArray;

@end
