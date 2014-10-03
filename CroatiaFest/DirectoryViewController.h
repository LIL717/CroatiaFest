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
@property (nonatomic, strong) Directory *directory;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end