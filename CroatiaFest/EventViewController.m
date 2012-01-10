//
//  EventViewController.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventViewController.h"
#import "PerformerViewController.h"
#import "ExhibitViewController.h"
#import "WorkshopViewController.h"




@implementation EventViewController
@synthesize eventArray;
@synthesize managedObjectContext = managedObjectContext_;

-(id)init
{
    self = [super init];
    //Call the superclass's designated initializer
    [super initWithNibName: nil
                    bundle:nil];
    //Get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
    
    //Give it a label
    [tbi setTitle:@"Events"]; 
    
    //Create a UIImage from a file
    UIImage *i = [UIImage imageNamed:@"mic_24.png"];
    
    //Put that image on the tab bar item
    [tbi setImage:i];    
    
    
    [[self navigationItem] setTitle: @"Events"];
    
//    //become observer for application going to background
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector (applicationWillResignActive:)
//                                                 name:UIApplicationWillResignActiveNotification
//                                               object:[UIApplication sharedApplication]];
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [managedObjectContext_ release];

    [super dealloc];
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

    eventArray = [[[NSArray alloc] initWithObjects:@"Performers", @"Exhibits", @"Food Stage", nil] autorelease];
    NSLog (@"eventArray is %@", eventArray);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation ==  UIInterfaceOrientationPortrait) || UIInterfaceOrientationIsLandscape(interfaceOrientation);
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    // configure cell contents
    //all the rows should show the disclosure indicator
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = [self.eventArray objectAtIndex:indexPath.row];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    if (indexPath.row == 0) {
    
         PerformerViewController *performerViewController = [[PerformerViewController alloc] initWithNibName:@"PerformerViewController" bundle:nil];
        performerViewController.managedObjectContext = self.managedObjectContext;
        
         // Pass the selected object to the new view controller.
         [self.navigationController pushViewController:performerViewController animated:YES];
         [performerViewController release];
    }
     
    if (indexPath.row == 1) {

        ExhibitViewController *exhibitViewController = [[ExhibitViewController alloc] initWithNibName:@"ExhibitViewController" bundle:nil];
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:exhibitViewController animated:YES];
        [exhibitViewController release];
    }
    if (indexPath.row == 2) {
        
        WorkshopViewController *workshopViewController = [[WorkshopViewController alloc] initWithNibName:@"WorkshopViewController" bundle:nil];
        workshopViewController.managedObjectContext = self.managedObjectContext;
        
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:workshopViewController animated:YES];
        [workshopViewController release];
    }
    
}

@end
