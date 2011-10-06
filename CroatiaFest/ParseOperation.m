//
//  ParseOperation.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ParseOperation.h"
#import "PerformerDataModel.h"
#import "VersionController.h"
//#import "DataModel.h"

// NSNotification name for sending Performer data back to the app delegate
NSString *kAddFestivalNotif = @"AddFestivalNotif";

// NSNotification userInfo key for obtaining the Performer data
NSString *kFestivalResultsKey = @"FestivalResultsKey";

// NSNotification name for reporting errors
NSString *kFestivalErrorNotif = @"FestivalErrorNotif";

// NSNotification userInfo key for obtaining the error message
NSString *kFestivalMsgErrorKey = @"FestivalMsgErrorKey";


@interface ParseOperation () <NSXMLParserDelegate>
@property (nonatomic, retain) VersionController *versionController;
@property (nonatomic, retain) PerformerDataModel *currentPerformerObject;
@property (nonatomic, retain) NSMutableArray *currentParseBatch;
@property (nonatomic, retain) NSMutableString *currentParsedCharacterData;
@end

@implementation ParseOperation

@synthesize parseData;
@synthesize versionController;
@synthesize currentPerformerObject;
@synthesize currentParsedCharacterData;
@synthesize currentParseBatch;

@synthesize currentItemDictionary;
@synthesize currentTableName;
@synthesize currentElementName;
@synthesize managedObjectContext = __managedObjectContext;



//- (id)initWithData:(NSData *)data model:(DataModel *)model
- (id)initWithData:(NSData *)data

{
    LogMethod();

    if ((self = [super init])) {   
        tableItemNames = [[NSSet alloc] initWithObjects:TABLE_FEED_TAGS]; 
        columnItemNames = [[NSSet alloc] initWithObjects:COLUMN_FEED_TAGS]; 
        appControlItemNames = [[NSSet alloc] initWithObjects:APPCONTROL_FEED_TAGS];

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
    [currentPerformerObject release];
    [currentParsedCharacterData release];
    [currentParseBatch release];
    [tableItemNames release];
    [columnItemNames release];
    [appControlItemNames release];
    [__managedObjectContext release];

    
    [super dealloc];
}
- (void)addPerformerToList:(NSArray *)performers {
    LogMethod();
    assert([NSThread isMainThread]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddFestivalNotif
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObject:performers
                                                        forKey:kFestivalResultsKey]]; 
}

// the main function for this NSOperation, to start the parsing
- (void)main {
    LogMethod();
    self.currentParseBatch = [NSMutableArray array];
    self.currentParsedCharacterData = [NSMutableString string];
    
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
    
    // depending on the total number of Performers parsed, the last batch might not have been a
    // "full" batch, and thus not been part of the regular batch transfer. So, we check the count of
    // the array and, if necessary, send it to the main thread.
    //
    if ([self.currentParseBatch count] > 0) {
        [self performSelectorOnMainThread:@selector(addPerformerToList:)
                               withObject:self.currentParseBatch
                            waitUntilDone:NO];
    }
    
    self.currentPerformerObject = nil;
    self.currentParsedCharacterData = nil;
    
    [parser release];
}

#pragma mark -
#pragma mark Parser constants

// Limit the number of parsed performers to 50
//
static const const NSUInteger kMaximumNumberOfPerformersToParse = 150;

// When an performer object has been fully constructed, it must be passed to the main thread and
// the table view in PerformerViewController must be reloaded to display it. It is not efficient to do
// this for every performer object - the overhead in communicating between the threads and reloading
// the table exceed the benefit to the user. Instead, we pass the objects in batches, sized by the
// constant below. In your application, the optimal batch size will vary 
// depending on the amount of data in the object and other factors, as appropriate.
//
static NSUInteger const kSizeOfPerformerBatch = 20;

// Reduce potential parsing errors by using string constants declared in a single place.
static NSString * const kTableName = @"table";
static NSString * const kColumnName = @"column";

