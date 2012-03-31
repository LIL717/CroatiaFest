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
@synthesize managedObjectContext = __managedObjectContext;

- (void)dealloc {
    
    [schedule_ release];
    [__fetchedResultsController release];
    [__managedObjectContext release];
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
    
    //    //become observer for application going to background
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector (applicationWillResignActive:)
    //                                                 name:UIApplicationWillResignActiveNotification
    //                                               object:[UIApplication sharedApplication]];
    return self;
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
    self.title = @"Schedule";
//    // Test listing all Performers from the store
//    NSManagedObjectContext *context = self.managedObjectContext;
//    NSError *error = nil;
//    
////    NSSet *set=[performer performanceTimes];
//
//
//    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Performer" 
//                                              inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    //        for (Performer *performer in fetchedObjects) {
//    for (Performer *performer in fetchedObjects) {
//        
//        NSLog(@"Name: %@", performer.name);
//        //        NSArray *timesArray = [performer.performanceTimes allObjects];
//        for (Schedule *schedule in [performer performanceTimes]) {
//            NSLog(@"Begin Time: %@", schedule.beginTime);
//        }
//    }    
//    // end test 
//    // Test listing all Schedule from the store
//    //        NSManagedObjectContext *context = self.managedObjectContext;
//    //        NSError *error = nil;
//    
//    NSFetchRequest *fetchRequest2 = [[[NSFetchRequest alloc] init] autorelease];
//    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Schedule" 
//                                               inManagedObjectContext:context];
//    [fetchRequest2 setEntity:entity2];
//    NSArray *fetchedObjects2 = [context executeFetchRequest:fetchRequest2 error:&error];
//    for (Schedule *schedule in fetchedObjects2) {
//        NSLog(@"Begin Time: %@", schedule.beginTime);
//        Performer *performer = schedule.performer;
//        NSLog(@"Performer name: %@", performer.name);
//    }        
//    // end test 

    
    //    //become observer for application going to background
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector (applicationWillResignActive:)
    //                                                 name:UIApplicationWillResignActiveNotification
    //                                               object:[UIApplication sharedApplication]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //    self.performerList = [[NSMutableArray alloc] init];
    
    // KVO: listen for changes to our performer data source for table view updates
    //    [self addObserver:self forKeyPath:@"performerList" options:0 context:NULL];
    
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

//    backgroundView.image = [UIImage imageNamed:@"section-header-red.png"];
    backgroundView.image = [UIImage imageNamed:@"section-header-red.png"];

//    [sectionHeaderView setBackgroundColor:[UIColor blueColor]];
    [sectionHeaderView addSubview: backgroundView];
    [sectionHeaderView addSubview:label];
    [sectionHeaderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];

    
    return sectionHeaderView;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Schedule *selectedEvent = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        EventDetailController *eventDetailController = [[[EventDetailController alloc] initWithNibName:@"EventTypeDetailController" bundle:nil] autorelease];
        eventDetailController.managedObjectContext = self.managedObjectContext;
        
        eventDetailController.event = selectedEvent.event;
        [self.navigationController pushViewController:eventDetailController animated:YES];

//    if (!isEmpty(selectedPerformance.cookingDemo)) {
//        CookingDemoDetailController *cookingDemoDetailController = [[[CookingDemoDetailController alloc] initWithNibName:@"EventTypeDetailController" bundle:nil] autorelease];
//        cookingDemoDetailController.managedObjectContext = self.managedObjectContext;
//        
//        cookingDemoDetailController.cookingDemo = selectedPerformance.cookingDemo;
//        [self.navigationController pushViewController:cookingDemoDetailController animated:YES];
//
//    }

    
}

// listen for changes to the performer list coming from our app delegagte.
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    [self.tableView reloadData];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
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

//#pragma mark - Fetched results controller delegate
//
//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
//{
//    [self.tableView beginUpdates];
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
//           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
//{
//    switch(type)
//    {
//        case NSFetchedResultsChangeInsert:
//            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
//       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
//      newIndexPath:(NSIndexPath *)newIndexPath
//{
//    UITableView *tableView = self.tableView;
//    
//    switch(type)
//    {
//            
//        case NSFetchedResultsChangeInsert:
//            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeUpdate:
//            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
//            break;
//            
//        case NSFetchedResultsChangeMove:
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}
//
//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
//{
//    [self.tableView endUpdates];
//}
//
///*
// // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
// 
// - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
// {
// // In the simplest, most efficient, case, reload the table view.
// [self.tableView reloadData];
// }
// */

@end