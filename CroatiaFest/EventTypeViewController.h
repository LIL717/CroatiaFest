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
@property (nonatomic, strong) Event *event;
@property (nonatomic, strong) NSString *eventType;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


- (id)initWithEventType:(NSString *)eventType;

@end
