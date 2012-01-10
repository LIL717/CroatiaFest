//
//  ParseOperation.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

#define TABLE_FEED_TAGS @"appControl", @"directory", @"food", @"performers", @"vendors", @"workshops", nil

#define APPCONTROL_FEED_TAGS @"Version",  nil
#define DIRECTORY_FEED_TAGS @"Name", @"Desc_1", @"Contact", @"Addr_1", @"Addr_2", @"Phone_1", @"Phone_2", @"Website", @"Email", nil
#define FOOD_FEED_TAGS @"Name", @"Desc", @"Contributing_sponsor", nil
#define PERFORMER_FEED_TAGS @"Name", @"Desc", @"City", @"Website", @"Website_description", @"Performance_Time", nil
#define VENDOR_FEED_TAGS @"Name", @"Desc_1", @"Desc_2", @"Contact", @"Addr_1", @"Addr_2", @"Phone", @"Website", nil
#define WORKSHOP_FEED_TAGS @"Name", @"Presenter", @"Website", @"Desc", @"Panel_1", @"Panel_2", @"Panel_3", @"Panel_4", @"Panel_5", @"Panel_6", @"link_text", @"link", @"Time", nil

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


@end
