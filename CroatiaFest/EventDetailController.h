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

    Event *event_;
    Schedule *schedule_;
    NSArray *eventTimes_;
    
//    UIScrollView *scrollView_;
    
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
    

    
}
@property (nonatomic, strong) Event *event;
@property (nonatomic, strong) Schedule *schedule;
@property (nonatomic, strong) NSArray *eventTimes;

//@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet UITextField *name;
@property (nonatomic, strong) IBOutlet UITextField *desc1;
@property (nonatomic, strong) IBOutlet UITextView  *desc2;
@property (nonatomic, strong) IBOutlet UITextField *addr1;
@property (nonatomic, strong) IBOutlet UITextField *addr2;
@property (nonatomic, strong) IBOutlet UITextView *phone1;
@property (nonatomic, strong) IBOutlet UITextField *phone2;
@property (nonatomic, strong) IBOutlet UITextField *website;
@property (nonatomic, strong) IBOutlet UITextField *email;
@property (nonatomic, strong) IBOutlet UITextField *video;
@property (nonatomic, strong) IBOutlet UITextField *time;

@property (nonatomic, strong) IBOutlet UITableView *scheduleTableView;
@property (nonatomic, strong) IBOutlet UIButton *webButton;


@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


- (IBAction)launchWeb:(id)sender; 
- (void)watchVideo; 


@end
