//
//  EventTypeViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Event;


@interface EventTypeViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Event *event_;
    NSString *eventType_;

}
@property (nonatomic, retain) Event *event;
@property (nonatomic, retain) NSString *eventType;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


- (id)initWithEventType:(NSString *)eventType;

@end
