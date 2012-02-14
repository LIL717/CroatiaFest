//
//  ScheduleViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Performer;


@interface ScheduleViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Performer *performer_;
    
}
@property (nonatomic, retain) Performer *performer;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end