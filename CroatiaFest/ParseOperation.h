//
//  ParseOperation.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//
#import <Foundation/Foundation.h>

#define TABLE_FEED_TAGS  @"appControl", @"cookingDemos", @"directory", @"exhibits", @"festivalActivities",@"food", @"performers", @"vendors", @"workshops", nil

#define APPCONTROL_FEED_TAGS @"Version", nil
#define EVENT_FEED_TAGS @"Name", @"Desc_1", @"Desc_2", @"Addr_1", @"Addr_2", @"Phone_1", @"Phone_2", @"Website", @"Email", @"Video", @"Performance_Date_1", @"Performance_Begin_Time_1", @"Performance_End_Time_1", @"Performance_Location_1", @"Performance_Date_2", @"Performance_Begin_Time_2", @"Performance_End_Time_2", @"Performance_Location_2", nil
#define MARKETPLACE_FEED_TAGS @"Name", @"Desc_1", @"Desc_2", @"Addr_1", @"Addr_2", @"Phone_1", @"Phone_2", @"Website", @"Email",nil


extern NSString *kAddFestivalNotif;
extern NSString *kFestivalResultsKey;

extern NSString *kFestivalErrorNotif;
extern NSString *kFestivalMsgErrorKey;

@class VersionController;

@interface ParseOperation : NSOperation

@property (nonatomic, strong) NSSet *tableItemNames;

@property (copy, readonly) NSData *parseData;
@property (nonatomic, strong) NSMutableDictionary *tableTagsDictionary;
@property (nonatomic, strong) NSMutableDictionary *currentItemDictionary;
@property (nonatomic, strong) NSMutableDictionary *parsedTablesDictionary;
@property (nonatomic, strong) NSString *currentElementName;
@property (nonatomic, strong) NSString *currentTableName;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (id)initWithData:(NSData *)data;



@end
