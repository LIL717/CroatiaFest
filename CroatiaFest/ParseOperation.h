//
//  ParseOperation.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

#define TABLE_FEED_TAGS @"activities", @"appControl", @"cookingDemos", @"directory", @"exhibits", @"food", @"performers", @"vendors", @"workshops", nil

#define APPCONTROL_FEED_TAGS @"Version",  nil
#define EVENT_FEED_TAGS @"Name", @"Desc_1", @"Desc_2", @"Addr_1", @"Addr_2", @"Phone_1", @"Phone_2", @"Website", @"Email", @"Video", @"Performance_Date_1", @"Performance_Begin_Time_1", @"Performance_End_Time_1", @"Performance_Location_1", @"Performance_Date_2", @"Performance_Begin_Time_2", @"Performance_End_Time_2", @"Performance_Location_2", nil
#define MARKETPLACE_FEED_TAGS @"Name", @"Desc_1", @"Desc_2", @"Addr_1", @"Addr_2", @"Phone_1", @"Phone_2", @"Website", @"Email",nil


extern NSString *kAddFestivalNotif;
extern NSString *kFestivalResultsKey;

extern NSString *kFestivalErrorNotif;
extern NSString *kFestivalMsgErrorKey;

@class VersionController;

@interface ParseOperation : NSOperation {
    
    NSData *parseData;
    
    NSSet *tableItemNames;

    NSMutableDictionary *tableTagsDictionary;
    NSMutableDictionary *currentItemDictionary;
    NSString *currentTableName;
    NSString *currentElementName;
    NSMutableDictionary *parsedTablesDictionary;


@private
    
    // these variables are used during parsing
    VersionController *versionController;

    NSMutableArray *currentParseBatch;
    NSMutableString *currentParsedCharacterData;
    
    
    BOOL accumulatingParsedCharacterData;
    BOOL didAbortParsing;
    NSUInteger parsedRecordCounter;
}

@property (copy, readonly) NSData *parseData;
@property (nonatomic, retain) NSMutableDictionary *tableTagsDictionary;
@property (nonatomic, retain) NSMutableDictionary *currentItemDictionary;
@property (nonatomic, retain) NSMutableDictionary *parsedTablesDictionary;
@property (nonatomic, retain) NSString *currentElementName;
@property (nonatomic, retain) NSString *currentTableName;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (id)initWithData:(NSData *)data;
- (void) deletePersistentStore;



@end
