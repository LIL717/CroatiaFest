//
//  MarketplaceViewController.m
//  CroatiaFest
//
//  Created by Lori Hill on 6/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MarketplaceViewController.h"
#import "VendorViewController.h"
#import "FoodViewController.h"
#import "DirectoryViewController.h"


@implementation MarketplaceViewController
@synthesize marketArray;
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
    [tbi setTitle:@"Marketplace"]; 
    
    //Create a UIImage from a file
    UIImage *i = [UIImage imageNamed:@"cart_24.png"];
    
    //Put that image on the tab bar item
    [tbi setImage:i];    
    
    
    [[self navigationItem] setTitle: @"Marketplace"];
    
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
    
    marketArray = [[[NSArray alloc] initWithObjects:@"Vendor Booths", @"Food Booths", @"Advertisers", nil] autorelease];
    NSLog (@"marketArray is %@", marketArray);

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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

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
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = [self.marketArray objectAtIndex:indexPath.row];
    
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
        
        VendorViewController *vendorViewController = [[VendorViewController alloc] initWithNibName:@"VendorViewController" bundle:nil];
        vendorViewController.managedObjectContext = self.managedObjectContext;
        
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:vendorViewController animated:YES];
        [vendorViewController release];
    }
    
    if (indexPath.row == 1) {
        
        FoodViewController *foodViewController = [[FoodViewController alloc] initWithNibName:@"FoodViewController" bundle:nil];
        foodViewController.managedObjectContext = self.managedObjectContext;

        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:foodViewController animated:YES];
        [foodViewController release];
    }
    if (indexPath.row == 2) {
        
        DirectoryViewController *directoryViewController = [[DirectoryViewController alloc] initWithNibName:@"DirectoryViewController" bundle:nil];
        directoryViewController.managedObjectContext = self.managedObjectContext;
        
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:directoryViewController animated:YES];
        [directoryViewController release];
        
    }
    
}

@end
