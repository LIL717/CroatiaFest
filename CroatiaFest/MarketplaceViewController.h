//
//  MarketplaceViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/14/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>



@interface MarketplaceViewController : UITableViewController {
    NSArray *marketArray_; 
    NSManagedObjectContext *managedObjectContext_;
}
@property (nonatomic, retain) NSArray *marketArray; 
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@end
