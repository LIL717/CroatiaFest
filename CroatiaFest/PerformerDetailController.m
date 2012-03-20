//
//  PerformerDetailController.m
//  CroatiaFest
//
//  Created by Lori Hill on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PerformerDetailController.h"
#import "Performer.h"
#import "Schedule.h"
#import "WebViewController.h"

@implementation PerformerDetailController

@synthesize performer = performer_;
@synthesize managedObjectContext = managedObjectContext_;

@synthesize name = name_;
@synthesize desc1 = desc1_;
@synthesize desc2 = desc2_;
@synthesize addr1 = addr1_;
@synthesize addr2 = addr2_;
@synthesize phone1 = phone1_;
@synthesize phone2 = phone2_;
@synthesize website = website_;
@synthesize email = email_;
@synthesize video = video_;
@synthesize time = time_;

- (void) dealloc {
    [performer_ release];
    [managedObjectContext_ release];
    [name_ release];
    [desc1_ release];
    [desc2_ release];
    [addr1_ release];
    [addr2_ release];
    [phone1_ release];
    [phone2_ release];
    [website_ release];
    [email_ release];
    [video_ release];
    [time_ release];

    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    LogMethod();
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.name.text = self.performer.name;
    self.desc1.text = self.performer.desc1;
    self.desc2.text = self.performer.desc2;
    self.addr1.text = self.performer.addr1;
    self.addr2.text = self.performer.addr2;
    self.phone1.text = self.performer.phone1;
    self.phone2.text = self.performer.phone2;
    self.website.text = self.performer.website;
    self.email.text = self.performer.email;
    self.video.text = self.performer.video;
    
//// Test listing all Performers from the store
//    NSManagedObjectContext *context = self.managedObjectContext;
//    NSError *error = nil;
//
//    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Performer" 
//                                              inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    for (Performer *performer in fetchedObjects) {
//        NSLog(@"Name: %@", performer.name);
////        NSArray *timesArray = [performer.performanceTimes allObjects];
//        for (Schedule *schedule in [performer performanceTimes ]) {
//            NSLog(@"Begin Time: %@", schedule.beginTime);
//        }
//
//    }    
//// end test    
    NSArray *performanceTimesArray = [self.performer.performanceTimes allObjects];
    
    Schedule *performanceTime = [performanceTimesArray objectAtIndex:0];
    
    NSTimeInterval secondsInFiveHours = 7 * 60 * 60;
    NSDate *correctedBeginDate = [performanceTime.beginTime dateByAddingTimeInterval:secondsInFiveHours];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm a"];
    self.time.text = [dateFormatter stringFromDate:correctedBeginDate];  
    [dateFormatter release];

    // Create "Watch Video" button for the nav bar if there is a video
    if (!isEmpty(self.performer.video)) {
        UIBarButtonItem *watchButton = [[UIBarButtonItem alloc] 
                                        initWithTitle:@"Watch Video" 
                                        style:(UIBarButtonItemStyleBordered) 
//                                        initWithBarButtonSystemItem:UIBarButtonSystemItemPlay 
                                        target:self 
                                        action:@selector(watchVideo)];
        [[self navigationItem] setRightBarButtonItem:watchButton];
        [watchButton release];
    }

}

// IBAction from touch on invisible button

-(IBAction)launchWeb:(id)sender {
    NSString* launchUrl = [[[NSString alloc] initWithString: [NSString stringWithFormat:@"http://%@",self.website.text]] autorelease];
    NSURL *url = [NSURL URLWithString: launchUrl];
    
    WebViewController *webViewController = [[[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil] autorelease];
    
    webViewController.urlObject = url;
    
    [self.navigationController pushViewController:webViewController animated:YES];
}

-(void)watchVideo {
    NSString* videoUrl = [[[NSString alloc] initWithString: [NSString stringWithFormat:@"http://%@",self.performer.video]] autorelease];
    NSURL *url = [NSURL URLWithString: videoUrl];

    WebViewController *webViewController = [[[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil] autorelease];
    
    webViewController.urlObject = url;

    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.name = nil;
    self.desc1 = nil;
    self.desc2 = nil;
    self.addr1 = nil;
    self.addr2 = nil;
    self.phone1 = nil;
    self.phone2 = nil;
    self.website = nil;
    self.email = nil;
    self.video = nil;
    self.time = nil;
    

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}
@end
