//
//  VersionController.h
//  CroatiaFest
//
//  Created by Lori Hill on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
@class Version;

@interface VersionController  : NSObject {
    Version *version_;
}    

@property (nonatomic, retain) Version *version;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (BOOL) compareVersion: (NSString *) newVersionString;
- (void) insertVersion: (NSArray *) version;
-(NSNumber *) convertStringToNumber: (NSString *) newVersionString;


@end
