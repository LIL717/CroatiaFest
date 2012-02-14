//
//  VendorDetailController.m
//  CroatiaFest
//
//  Created by Lori Hill on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VendorDetailController.h"
#import "Vendor.h"

@implementation VendorDetailController

@synthesize vendor = vendor_;
@synthesize managedObjectContext = managedObjectContext_;

@synthesize name = name_;
@synthesize desc1 = desc1_;
@synthesize desc2 = desc2_;
@synthesize contact = contact_;
@synthesize addr1 = addr1_;
@synthesize addr2 = addr2_;
@synthesize phone = phone_;
@synthesize website = website_;

- (void) dealloc {
    [vendor_ release];
    [managedObjectContext_ release];
    
    [name_ release];
    [desc1_ release];
    [desc2_ release];
    [contact_ release];
    [addr1_ release];
    [addr2_ release];
    [phone_ release];
    [website_ release];
    
    
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated {
    self.name.text = self.vendor.name;
    self.desc1.text = self.vendor.desc1;
    self.desc2.text = self.vendor.desc2;
    self.contact.text = self.vendor.contact;
    self.addr1.text = self.vendor.addr1;
    self.addr2.text = self.vendor.addr2;
    self.phone.text = self.vendor.phone;
    self.website.text = self.vendor.website;
    
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
    self.contact = nil;
    self.addr1 = nil;
    self.addr2 = nil;
    self.phone = nil;
    self.website = nil;
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end