static NSString * const kElementName = @"Name";
static NSString * const kElementDesc = @"Desc";
static NSString * const kElementCity = @"City";
static NSString * const kElementWebsite = @"Website";
static NSString * const kElementPerformanceTime = @"Performance_Time";

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
    if (parsedPerformerCounter >= kMaximumNumberOfPerformersToParse) {
        // Use the flag didAbortParsing to distinguish between this deliberate stop
        // and other parser errors.
        //
        didAbortParsing = YES;
        [parser abortParsing];
    }
//    NSLog (@"elementName is %@", elementName);
//    NSLog (@"attributeDict is %@", attributeDict);

    if ([elementName isEqualToString:kTableName]) {
        NSString *tableName = [attributeDict valueForKey:@"name"];
        if ([tableItemNames containsObject:tableName]) {
            self.currentTableName = [[[NSString alloc] initWithString:tableName] autorelease];
            self.currentItemDictionary = [[[NSMutableDictionary alloc] initWithCapacity: [columnItemNames count]] autorelease];

        } else self.currentTableName = nil;
    } 
    if ([elementName isEqualToString:kColumnName]) {
        NSString *fieldName = [attributeDict valueForKey:@"name"];

        if (([self.currentTableName isEqualToString:@"appControl"] && [appControlItemNames containsObject:fieldName]) 
               ||
            ([self.currentTableName isEqualToString:@"performers"] && [columnItemNames containsObject:fieldName])) {
            self.currentElementName = [[[NSString alloc] initWithString:fieldName] autorelease];
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
//
//    NSLog (@" here is the data that is in the parsed string %@", self.currentParsedCharacterData);
//    NSLog(@"end element %@", elementName);
    if ([self.currentTableName isEqualToString:@"appControl"]) {
        if ([elementName isEqualToString:kColumnName]) {
            self.versionController = [[[VersionController alloc] init] autorelease];
            self.versionController.managedObjectContext = self.managedObjectContext;
            if ([self.versionController updateSavedVersion:self.currentParsedCharacterData]) {
                NSLog(@"yes versionHasChanged continue with parsing");
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
    if ([self.currentTableName isEqualToString:@"performers"]) {

    if ([elementName isEqualToString:kColumnName]) {
//        NSLog(@"currentElementName is %@", self.currentElementName);
//        NSLog(@"currentParsedCharacterData is %@", self.currentParsedCharacterData);
        [self.currentItemDictionary setValue:currentParsedCharacterData forKey:self.currentElementName];
        NSLog(@"currentItemDictionary is %@", self.currentItemDictionary);

    }
    else if ([elementName isEqualToString:kTableName]) {
        if ([self.currentParseBatch count] >= kMaximumNumberOfPerformersToParse) {
            [self performSelectorOnMainThread:@selector(addPerformerToList:)
                                   withObject:self.currentParseBatch
                                waitUntilDone:NO];
            self.currentParseBatch = [NSMutableArray array];
        } else {
            PerformerDataModel *performer = [[PerformerDataModel alloc] init];
            
            performer.name = [self.currentItemDictionary valueForKey:kElementName];
            performer.desc = [self.currentItemDictionary valueForKey:kElementDesc];
            performer.city = [self.currentItemDictionary valueForKey:kElementCity];
            performer.website = [self.currentItemDictionary valueForKey:kElementWebsite];

            // Convert string to date object
            NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
            [dateFormatter setDateFormat:@"hh:mm:ss"];
            performer.performanceTime = [dateFormatter dateFromString:[self.currentItemDictionary valueForKey:kElementPerformanceTime]];
            
//            [dataModel.itemsArray addObject:performer];
            [self.currentParseBatch addObject:performer];

            [performer release];

            parsedPerformerCounter++;

        }
        [currentParsedCharacterData release];
        currentParsedCharacterData = nil;
    }
    // Stop accumulating parsed character data. We won't start again until specific elements begin.
    accumulatingParsedCharacterData = NO;
    }
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
- (void)handlePerformerError:(NSError *)parseError {
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
        [self performSelectorOnMainThread:@selector(handlePerformerError:)
                               withObject:parseError
                            waitUntilDone:NO];
    }
}

@end
