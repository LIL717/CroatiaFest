//
//  CookingDemoViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class CookingDemo;


@interface CookingDemoViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    CookingDemo *cookingDemo_;
    
}
@property (nonatomic, retain) CookingDemo *cookingDemo;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
