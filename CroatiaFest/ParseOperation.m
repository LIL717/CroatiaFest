//
//  ParseOperation.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2012 CroatiaFest. All rights reserved.
//

#import "ParseOperation.h"
#import "VersionController.h"

// NSNotification name for sending Festival data back to the app delegate
NSString *kAddFestivalNotif = @"AddFestivalNotif";

// NSNotification userInfo key for obtaining the Festival data
NSString *kFestivalResultsKey = @"FestivalResultsKey";

// NSNotification name for reporting errors
NSString *kFestivalErrorNotif = @"FestivalErrorNotif";

// NSNotification userInfo key for obtaining the error message
NSString *kFestivalMsgErrorKey = @"FestivalMsgErrorKey";


@interface ParseOperation () <NSXMLParserDelegate>
@property (nonatomic, strong) VersionController *versionController;
@property (nonatomic) NSMutableArray *currentParseBatch;
@property (nonatomic) NSMutableString *currentParsedCharacterData;

@end

@implementation ParseOperation
{
	BOOL _accumulatingParsedCharacterData;
	BOOL _didAbortParsing;
	NSUInteger _parsedRecordCounter;
}


- (id)initWithData:(NSData *)data

{

	self = [super init];
	if (self) {
		_tableItemNames = [[NSSet alloc] initWithObjects:TABLE_FEED_TAGS];
        self.tableTagsDictionary = [[NSMutableDictionary alloc] initWithCapacity: [_tableItemNames count]];
        self.parsedTablesDictionary = [[NSMutableDictionary alloc] initWithCapacity:[_tableItemNames count]];


        [self.tableTagsDictionary setValue:[[NSSet alloc] initWithObjects:APPCONTROL_FEED_TAGS] forKey:@"appControl"];
        [self.tableTagsDictionary setValue:[[NSSet alloc] initWithObjects:EVENT_FEED_TAGS] forKey:@"cookingDemos"];
        [self.tableTagsDictionary setValue:[[NSSet alloc] initWithObjects:MARKETPLACE_FEED_TAGS] forKey:@"directory"];  
        [self.tableTagsDictionary setValue:[[NSSet alloc] initWithObjects:EVENT_FEED_TAGS] forKey:@"exhibits"];
        [self.tableTagsDictionary setValue:[[NSSet alloc] initWithObjects:EVENT_FEED_TAGS] forKey:@"festivalActivities"];
        [self.tableTagsDictionary setValue:[[NSSet alloc] initWithObjects:MARKETPLACE_FEED_TAGS] forKey:@"food"];
        [self.tableTagsDictionary setValue:[[NSSet alloc] initWithObjects:EVENT_FEED_TAGS] forKey:@"performers"];
        [self.tableTagsDictionary setValue:[[NSSet alloc] initWithObjects:MARKETPLACE_FEED_TAGS] forKey:@"vendors"];
        [self.tableTagsDictionary setValue:[[NSSet alloc] initWithObjects:EVENT_FEED_TAGS] forKey:@"workshops"];

        _parseData = [data copy];

    }
    return self;
}

- (void)distributeParsedData:(NSDictionary *)parsedData {

//    LogMethod();
    assert([NSThread isMainThread]);
//    NSLog (@" parsedData %@", parsedData);
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddFestivalNotif
                                                        object:self
                                                        userInfo:[NSDictionary dictionaryWithObject:parsedData
                                                        forKey:kFestivalResultsKey]]; 
}

// the main function for this NSOperation, to start the parsing
- (void)main {
//    LogMethod();
    self.currentParseBatch = [NSMutableArray array];
    self.currentParsedCharacterData = [NSMutableString string];
    self.currentItemDictionary = [[NSMutableDictionary alloc] initWithCapacity: [_tableItemNames count]];

    
    // It's also possible to have NSXMLParser download the data, by passing it a URL, but this is
    // not desirable because it gives less control over the network, particularly in responding to
    // connection errors.
    //
//    NSLog (@"parseData %@", self.parseData);
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.parseData];
    [parser setDelegate:self];
    [parser parse];
    
    // depending on the total number of reocrds parsed, the last batch might not have been a
    // "full" batch, and thus not been part of the regular batch transfer. So, we check the count of
    // the array and, if necessary, send it to the main thread.
    //
    if ([self.currentParseBatch count] > 0) {
        [self.parsedTablesDictionary setValue:self.currentParseBatch forKey:self.currentTableName];
        [self performSelectorOnMainThread:@selector(distributeParsedData:)
                               withObject:self.parsedTablesDictionary
                            waitUntilDone:NO];
    }
    self.currentParsedCharacterData = nil;
    self.currentParseBatch = nil;
    
}

#pragma mark -
#pragma mark Parser constants

// Limit the number of parsed records 
//
static const NSUInteger kMaximumNumberOfRecordsToParse = 150;

// When an parsed object has been fully constructed, it must be passed to the main thread and
// loaded into Core Data.   It is not efficient to do
// this for every festival object - the overhead in communicating between the threads and reloading
// the table exceed the benefit to the user. Instead, we pass the objects in batches, sized by the
// constant below. In your application, the optimal batch size will vary 
// depending on the amount of data in the object and other factors, as appropriate.
//
static NSUInteger const kSizeOfParsedBatch = 80;

// Reduce potential parsing errors by using string constants declared in a single place.
static NSString * const kTableName = @"table";
static NSString * const kColumnName = @"column";

