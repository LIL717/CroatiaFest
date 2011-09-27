//
//  EventViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface EventViewController : UITableViewController {
    NSArray *eventArray; 
    NSManagedObjectContext *managedObjectContext_;

}
@property (nonatomic, retain) NSArray *eventArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
