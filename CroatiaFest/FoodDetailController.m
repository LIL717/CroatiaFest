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
@synthesize desc1 = desc1_;
@synthesize desc2 = desc2_;
@synthesize addr1 = addr1_;
@synthesize addr2 = addr2_;
@synthesize phone1 = phone1_;
@synthesize phone2 = phone2_;
@synthesize website = website_;
@synthesize email = email_;

- (void) dealloc {
    [food_ release];
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
    self.name.text = self.food.name;
    self.desc1.text = self.food.desc1;
    self.desc2.text = self.food.desc2;
    self.addr1.text = self.food.addr1;
    self.addr2.text = self.food.addr2;
    self.phone1.text = self.food.phone1;
    self.phone2.text = self.food.phone2;
    self.website.text = self.food.website;
    self.email.text = self.food.email;

    
}
// IBAction needs to be from touch on textfield
//  should it be a safari page within the app that then can go back????   YES change this

-(IBAction)launchWeb:(id)sender {
    NSString* launchUrl = [NSString stringWithFormat:@"http://%@",self.website.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
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
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end