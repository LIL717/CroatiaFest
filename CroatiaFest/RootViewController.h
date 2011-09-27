//
//  RootViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface RootViewController : UIViewController <NSFetchedResultsControllerDelegate> {


@private 
//    NSFetchedResultsController *fetchedResultsController_;
//    NSManagedObjectContext *managedObjectContext_;
    
}
@property (nonatomic, retain) IBOutlet UIAlertView *savedAlert;
//@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void) supportAlert;
- (void) applicationWillResignActive: (NSNotification *) note;


@end
