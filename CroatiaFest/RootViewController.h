//
//  RootViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/10/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface RootViewController : UIViewController <NSFetchedResultsControllerDelegate> {
    UIAlertView *savedAlert_;
@private 
    
}
@property (nonatomic, retain) IBOutlet UIAlertView *savedAlert;

- (void) applicationWillResignActive: (NSNotification *) note;


@end
