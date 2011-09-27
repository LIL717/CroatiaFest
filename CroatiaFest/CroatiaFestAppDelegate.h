//
//  CroatiaFestAppDelegate.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RootViewController.h"
//@class Performer, PerformerViewController;
@class Performer;

@interface CroatiaFestAppDelegate : NSObject <UIApplicationDelegate, NSXMLParserDelegate> {

    Performer *performer_;
    
@private    
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
    //    PerformerViewController *performerViewController;
    

    // for downloading the xml data
    NSURLConnection *webConnection;
    NSMutableData *festivalData;
    NSOperationQueue *parseQueue;  
    

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) PerformerViewController *performerViewController;
@property (nonatomic, retain) Performer *performer;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
