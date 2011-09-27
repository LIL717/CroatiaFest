//
//  PerformerViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Performer;


@interface PerformerViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Performer *performer_;

}
@property (nonatomic, retain) Performer *performer;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
