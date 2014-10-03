//
//  CroatiaFestAppDelegate.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/10/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RootViewController.h"

extern NSString *kNotificationDestroyAllNSFetchedResultsControllers;

//@interface CroatiaFestAppDelegate : NSObject <UIApplicationDelegate, NSXMLParserDelegate, NSFetchedResultsControllerDelegate> {
//@interface CroatiaFestAppDelegate : NSObject <UIApplicationDelegate,  NSFetchedResultsControllerDelegate> {
//@interface CroatiaFestAppDelegate : UIResponder <UIApplicationDelegate,  NSFetchedResultsControllerDelegate> {
@interface CroatiaFestAppDelegate : UIResponder <UIApplicationDelegate> {


@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;

    // for downloading the xml data
    NSURLConnection *webConnection;
    NSMutableData *__weak festivalData;
    NSOperationQueue *parseQueue; 
    
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
//@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void) deletePersistentStore;

@end
