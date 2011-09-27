//
//  CroatiaFestAppDelegate.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CroatiaFestAppDelegate.h"
#import "RootViewController.h"
#import "EventViewController.h"
#import "MarketplaceViewController.h"
#import "PerformerViewController.h"
#import "Performer.h"
#import "PerformerDataModel.h"
#import "ParseOperation.h"

// this framework was imported so we could use the kCFURLErrorNotConnectedToInternet error code
#import <CFNetwork/CFNetwork.h>

#pragma mark CroatiaFestAppDelegate () 

// forward declarations
@interface CroatiaFestAppDelegate ()

@property (nonatomic, retain) NSURLConnection *webConnection;
@property (nonatomic, retain) NSMutableData *festivalData;    // the data returned from the NSURLConnection
@property (nonatomic, retain) NSOperationQueue *parseQueue;     // the queue that manages our NSOperation for parsing performer data

- (void)addPerformersToList:(NSArray *)performers;
- (void)handleError:(NSError *)error;
@end

@implementation CroatiaFestAppDelegate

@synthesize window=_window;
@synthesize webConnection;
@synthesize festivalData;
@synthesize parseQueue;
//@synthesize performerViewController;
@synthesize performer = performer_;
@synthesize managedObjectContext = managedObjectContext_;
@synthesize managedObjectModel = managedObjectModel_;
@synthesize persistentStoreCoordinator = persistentStoreCoordinator_;

- (void)dealloc {

    [_window release];  
    [webConnection cancel];
    [webConnection release];
    [festivalData release];
//    [performerViewController release];
    [performer_ release];
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
    [parseQueue release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAddPerformerNotif object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPerformerErrorNotif object:nil];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    LogMethod ();
    // Override point for customization after application launch.
    
    //Create the tabBarController
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    //Create two view controllers
    RootViewController *rootViewController = [[RootViewController alloc] init];
    EventViewController *eventViewController = [[EventViewController alloc] init];
    eventViewController.managedObjectContext = self.managedObjectContext;

    MarketplaceViewController *marketplaceViewController = [[MarketplaceViewController alloc] init];
    
    //Create navigation controller
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:rootViewController];
    
    //Create navigation controller
    UINavigationController *navController2 = [[UINavigationController alloc]
                                              initWithRootViewController:eventViewController];
    
    //Create navigation controller
    UINavigationController *navController3 = [[UINavigationController alloc]
                                              initWithRootViewController:marketplaceViewController];
    
    
    //Make an array containing the two view controllers
    NSArray *viewControllers = [NSArray arrayWithObjects: navController, navController2, navController3, nil];
//    NSArray *viewControllers = [NSArray arrayWithObjects: navController, navController2,  nil];
//    NSArray *viewControllers = [NSArray arrayWithObjects: navController, nil];


    
    
    //The viewControllers array retains them so we can release our ownership of them in this method
    [rootViewController release];
    [eventViewController release];
    [marketplaceViewController release];
    
    
    //Attach them to the tab bar controller
    [tabBarController setViewControllers:viewControllers];
    
    //Set tabBar Controller as rootViewController of window
//    [self.window setRootViewController:tabBarController];
    self.window.rootViewController = tabBarController;

    [tabBarController release];
    
    [navController release];
    [navController2 release];
    [navController3 release];
    
    [self.window makeKeyAndVisible];
    
    
    // Use NSURLConnection to asynchronously download the data. This means the main thread will not
    // be blocked - the application will remain responsive to the user. 
    //
    // IMPORTANT! The main thread of the application should never be blocked!
    // Also, avoid synchronous network access on any thread.
    //
    static NSString *feedURLString = @"http://www.croatiafest.org/croatia4_tables.xml";
    NSURLRequest *performerURLRequest =
    [NSURLRequest requestWithURL:[NSURL URLWithString:feedURLString]];
    self.webConnection = [[[NSURLConnection alloc] initWithRequest:performerURLRequest delegate:self] autorelease];
    
    // Test the validity of the connection object. The most likely reason for the connection object
    // to be nil is a malformed URL, which is a programmatic error easily detected during development.
    // If the URL is more dynamic, then you should implement a more flexible validation technique,
    // and be able to both recover from errors and communicate problems to the user in an
    // unobtrusive manner.
    NSAssert(self.webConnection != nil, @"Failure to create URL connection.");
    
    // Start the status bar network activity indicator. We'll turn it off when the connection
    // finishes or experiences an error.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    parseQueue = [NSOperationQueue new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addPerformers:)
                                                 name:kAddPerformerNotif
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performerError:)
                                                 name:kPerformerErrorNotif
                                               object:nil];
    

    return YES;

}
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark -
#pragma mark NSURLConnection delegate methods

