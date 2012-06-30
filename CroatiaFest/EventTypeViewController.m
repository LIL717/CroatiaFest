//
//  EventTypeViewController.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/15/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import "EventTypeViewController.h"
#import "EventDetailController.h"
#import "Event.h"


#pragma mark -
#pragma mark PerformerViewController

@interface EventTypeViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation EventTypeViewController

@synthesize event = event_; 
@synthesize eventType = eventType_;
@synthesize fetchedResultsController = fetchedResultsController_;
@synthesize managedObjectContext = managedObjectContext_;


- (void)dealloc {

    [event_ release];
    [eventType_ release];
    [fetchedResultsController_ release];
    [managedObjectContext_ release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
//

- (id)initWithEventType:(NSString *)eventType
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.eventType = [[[NSString alloc] initWithString: eventType] autorelease];;
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
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
    [super viewDidLoad];
//    self.title = @"Performers";
    self.title = self.eventType;
    
}

- (void)viewDidUnload
{
//    LogMethod();
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
//    self.performerList = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
//    LogMethod();
    [super viewWillAppear:animated];
//    // Test listing all Events from the store
//    NSLog(@"***************show database in Event Type View Controller ****");
//    NSError *error = nil;
//    //    NSSet *set=[self.event eventTimes];
//    
//    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" 
//                                              inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    //        for (Performer *performer in fetchedObjects) {
//    for (Event *event in fetchedObjects) {
//        
//        NSLog(@"Name: %@", event.name);
////        NSLog(@"Version: %@", event.desc1);
//        //        NSArray *timesArray = [performer.performanceTimes allObjects];
//        //        for (Schedule *schedule in set) {
//        //            NSLog(@"Begin Time: %@", schedule.beginTime);
//        //        }
//    }    
//    // end test

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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    // all the rows should show the disclosure indicator
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
// Get the specific event for this row.
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Event *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.adjustsFontSizeToFitWidth = YES; 
    cell.textLabel.text = [[event valueForKey:@"name"] description];  
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    EventDetailController *eventDetailController = [[[EventDetailController alloc] initWithNibName:@"EventTypeDetailController" bundle:nil] autorelease];
    eventDetailController.managedObjectContext = self.managedObjectContext;
    
    Event *selectedEvent = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    eventDetailController.event = selectedEvent;
    
    [self.navigationController pushViewController:eventDetailController animated:YES];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController_ != nil)
    {
        return fetchedResultsController_;
    }
    [NSFetchedResultsController deleteCacheWithName:@"Root"];  

    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventType == %@", self.eventType];
    [fetchRequest setPredicate: predicate];

    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
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
