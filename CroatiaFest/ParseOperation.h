//
//  ParseOperation.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

//#define TABLE_FEED_TAGS @"appControl", @"performers", nil
#define TABLE_FEED_TAGS @"performers", nil

#define COLUMN_FEED_TAGS @"Name", @"Desc", @"City", @"Website", @"Website_description", @"Performance_Time", nil

extern NSString *kAddPerformerNotif;
extern NSString *kPerformerResultsKey;

extern NSString *kPerformerErrorNotif;
extern NSString *kPerformerMsgErrorKey;

@class PerformerDataModel;
//@class DataModel;

@interface ParseOperation : NSOperation {
    
    NSData *parseData;
    
    NSSet *tableItemNames;
    NSSet *columnItemNames;
    NSMutableDictionary *currentItemDictionary;
    NSString *currentTableName;
    NSString *currentElementName;


@private
//    NSDateFormatter *dateFormatter;
    
    // these variables are used during parsing
//    DataModel *dataModel;
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


//- (id)initWithData:(NSData *)data model:(DataModel *)model;

@end
