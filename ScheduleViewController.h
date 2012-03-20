//
//  ScheduleViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Schedule;


@interface ScheduleViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Schedule *schedule_;
    
}
@property (nonatomic, retain) Schedule *schedule;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end