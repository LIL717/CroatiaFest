//
//  VendorViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 1/14/12.
//  Copyright (c) 2012 CroatiaFest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Vendor;


@interface VendorViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Vendor *vendor_;
    
}
@property (nonatomic, strong) Vendor *vendor;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end