//
//  EventDetailController.m
//  CroatiaFest
//
//  Created by Lori Hill on 10/3/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import "EventDetailController.h"
#import "Event.h"
#import "Schedule.h"
#import "WebViewController.h"

@interface EventDetailController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation EventDetailController

@synthesize event = event_;
@synthesize schedule = schedule_;
@synthesize eventTimes = eventTimes_;

@synthesize scrollView = scrollView_;
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

@synthesize scheduleTableView = scheduleTableView_;
@synthesize webButton = webButton_;


@synthesize managedObjectContext = managedObjectContext_;


- (void) dealloc {
    [event_ release];
    [schedule_ release];
    [eventTimes_ release];
    [scrollView_ release];
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
    [scheduleTableView_ release];
    [webButton_ release];
    [managedObjectContext_ release];
//    [persistentStoreCoordinator_ release];

    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.name.text = self.event.name;
    self.desc1.text = self.event.desc1;
    self.desc2.text = self.event.desc2;
    self.addr1.text = self.event.addr1;
    self.addr2.text = self.event.addr2;
    self.phone1.text = self.event.phone1;
    self.phone2.text = self.event.phone2;
    self.website.text = self.event.website;
    self.email.text = self.event.email;
    self.video.text = self.event.video;
    
//    NSLog(@"Event name: %@", self.name.text);
       
    // Populate array with eventTimes
    
    self.eventTimes = [self.event.eventTimes allObjects];
 
    // Create "Watch Video" button for the nav bar if there is a video
    if (!isEmpty(self.event.video)) {
        UIBarButtonItem *watchButton = [[UIBarButtonItem alloc] 
                                        initWithTitle:@"Watch Video" 
                                        style:(UIBarButtonItemStyleBordered) 
                                        target:self 
                                        action:@selector(watchVideo)];
        [[self navigationItem] setRightBarButtonItem:watchButton];
        [watchButton release];
    }
    // Disable invisible webButton button if there is no website
    if (isEmpty(self.event.website)) {
        [self.webButton setEnabled:NO]; // To toggle enabled / disabled
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
    NSString* videoUrl = [[[NSString alloc] initWithString: [NSString stringWithFormat:@"http://%@",self.event.video]] autorelease];
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
//    LogMethod();
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;

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
    self.webButton = nil;
    

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.eventTimes count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    // all the rows should show the disclosure indicator
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Get the specific event for this row.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Schedule *eventTime = [self.eventTimes objectAtIndex:indexPath.row];


    NSTimeInterval secondsInSevenHours = 7 * 60 * 60;
    NSDate *correctedBeginDate = [eventTime.beginTime dateByAddingTimeInterval:secondsInSevenHours];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm a"];
    cell.textLabel.text = [dateFormatter stringFromDate:correctedBeginDate]; 

    [dateFormatter release];

    cell.textLabel.adjustsFontSizeToFitWidth = YES; 
    cell.detailTextLabel.text = eventTime.location;
}


@end
