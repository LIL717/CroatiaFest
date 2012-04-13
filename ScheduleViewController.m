//
//  ScheduleViewController.m
//  CroatiaFest
//
//  Created by Lori Hill on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleViewController.h"
#import "EventDetailController.h"
#import "Schedule.h"
#import "Event.h"

#pragma mark -
#pragma mark PerformerViewController

@interface ScheduleViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation ScheduleViewController

@synthesize schedule = schedule_; 
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = managedObjectContext_;

- (void)dealloc {
    LogMethod();

    [schedule_ release];
    [__fetchedResultsController release];
    [managedObjectContext_ release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
-(id)init
{
    LogMethod();

    self = [super init];
    //Call the superclass's designated initializer
    [super initWithNibName: nil
                    bundle:nil];
    //Get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
    
    //Give it a label
    [tbi setTitle:@"Schedule"]; 
    
    //Create a UIImage from a file
    UIImage *i = [UIImage imageNamed:@"calendar_24.png"];
    
    //Put that image on the tab bar item
    [tbi setImage:i];    
    
    
    [[self navigationItem] setTitle: @"Schedule"];
    
    //    //become observer for application going to background
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector (applicationWillResignActive:)
    //                                                 name:UIApplicationWillResignActiveNotification
    //                                               object:[UIApplication sharedApplication]];
    return self;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    LogMethod();
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        
//    }
//    return self;
//}

- (void)didReceiveMemoryWarning
{
    LogMethod();

    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
//- (void) applicationWillResignActive: (NSNotification *) note
//{
//    NSLog(@"in applicationWillResignActive in RootViewController");
//
//}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    LogMethod();

    [super viewDidLoad];
    self.title = @"Schedule";    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //    self.performerList = nil;
    
    //    [self removeObserver:self forKeyPath:@"performerList"];
}

- (void)viewWillAppear:(BOOL)animated
{
    LogMethod();

    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    LogMethod();

    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    LogMethod();

    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    LogMethod();

    [super viewDidDisappear:animated];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    LogMethod();



    return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
        //the following line added to lengthen/shorten section header on rotation appropriately
        [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    LogMethod();

    // Return the number of sections.
    NSLog(@"count of sections %d",  [[self.fetchedResultsController sections] count]);
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LogMethod();

    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    NSLog(@"number of rows in section %d", [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LogMethod();

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];

    }
    
    // Configure the cell...
    // all the rows should show the disclosure indicator
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Get the specific performer for this row.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    LogMethod();

    Schedule *schedule = [self.fetchedResultsController objectAtIndexPath:indexPath];
    Event *event = schedule.event;
    
    cell.textLabel.text = event.name;

    cell.textLabel.adjustsFontSizeToFitWidth = YES; 
    cell.detailTextLabel.text = [schedule.location  description];
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES; 
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    LogMethod();

    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];

    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss '+0000'"];

    NSDate *newDate = [dateFormatter dateFromString:[sectionInfo name]];
    
    // Convert date object to desired output format
    [dateFormatter setDateFormat:@"h:mm a"];

    return [dateFormatter stringFromDate:newDate];
//    return [sectionInfo name];


}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LogMethod();

    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    // Create label with section title
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.frame = CGRectMake(15, 0, tableView.bounds.size.width, 25);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.shadowColor = [UIColor grayColor];
    label.shadowOffset = CGSizeMake(0.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = sectionTitle;
    
    UIView *sectionHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 25)] autorelease];
    UIImageView *backgroundView =[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 25)] autorelease];

//    backgroundView.image = [UIImage imageNamed:@"section-header-red.png"];
    backgroundView.image = [UIImage imageNamed:@"section-header-red.png"];

//    [sectionHeaderView setBackgroundColor:[UIColor blueColor]];
    [sectionHeaderView addSubview: backgroundView];
    [sectionHeaderView addSubview:label];
//    [sectionHeaderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];

    
    return sectionHeaderView;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LogMethod();

    Schedule *selectedEvent = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        EventDetailController *eventDetailController = [[[EventDetailController alloc] initWithNibName:@"EventTypeDetailController" bundle:nil] autorelease];
        eventDetailController.managedObjectContext = self.managedObjectContext;
        
        eventDetailController.event = selectedEvent.event;
        [self.navigationController pushViewController:eventDetailController animated:YES];

    
}

// listen for changes to the performer list coming from our app delegagte.
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    LogMethod();

    [self.tableView reloadData];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    LogMethod();

    if (__fetchedResultsController != nil)
    {
        return __fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Schedule" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"beginTime" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
//    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"beginTime" cacheName:@"Root"];

    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error])
    {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    


@end