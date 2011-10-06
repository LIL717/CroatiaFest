//
//  ParseOperation.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

#define TABLE_FEED_TAGS @"appControl", @"performers", nil

#define COLUMN_FEED_TAGS @"Name", @"Desc", @"City", @"Website", @"Website_description", @"Performance_Time", nil
#define APPCONTROL_FEED_TAGS @"Version",  nil

extern NSString *kAddFestivalNotif;
extern NSString *kFestivalResultsKey;

extern NSString *kFestivalErrorNotif;
extern NSString *kFestivalMsgErrorKey;

@class PerformerDataModel;
@class VersionController;

@interface ParseOperation : NSOperation {
    
    NSData *parseData;
    
    NSSet *tableItemNames;
    NSSet *columnItemNames;
    NSSet *appControlItemNames;
    NSMutableDictionary *currentItemDictionary;
    NSString *currentTableName;
    NSString *currentElementName;


@private
    
    // these variables are used during parsing
    VersionController *versionController;
    PerformerDataModel *currentPerformerObject;

    NSMutableArray *currentParseBatch;
    NSMutableString *currentParsedCharacterData;
    
    
    BOOL accumulatingParsedCharacterData;
    BOOL didAbortParsing;
    NSUInteger parsedPerformerCounter;
}

@property (copy, readonly) NSData *parseData;
//@property (nonatomic, retain) DataModel *dataModel;
@property (nonatomic, retain) NSMutableDictionary *currentItemDictionary;
@property (nonatomic, retain) NSString *currentElementName;
@property (nonatomic, retain) NSString *currentTableName;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@end
