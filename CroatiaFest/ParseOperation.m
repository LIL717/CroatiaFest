//
//  ParseOperation.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ParseOperation.h"
//#import "PerformerDataModel.h"
#import "VersionController.h"
//#import "DataModel.h"

// NSNotification name for sending Festival data back to the app delegate
NSString *kAddFestivalNotif = @"AddFestivalNotif";

// NSNotification userInfo key for obtaining the Festival data
NSString *kFestivalResultsKey = @"FestivalResultsKey";

// NSNotification name for reporting errors
NSString *kFestivalErrorNotif = @"FestivalErrorNotif";

// NSNotification userInfo key for obtaining the error message
NSString *kFestivalMsgErrorKey = @"FestivalMsgErrorKey";


@interface ParseOperation () <NSXMLParserDelegate>
@property (nonatomic, retain) VersionController *versionController;
//@property (nonatomic, retain) PerformerDataModel *currentPerformerObject;
@property (nonatomic, retain) NSMutableArray *currentParseBatch;
@property (nonatomic, retain) NSMutableString *currentParsedCharacterData;
@end

@implementation ParseOperation

@synthesize parseData;
@synthesize versionController;
//@synthesize currentPerformerObject;
@synthesize currentParsedCharacterData;
@synthesize currentParseBatch;

@synthesize tableTagsDictionary;
@synthesize currentItemDictionary;
@synthesize parsedTablesDictionary;
@synthesize currentTableName;
@synthesize currentElementName;
@synthesize managedObjectContext = __managedObjectContext;



//- (id)initWithData:(NSData *)data model:(DataModel *)model
- (id)initWithData:(NSData *)data

{
    LogMethod();

    if ((self = [super init])) {   
        tableItemNames = [[NSSet alloc] initWithObjects:TABLE_FEED_TAGS]; 
        self.tableTagsDictionary = [[[NSMutableDictionary alloc] initWithCapacity: [tableItemNames count]] autorelease];
        self.parsedTablesDictionary = [[[NSMutableDictionary alloc] initWithCapacity:[tableItemNames count]] autorelease];

//        appControlItemNames = [[NSSet alloc] initWithObjects:APPCONTROL_FEED_TAGS];
//        foodItemNames = [[NSSet alloc] initWithObjects:FOOD_FEED_TAGS];
//        performerItemNames = [[NSSet alloc] initWithObjects:PERFORMER_FEED_TAGS]; 
//        vendorItemNames = [[NSSet alloc] initWithObjects:VENDOR_FEED_TAGS]; 
//        workshopItemNames = [[NSSet alloc] initWithObjects:WORKSHOP_FEED_TAGS]; 
        
        [self.tableTagsDictionary setValue:[[[NSSet alloc] initWithObjects:APPCONTROL_FEED_TAGS] autorelease] forKey:@"appControl"];
        [self.tableTagsDictionary setValue:[[[NSSet alloc] initWithObjects:DIRECTORY_FEED_TAGS] autorelease] forKey:@"directory"];    
        [self.tableTagsDictionary setValue:[[[NSSet alloc] initWithObjects:FOOD_FEED_TAGS] autorelease] forKey:@"food"];
        [self.tableTagsDictionary setValue:[[[NSSet alloc] initWithObjects:PERFORMER_FEED_TAGS] autorelease] forKey:@"performers"];
        [self.tableTagsDictionary setValue:[[[NSSet alloc] initWithObjects:VENDOR_FEED_TAGS] autorelease] forKey:@"vendors"];
        [self.tableTagsDictionary setValue:[[[NSSet alloc] initWithObjects:WORKSHOP_FEED_TAGS] autorelease] forKey:@"workshops"];


//        NSLog (@"tableTagsDictionary for performers is %@", [self.tableTagsDictionary objectForKey:@"performers"]);
//        NSLog (@"tableTagsDictionary is %@", self.tableTagsDictionary);
//        dataModel = [[DataModel alloc] init];
        
//        dataModel = model;
        parseData = [data copy];

    }
    return self;
}
- (void)dealloc {
    LogMethod();
    
    [parseData release];
    [versionController release];
//    [currentPerformerObject release];
    [currentParsedCharacterData release];
    [currentParseBatch release];
    [tableItemNames release];
//    [appControlItemNames release];
//    [foodItemNames release];
//    [performerItemNames release];
//    [vendorItemNames release];
//    [workshopItemNames release];


    [__managedObjectContext release];

    
    [super dealloc];
}
//- (void)addPerformerToList:(NSArray *)performers {
- (void)distributeParsedData:(NSDictionary *)parsedData {

    LogMethod();
    assert([NSThread isMainThread]);
    NSLog (@" parsedData %@", parsedData);
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddFestivalNotif
                                                        object:self
//                                                      userInfo:[NSDictionary dictionaryWithObject:performers
                                                        userInfo:[NSDictionary dictionaryWithObject:parsedData
                                                        forKey:kFestivalResultsKey]]; 
}

