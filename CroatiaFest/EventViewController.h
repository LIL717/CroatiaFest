//
//  EventViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/10/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface EventViewController : UITableViewController {
    NSArray *eventArray_; 
    NSManagedObjectContext *managedObjectContext_;

}
@property (nonatomic, strong) NSArray *eventArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


@end
