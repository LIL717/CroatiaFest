//
//  DirectoryViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 1/10/12.
//  Copyright (c) 2012 CroatiaFest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Directory;


@interface DirectoryViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Directory *directory_;
    
}
@property (nonatomic, retain) Directory *directory;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end