// the main function for this NSOperation, to start the parsing
- (void)main {
    LogMethod();
    self.currentParseBatch = [NSMutableArray array];
    self.currentParsedCharacterData = [NSMutableString string];
    self.currentItemDictionary = [[[NSMutableDictionary alloc] initWithCapacity: [tableItemNames count]] autorelease];

    
    // It's also possible to have NSXMLParser download the data, by passing it a URL, but this is
    // not desirable because it gives less control over the network, particularly in responding to
    // connection errors.
    //
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.parseData];
    [parser setDelegate:self];
    [parser parse];
    
//    for (PerformerDataModel *performer in self.currentParseBatch) {
//        NSLog(@"name=%@, desc=%@, city=%@, website=%@, websiteDesc=%@", performer.name, performer.desc, performer.city, performer.website, performer.websiteDesc);
//    }
    
    // depending on the total number of reocrds parsed, the last batch might not have been a
    // "full" batch, and thus not been part of the regular batch transfer. So, we check the count of
    // the array and, if necessary, send it to the main thread.
    //
    if ([self.currentParseBatch count] > 0) {
//        [self performSelectorOnMainThread:@selector(addPerformerToList:)
//                               withObject:self.currentParseBatch
//                            waitUntilDone:NO];
        [self performSelectorOnMainThread:@selector(distributeParsedData:)
                               withObject:self.parsedTablesDictionary
                            waitUntilDone:NO];
    }
    
//    self.currentPerformerObject = nil;
    self.currentParsedCharacterData = nil;
    
    [parser release];
}

#pragma mark -
#pragma mark Parser constants

// Limit the number of parsed records 
//
//static const const NSUInteger kMaximumNumberOfRecordsToParse = 150;
static const NSUInteger kMaximumNumberOfRecordsToParse = 150;

// When an parsed object has been fully constructed, it must be passed to the main thread and
// loaded into Core Data.   It is not efficient to do
// this for every performer object - the overhead in communicating between the threads and reloading
// the table exceed the benefit to the user. Instead, we pass the objects in batches, sized by the
// constant below. In your application, the optimal batch size will vary 
// depending on the amount of data in the object and other factors, as appropriate.
//
static NSUInteger const kSizeOfParsedBatch = 20;

// Reduce potential parsing errors by using string constants declared in a single place.
static NSString * const kTableName = @"table";
static NSString * const kColumnName = @"column";

//static NSString * const kElementName = @"Name";
//static NSString * const kElementDesc = @"Desc";
//static NSString * const kElementCity = @"City";
//static NSString * const kElementWebsite = @"Website";
//static NSString * const kElementPerformanceTime = @"Performance_Time";

#pragma mark -
#pragma mark NSXMLParser delegate methods

