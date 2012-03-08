//
//  ActivityViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Activity;


@interface ActivityViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Activity *activity_;
    
}
@property (nonatomic, retain) Activity *activity;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
