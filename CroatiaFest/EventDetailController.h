//
//  EventDetailController.h
//  CroatiaFest
//
//  Created by Lori Hill on 10/3/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Event;
@class Schedule;

@interface EventDetailController : UIViewController <UIScrollViewDelegate> {

    UITextField *name_;
    UITextField *desc1_;
    UITextView  *desc2_;
    UITextField *addr1_;
    UITextField *addr2_;
    UITextView *phone1_;
    UITextField *phone2_;
    UITextField *website_;
    UITextField *email_;
    UITextField *video_;
    UITextField *time_;
    UITableView *scheduleTableView_;
    UIButton *webButton_;


    
    Event *event_;
    Schedule *schedule_;
    NSArray *eventTimes_;
    
}
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *desc1;
@property (nonatomic, retain) IBOutlet UITextView  *desc2;
@property (nonatomic, retain) IBOutlet UITextField *addr1;
@property (nonatomic, retain) IBOutlet UITextField *addr2;
@property (nonatomic, retain) IBOutlet UITextView *phone1;
@property (nonatomic, retain) IBOutlet UITextField *phone2;
@property (nonatomic, retain) IBOutlet UITextField *website;
@property (nonatomic, retain) IBOutlet UITextField *email;
@property (nonatomic, retain) IBOutlet UITextField *video;
@property (nonatomic, retain) IBOutlet UITextField *time;
@property (nonatomic, retain) IBOutlet UITableView *scheduleTableView;
@property (nonatomic, retain) IBOutlet UIButton *webButton;

@property (nonatomic, retain) Event *event;
@property (nonatomic, retain) Schedule *schedule;
@property (nonatomic, retain) NSArray *eventTimes;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)launchWeb:(id)sender; 
- (void)watchVideo; 


@end
