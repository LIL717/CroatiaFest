//
//  RootViewController.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/10/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation RootViewController
@synthesize savedAlert;
//@synthesize managedObjectContext = managedObjectContext_;
//@synthesize fetchedResultsController = fetchedResultsController_;

-(id)init
{
    self = [super init];
    //Call the superclass's designated initializer
    [super initWithNibName: nil
                    bundle:nil];
    //Get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
    
    //Give it a label
    [tbi setTitle:@"Festival"]; 
    
    //Create a UIImage from a file
    UIImage *i = [UIImage imageNamed:@"20px-Coat_of_arms_of_Croatia.png"];
    
    //Put that image on the tab bar item
    [tbi setImage:i];
    
    //Make a bar button for an alert
    
    
    UIImage *barButton = [[UIImage imageNamed:@"small-button-red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    
    [[UIBarButtonItem appearance] setBackgroundImage:barButton forState:UIControlStateNormal 
                                          barMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithTitle:@"Support" 
                                                                style:(UIBarButtonItemStyleBordered) 
                                                               target:self 
                                                               action:@selector(supportAlert)];
    [[self navigationItem] setRightBarButtonItem: button];
    [button release];
    
    [[self navigationItem] setTitle: @"Welcome"];
//    [self setTitle: @"Welcome"];

    
    
    //become observer for application going to background
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:[UIApplication sharedApplication]];
    
    return self;
}
// set the color and font of the title in the navigationBar (4.3 and lower)
//- (void)setTitle:(NSString *)title
//{
//    [super setTitle:title];
//    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
//    if (!titleView) {
//        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
//        titleView.backgroundColor = [UIColor clearColor];
////        titleView.font = [UIFont boldSystemFontOfSize:20.0];
//        titleView.font = [UIFont fontWithName:@"Chalkduster" size:20.0f];
//        titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
//        
//        titleView.textColor = [UIColor blueColor]; // Change to desired color
//        
//        self.navigationItem.titleView = titleView;
//        [titleView release];
//    }
//    titleView.text = title;
//    [titleView sizeToFit];
//}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [managedObjectContext_ release];
//    [fetchedResultsController_ release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


// // Override to allow orientations other than the default portrait orientation.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//	// Return YES for supported orientations.
//    return (interfaceOrientation ==  UIInterfaceOrientationPortrait || UIInterfaceOrientationLandscapeLeft)(interfaceOrientation);
//}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // autoresizing for autorotating
    self.view.autoresizesSubviews = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //code for CALayer
//    self.view.layer.contents = (id) [UIImage imageNamed:@"RedandWhiteCheckered.jpg"].CGImage;
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    self.savedAlert = nil;

}


- (void)supportAlert
{
    NSLog (@"myAlert");
    UIAlertView* alertView =
    [[UIAlertView alloc] initWithTitle:@"Please Donate" 
                               message:@"CroatiaFest needs your donations.  Please remember to drop your contribution in the donation box at the information booth." 
                              delegate:self 
                     cancelButtonTitle:@"OK" 
                     otherButtonTitles: nil];
    self.savedAlert = alertView;
    [alertView show];
    [alertView release];
    
}
//#pragma mark -
//#pragma mark UIAlertViewDelegate Methods
//
//- (void) alertView: (UIAlertView *) alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if (alertView == self.savedAlert) {
//        self.savedAlert = nil;
//        if (buttonIndex == [alertView cancelButtonIndex]) {
//            NSLog(@"alert cancel button pressed!");
//        }
//        else {
//            NSLog(@"alert action button pressed open webpage to support page!");
//        }
//    }
//}
- (void) applicationWillResignActive: (NSNotification *) note
{
//    NSLog(@"in applicationWillResignActive in RootViewController");
    [self.savedAlert dismissWithClickedButtonIndex: self.savedAlert.cancelButtonIndex animated:NO];
    self.savedAlert = nil;
}

@end
