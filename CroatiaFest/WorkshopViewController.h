//
//  WorkshopViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Workshop;


@interface WorkshopViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Workshop *workshop_;
    
}
@property (nonatomic, retain) Workshop *workshop;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end