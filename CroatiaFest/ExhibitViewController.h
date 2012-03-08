//
//  ExhibitViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Exhibit;


@interface ExhibitViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Exhibit *exhibit_;
    
}
@property (nonatomic, retain) Exhibit *exhibit;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end