//
//  FoodViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 1/14/12.
//  Copyright (c) 2012 CroatiaFest. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Food;


@interface FoodViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Food *food_;
    
}
@property (nonatomic, strong) Food *food;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end