#pragma mark -
#pragma mark NSXMLParser delegate methods

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
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

    // If the number of parsed records is greater than
    // kMaximumNumberOfRecordsToParse, abort the parse.
    //
    if (_parsedRecordCounter >= kMaximumNumberOfRecordsToParse) {
        // Use the flag didAbortParsing to distinguish between this deliberate stop
        // and other parser errors.
        //
        _didAbortParsing = YES;
        [parser abortParsing];
    }
//    NSLog (@"elementName is %@", elementName);
//    NSLog (@"attributeDict is %@", attributeDict);

    if ([elementName isEqualToString:kTableName]) {
        
        if ([[attributeDict valueForKey:@"name"] isEqualToString: self.currentTableName] || self.currentTableName == nil) {
                
            } else {
                //if the table is a different type from the previous one, need put previous table's data into passing dictionary and init
                //put the array in the dictionary with the type of table for the key
                [self.parsedTablesDictionary setValue:self.currentParseBatch forKey:self.currentTableName];
//                NSLog (@" parsedTablesDictionary is %@", self.parsedTablesDictionary);
                
                if ([self.currentParseBatch count] >= kSizeOfParsedBatch) {
                    //pass the dictionary
                    [self performSelectorOnMainThread:@selector(distributeParsedData:)
                                           withObject:self.parsedTablesDictionary
//                                        waitUntilDone:NO];
                                          waitUntilDone:YES];

                    self.currentParseBatch = [NSMutableArray array];
                    self.parsedTablesDictionary = [[NSMutableDictionary alloc] initWithCapacity:[_tableItemNames count]];


                }
                self.currentParseBatch = [NSMutableArray array];
            }
        self.currentTableName = [[NSString alloc] initWithString:[attributeDict valueForKey:@"name"]];

        if ([_tableItemNames containsObject:self.currentTableName ]) {
            NSSet *itemNames = [[NSSet alloc] initWithSet:[self.tableTagsDictionary valueForKey:self.currentTableName]];
            self.currentItemDictionary = [[NSMutableDictionary alloc] initWithCapacity: [itemNames count]];
        } else self.currentTableName = nil;
    } 
    if ([elementName isEqualToString:kColumnName]) {
        self.currentElementName  = [[NSString alloc] initWithString:[attributeDict valueForKey:@"name"]];

        if ([[self.tableTagsDictionary valueForKey:self.currentTableName] containsObject:self.currentElementName]) {

                // The mutable string needs to be reset to empty.
                _currentParsedCharacterData = [[NSMutableString alloc] init];

                // For the 'column' element begin accumulating parsed character data.
                // The contents are collected in parser:foundCharacters:.
                _accumulatingParsedCharacterData = YES;
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
            self.versionController = [[VersionController alloc] init];
            self.versionController.managedObjectContext = self.managedObjectContext;
            if ([self.versionController compareVersion:self.currentParsedCharacterData]) {
                NSLog(@"yes versionHasChanged continue with parsing");
                // skip to next table type
            } else {
                // no need to parse data if version has not changed because data that has been
                //stored in Core Data will be used.
                //Use the flag didAbortParsing to distinguish between this deliberate stop
                // and other parser errors.
                //
                _didAbortParsing = YES;
                [parser abortParsing];
            }
        }
    }

    if ([elementName isEqualToString:kColumnName]) {
//        NSLog(@"currentElementName is %@", self.currentElementName);
//        NSLog(@"currentParsedCharacterData is %@", self.currentParsedCharacterData);
        [self.currentItemDictionary setValue:_currentParsedCharacterData forKey:self.currentElementName];
        _currentParsedCharacterData = nil;
//        NSLog (@"currentItemDictionary is %@", self.currentItemDictionary);

    }
    else if ([elementName isEqualToString:kTableName]) {
//        NSLog (@" currentItemDictionary is %@", self.currentItemDictionary);

        [self.currentParseBatch addObject:self.currentItemDictionary];

//        NSLog (@" currentParseBatch is %@", self.currentParseBatch);
                
        _parsedRecordCounter++;
        
    }
    // Stop accumulating parsed character data. We won't start again until specific elements begin.
    _accumulatingParsedCharacterData = NO;
}

// This method is called by the parser when it finds parsed character data ("PCDATA") in an element.
// The parser is not guaranteed to deliver all of the parsed character data for an element in a single
// invocation, so it is necessary to accumulate character data until the end of the element is reached.
//
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

    if (_accumulatingParsedCharacterData) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        //
        [self.currentParsedCharacterData appendString:string];
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser {
//    LogMethod();
}

// an error occurred while parsing the Performer data,
// post the error as an NSNotification to our app delegate.
// 
- (void)handleParsedDataError:(NSError *)parseError {
    LogMethod();

    [[NSNotificationCenter defaultCenter] postNotificationName:kFestivalErrorNotif
                                                        object:self
                                                      userInfo:[NSDictionary 
                                            dictionaryWithObject:parseError
                                                        forKey:kFestivalMsgErrorKey]];
}

// an error occurred while parsing the Performer data,
// pass the error to the main thread for handling.
// (note: don't report an error if we aborted the parse due to a max limit of Performer)
//
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    LogMethod();

    if ([parseError code] != NSXMLParserDelegateAbortedParseError && !_didAbortParsing)
    {
        [self performSelectorOnMainThread:@selector(handleParsedDataError:)
                               withObject:parseError
                            waitUntilDone:NO];
    }
}

@end