- (void)parserDidStartDocument:(NSXMLParser *)parser {
//    LogMethod();
    
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    dataModel.itemsArray = array;
//    [array release];
    
    self.currentItemDictionary = nil;
	self.currentElementName = nil;
	self.currentParsedCharacterData = nil;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
//    LogMethod();

//    NSLog(@"start element ************%@", elementName);

    // If the number of parsed Performer is greater than
    // kMaximumNumberOfPerformersToParse, abort the parse.
    //
    if (parsedRecordCounter >= kMaximumNumberOfRecordsToParse) {
        // Use the flag didAbortParsing to distinguish between this deliberate stop
        // and other parser errors.
        //
        didAbortParsing = YES;
        [parser abortParsing];
    }
    NSLog (@"elementName is %@", elementName);
    NSLog (@"attributeDict is %@", attributeDict);

    if ([elementName isEqualToString:kTableName]) {
        
        if ([[attributeDict valueForKey:@"name"] isEqualToString: self.currentTableName] || self.currentTableName == nil) {
                
            } else {
                //if the table is a different type from the previous one, need put previous table's data into passing dictionary and init
                //put the array in the dictionary with the type of table for the key
                [self.parsedTablesDictionary setValue:self.currentParseBatch forKey:self.currentTableName];
                NSLog (@" parsedTablesDictionary is %@", self.parsedTablesDictionary);
                
                if ([self.currentParseBatch count] >= kSizeOfParsedBatch) {
                    //pass the dictionary
                    [self performSelectorOnMainThread:@selector(distributeParsedData:)
                                           withObject:self.parsedTablesDictionary
                                        waitUntilDone:NO];
//                    [self.parsedTablesDictionary removeAllObjects];
                }
                self.currentParseBatch = [NSMutableArray array];
            }
        self.currentTableName = [[[NSString alloc] initWithString:[attributeDict valueForKey:@"name"]] autorelease];

//        NSString *tableName = [attributeDict valueForKey:@"name"];
//        if ([tableItemNames containsObject:tableName]) {
        if ([tableItemNames containsObject:self.currentTableName ]) {

//            self.currentTableName = [[[NSString alloc] initWithString:tableName] autorelease];
            NSSet *itemNames = [[[NSSet alloc] initWithSet:[self.tableTagsDictionary valueForKey:self.currentTableName]] autorelease];
                                
            self.currentItemDictionary = [[[NSMutableDictionary alloc] initWithCapacity: [itemNames count]] autorelease];

//            self.currentItemDictionary = [[[NSMutableDictionary alloc] initWithCapacity: [performerItemNames count]] autorelease];

        } else self.currentTableName = nil;
    } 
    if ([elementName isEqualToString:kColumnName]) {
        self.currentElementName  = [[[NSString alloc] initWithString:[attributeDict valueForKey:@"name"]] autorelease];

//        if ([[self.tableTagsDictionary valueForKey:self.currentTableName] containsObject:fieldName]) {
        if ([[self.tableTagsDictionary valueForKey:self.currentTableName] containsObject:self.currentElementName]) {

//        if (([self.currentTableName isEqualToString:@"appControl"] && [appControlItemNames containsObject:fieldName]) 
//               ||
//            ([self.currentTableName isEqualToString:@"performers"] && [performerItemNames containsObject:fieldName])) {
//            self.currentElementName = [[[NSString alloc] initWithString:fieldName] autorelease];
                // The mutable string needs to be reset to empty.
                currentParsedCharacterData = [[NSMutableString alloc] init];

                // For the 'column' element begin accumulating parsed character data.
                // The contents are collected in parser:foundCharacters:.
                accumulatingParsedCharacterData = YES;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName 
{   
//    LogMethod();

//    NSLog (@" here is the data that is in the parsed string %@", self.currentParsedCharacterData);
//    NSLog(@"end element %@", elementName);
    if ([self.currentTableName isEqualToString:@"appControl"]) {
        if ([elementName isEqualToString:kColumnName]) {
            self.versionController = [[[VersionController alloc] init] autorelease];
            self.versionController.managedObjectContext = self.managedObjectContext;
            if ([self.versionController updateSavedVersion:self.currentParsedCharacterData]) {
                NSLog(@"yes versionHasChanged continue with parsing");
                //need to skip to next table type
            } else {
                // no need to parse data if version has not changed because data that has been
                //stored in Core Data will be used.
                //Use the flag didAbortParsing to distinguish between this deliberate stop
                // and other parser errors.
                //
                didAbortParsing = YES;
                [parser abortParsing];
            }
        }
    }

    if ([elementName isEqualToString:kColumnName]) {
        NSLog(@"currentElementName is %@", self.currentElementName);
        NSLog(@"currentParsedCharacterData is %@", self.currentParsedCharacterData);
        [self.currentItemDictionary setValue:currentParsedCharacterData forKey:self.currentElementName];
        [currentParsedCharacterData release];
        currentParsedCharacterData = nil;
        NSLog (@"currentItemDictionary is %@", self.currentItemDictionary);

    }
    else if ([elementName isEqualToString:kTableName]) {
        [self.currentParseBatch addObject:self.currentItemDictionary];

        NSLog (@" currentItemDictionary is %@", self.currentItemDictionary);
        NSLog (@" currentParseBatch is %@", self.currentParseBatch);
                
        parsedRecordCounter++;
        
    }
    // Stop accumulating parsed character data. We won't start again until specific elements begin.
    accumulatingParsedCharacterData = NO;
}

// This method is called by the parser when it find parsed character data ("PCDATA") in an element.
// The parser is not guaranteed to deliver all of the parsed character data for an element in a single
// invocation, so it is necessary to accumulate character data until the end of the element is reached.
//
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

    if (accumulatingParsedCharacterData) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        //
        [self.currentParsedCharacterData appendString:string];
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    LogMethod();
}

// an error occurred while parsing the Performer data,
// post the error as an NSNotification to our app delegate.
// 
- (void)handleParsedDataError:(NSError *)parseError {
    LogMethod();

    [[NSNotificationCenter defaultCenter] postNotificationName:kFestivalErrorNotif
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObject:parseError
                                                                                           forKey:kFestivalMsgErrorKey]];
}

// an error occurred while parsing the Performer data,
// pass the error to the main thread for handling.
// (note: don't report an error if we aborted the parse due to a max limit of Performer)
//
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    LogMethod();

    if ([parseError code] != NSXMLParserDelegateAbortedParseError && !didAbortParsing)
    {
        [self performSelectorOnMainThread:@selector(handleParsedDataError:)
                               withObject:parseError
                            waitUntilDone:NO];
    }
}

@end