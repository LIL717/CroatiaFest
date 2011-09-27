//
//  ParseOperation.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ParseOperation.h"
#import "PerformerDataModel.h"
//#import "DataModel.h"

// NSNotification name for sending Performer data back to the app delegate
NSString *kAddPerformerNotif = @"AddPerformerNotif";

// NSNotification userInfo key for obtaining the Performer data
NSString *kPerformerResultsKey = @"PerformerResultsKey";

// NSNotification name for reporting errors
NSString *kPerformerErrorNotif = @"PerformerErrorNotif";

// NSNotification userInfo key for obtaining the error message
NSString *kPerformerMsgErrorKey = @"PerformerMsgErrorKey";


@interface ParseOperation () <NSXMLParserDelegate>
@property (nonatomic, retain) PerformerDataModel *currentPerformerObject;
@property (nonatomic, retain) NSMutableArray *currentParseBatch;
@property (nonatomic, retain) NSMutableString *currentParsedCharacterData;
@end

@implementation ParseOperation

//@synthesize parseData, dataModel, currentPerformerObject, currentParsedCharacterData, currentParseBatch;
//@synthesize dataModel, currentPerformerObject, currentParsedCharacterData, currentParseBatch;
@synthesize parseData, currentPerformerObject, currentParsedCharacterData, currentParseBatch;

@synthesize currentItemDictionary;
@synthesize currentTableName;
@synthesize currentElementName;


//- (id)initWithData:(NSData *)data model:(DataModel *)model
- (id)initWithData:(NSData *)data

{
    LogMethod();

    if ((self = [super init])) {   
        tableItemNames = [[NSSet alloc] initWithObjects:TABLE_FEED_TAGS]; 
        columnItemNames = [[NSSet alloc] initWithObjects:COLUMN_FEED_TAGS]; 

//        dataModel = [[DataModel alloc] init];
//        dataModel = model;
        parseData = [data copy];
        
//        dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//        [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
//        [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    }
    return self;
}
- (void)dealloc {
    LogMethod();
    
    [parseData release];
    [currentPerformerObject release];
    [currentParsedCharacterData release];
    [currentParseBatch release];
    //    [dateFormatter release];
    [tableItemNames release];
    [columnItemNames release];
    
    [super dealloc];
}
- (void)addPerformerToList:(NSArray *)performers {
    LogMethod();
    assert([NSThread isMainThread]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddPerformerNotif
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObject:performers
                                                        forKey:kPerformerResultsKey]]; 
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
    
 //   self.currentParseBatch = nil;
    self.currentPerformerObject = nil;
    self.currentParsedCharacterData = nil;
    
    [parser release];
}

#pragma mark -
#pragma mark Parser constants

// Limit the number of parsed performers to 50
//
static const const NSUInteger kMaximumNumberOfPerformersToParse = 50;

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
        if ([self.currentTableName isEqualToString:@"performers"]) {
        NSString *fieldName = [attributeDict valueForKey:@"name"];
        if ([columnItemNames containsObject:fieldName]) {
            self.currentElementName = [[[NSString alloc] initWithString:fieldName] autorelease];
//            NSLog(@"currentElementName is **************%@", currentElementName);
            // The mutable string needs to be reset to empty.
            currentParsedCharacterData = [[NSMutableString alloc] init];

            //self.currentElementName = fieldName;

        // For the 'column' element begin accumulating parsed character data.
        // The contents are collected in parser:foundCharacters:.
        accumulatingParsedCharacterData = YES;
//        [currentParsedCharacterData setString:@""];
        }
        }
    }
}
# pragma mark TODO: code to parse actual data  use self.currentParsedCharacterData that is where the stringed data is

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName 
{   
//    LogMethod();
//
//    NSLog (@" here is the data that is in the parsed string %@", self.currentParsedCharacterData);
//    NSLog(@"end element %@", elementName);
    if ([self.currentTableName isEqualToString:@"performers"]) {

    if ([elementName isEqualToString:kColumnName]) {
//        NSLog(@"currentElementName is %@", self.currentElementName);
//        NSLog(@"currentParsedCharacterData is %@", self.currentParsedCharacterData);
        [self.currentItemDictionary setValue:currentParsedCharacterData forKey:self.currentElementName];
//        NSLog(@"currentItemDictionary is %@", self.currentItemDictionary);

    }
    else if ([elementName isEqualToString:kTableName]) {
        if ([self.currentParseBatch count] >= kMaximumNumberOfPerformersToParse) {
            [self performSelectorOnMainThread:@selector(addPerformerToList:)
                                   withObject:self.currentParseBatch
                                waitUntilDone:NO];
            self.currentParseBatch = [NSMutableArray array];
        } else {
            PerformerDataModel *performer = [[PerformerDataModel alloc] init];
            
            performer.name = [self.currentItemDictionary valueForKey:@"Name"];
            performer.desc = [self.currentItemDictionary valueForKey:@"Desc"];
            performer.city = [self.currentItemDictionary valueForKey:@"City"];
            performer.website = [self.currentItemDictionary valueForKey:@"Website"];
            performer.websiteDesc = [self.currentItemDictionary valueForKey:@"Website_description"];
            
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

    [[NSNotificationCenter defaultCenter] postNotificationName:kPerformerErrorNotif
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObject:parseError
                                                                                           forKey:kPerformerMsgErrorKey]];
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