// The following are delegate methods for NSURLConnection. Similar to callback functions, this is
// how the connection object, which is working in the background, can asynchronously communicate back
// to its delegate on the thread from which it was started - in this case, the main thread.
//
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // check for HTTP status code for proxy authentication failures
    // anything in the 200 to 299 range is considered successful,
    // also make sure the MIMEType is correct:
    //
    //    LogMethod();
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    //    NSLog (@"httpResponse is %d", httpResponse.statusCode);
    //    NSLog (@"response.MIMEType is %@", response.MIMEType);
    //    if ((([httpResponse statusCode]/100) == 2) && [[response MIMEType] isEqual:@"application/atom+xml"]) {
    if ((([httpResponse statusCode]/100) == 2) && [[response MIMEType] isEqual:@"application/xml"]) {
        self.festivalData = [NSMutableData data];
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
                                  NSLocalizedString(@"HTTP Error",
                                                    @"Error message displayed when receving a connection error.")
                                                             forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
        [self handleError:error];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //    LogMethod();
    
    [festivalData appendData:data];
     //   NSLog (@"(performerData is %@", performerData);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    LogMethod();
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   
    if ([error code] == kCFURLErrorNotConnectedToInternet) {
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo =
        [NSDictionary dictionaryWithObject:
         NSLocalizedString(@"No Connection Error",
                           @"Error message displayed when not connected to the Internet.")
                                    forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                         code:kCFURLErrorNotConnectedToInternet
                                                     userInfo:userInfo];
        [self handleError:noConnectionError];
    } else {
        // otherwise handle the error generically
        [self handleError:error];
    }
    self.webConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //    LogMethod();
    
    self.webConnection = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   
    
    // Spawn an NSOperation to parse the performer data so that the UI is not blocked while the
    // application parses the XML data.
    //
    // IMPORTANT! - Don't access or affect UIKit objects on secondary threads.
    //
    //    DataModel *model = [[DataModel alloc] init];
    //    ParseOperation *parseOperation = [[ParseOperation alloc] initWithData:self.performerData model:model];
    
    ParseOperation *parseOperation = [[ParseOperation alloc] initWithData:self.festivalData];
    [self.parseQueue addOperation:parseOperation];
    [parseOperation release];   // once added to the NSOperationQueue it's retained, we don't need it anymore
    //    [model release];
    
    // performerData will be retained by the NSOperation until it has finished executing,
    // so we no longer need a reference to it in the main thread.
    self.festivalData = nil;
}
#pragma mark -
#pragma mark handle data coming from URL

// Handle errors in the download by showing an alert to the user. This is a very
// simple way of handling the error, partly because this application does not have any offline
// functionality for the user. Most real applications should handle the error in a less obtrusive
// way and provide offline functionality to the user.
//
- (void)handleError:(NSError *)error {
    LogMethod();
    
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView =
    [[UIAlertView alloc] initWithTitle:
     NSLocalizedString(@"Error Title",
                       @"Title for alert displayed when download or parse error occurs.")
                               message:errorMessage
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

// Our NSNotification callback from the running NSOperation to add the performers
//
- (void)addPerformers:(NSNotification *)notif {
    LogMethod();
    
    assert([NSThread isMainThread]);
    
    [self addPerformersToList:[[notif userInfo] valueForKey:kPerformerResultsKey]];
}

// Our NSNotification callback from the running NSOperation when a parsing error has occurred
//
- (void)performerError:(NSNotification *)notif {
    LogMethod();
    
    assert([NSThread isMainThread]);
    
    [self handleError:[[notif userInfo] valueForKey:kPerformerMsgErrorKey]];
}

// The NSOperation "ParseOperation" calls addPerformers: via NSNotification, on the main thread
// which in turn calls this method, with batches of parsed objects.
// The batch size is set via the kSizeOfPerformersBatch constant.
//
- (void)addPerformersToList:(NSArray *)performers {
    LogMethod();
    
    // insert the performers into Core Data
    
    NSError *error = nil;
    
    for (PerformerDataModel *newPerformer in performers) {
//        NSLog(@"name=%@, desc=%@, city=%@, website=%@, websiteDesc=%@", newPerformer.name, newPerformer.desc, newPerformer.city, newPerformer.website, newPerformer.websiteDesc);
        self.performer= [NSEntityDescription insertNewObjectForEntityForName:@"Performer" inManagedObjectContext:self.managedObjectContext];
        self.performer.name = newPerformer.name;
        self.performer.desc = newPerformer.desc;
        self.performer.city = newPerformer.city;
        self.performer.website = newPerformer.website;
        self.performer.websiteDesc = newPerformer.websiteDesc;
        
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
//        NSLog(@"performer in core data is %@", self.performer.name);
        
    }
}
#pragma mark -
#pragma mark save context method
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (managedObjectContext_ != nil)
    {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel_ != nil)
    {
        return managedObjectModel_;
    }
//    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"CroatiaFest" ofType:@"momd"];
//    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CroatiaFest" withExtension:@"momd"];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (persistentStoreCoordinator_ != nil)
    {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CroatiaFest.sqlite"];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
