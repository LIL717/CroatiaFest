//
//  FoodDetailController.m
//  CroatiaFest
//
//  Created by Lori Hill on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FoodDetailController.h"
#import "Food.h"

@implementation FoodDetailController

@synthesize food = food_;
@synthesize managedObjectContext = managedObjectContext_;

@synthesize name = name_;
@synthesize desc = desc_;
@synthesize sponsor = sponsor_;

- (void) dealloc {
    [food_ release];
    [managedObjectContext_ release];
    
    [name_ release];
    [desc_ release];
    [sponsor_ release];
    
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated {
    self.name.text = self.food.name;
    self.desc.text = self.food.desc;
    self.sponsor.text = self.food.sponsor;

    
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
    self.desc = nil;
    self.sponsor = nil;
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end