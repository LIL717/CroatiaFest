//
//  VendorDetailController.m
//  CroatiaFest
//
//  Created by Lori Hill on 1/14/12.
//  Copyright (c) 2012 CroatiaFest. All rights reserved.
//

#import "VendorDetailController.h"
#import "Vendor.h"
#import "WebViewController.h"

@implementation VendorDetailController

@synthesize vendor = vendor_;
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
@synthesize webButton = webButton_;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
    self.name.text = self.vendor.name;
    self.desc1.text = self.vendor.desc1;
    self.desc2.text = self.vendor.desc2;
    self.addr1.text = self.vendor.addr1;
    self.addr2.text = self.vendor.addr2;
    self.phone1.text = self.vendor.phone1;
    self.phone2.text = self.vendor.phone2;
    self.website.text = self.vendor.website;
    self.email.text = self.vendor.email;
    
    // Disable invisible webButton button if there is no website
    if (isEmpty(self.vendor.website)) {
        [self.webButton setEnabled:NO]; // To toggle enabled / disabled
    }

    
}
// IBAction from touch on invisible button

-(IBAction)launchWeb:(id)sender {
    NSString* launchUrl = [[NSString alloc] initWithString: [NSString stringWithFormat:@"http://%@",self.website.text]];
    NSURL *url = [NSURL URLWithString: launchUrl];
    
    WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	//don't extend under nav bar and tab bar
	self.edgesForExtendedLayout = UIRectEdgeNone;
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
    self.webButton = nil;

    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

@end