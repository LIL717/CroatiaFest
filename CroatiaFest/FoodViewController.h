//
//  FoodViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Food;


@interface FoodViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Food *food_;
    
}
@property (nonatomic, retain) Food *food;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end