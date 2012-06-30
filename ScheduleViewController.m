//
//  ScheduleViewController.m
//  CroatiaFest
//
//  Created by Lori Hill on 1/18/12.
//  Copyright (c) 2012 CroatiaFest. All rights reserved.
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
@synthesize fetchedResultsController = fetchedResultsController_;
@synthesize managedObjectContext = managedObjectContext_;


- (void)dealloc {

    [schedule_ release];
    [fetchedResultsController_ release];
    [managedObjectContext_ release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
-(id)init
{

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
    
    return self;
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
    self.title = @"Schedule";  

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
        //the following line added to lengthen/shorten section header on rotation appropriately
        [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
//    NSLog(@"count of sections %d",  [[self.fetchedResultsController sections] count]);
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
//    NSLog(@"number of rows in section %d", [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

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

    Schedule *schedule = [self.fetchedResultsController objectAtIndexPath:indexPath];
    Event *event = schedule.event;
    
    cell.textLabel.text = event.name;

    cell.textLabel.adjustsFontSizeToFitWidth = YES; 
    cell.detailTextLabel.text = [schedule.location  description];
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES; 
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];

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

    backgroundView.image = [UIImage imageNamed:@"section-header-red.png"];
//    backgroundView.image = [UIImage imageNamed:@"menubar-red.png"];

    [sectionHeaderView addSubview: backgroundView];
    [sectionHeaderView addSubview:label];
    
    return sectionHeaderView;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [TestFlight passCheckpoint:@"Select schedule event"];


    Schedule *selectedEvent = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        EventDetailController *eventDetailController = [[[EventDetailController alloc] initWithNibName:@"EventTypeDetailController" bundle:nil] autorelease];
        eventDetailController.managedObjectContext = self.managedObjectContext;
        
        eventDetailController.event = selectedEvent.event;
        [self.navigationController pushViewController:eventDetailController animated:YES];

    
}
#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{

    if (fetchedResultsController_ != nil)
    {
        return fetchedResultsController_;
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
        UIAlertView* alertView =
        [[UIAlertView alloc] initWithTitle:@"Pazi!! Data Management Error" 
                                   message:@"Press the Home button to quit this application." 
                                  delegate:self 
                         cancelButtonTitle:@"OK" 
                         otherButtonTitles: nil];
        [alertView show];
        [alertView release];
	}
    
    return fetchedResultsController_;
}    


@end