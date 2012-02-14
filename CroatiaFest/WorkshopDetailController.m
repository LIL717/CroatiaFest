//
//  WorkshopDetailViewController.m
//  CroatiaFest
//
//  Created by Lori Hill on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WorkshopDetailController.h"
#import "Workshop.h"

@implementation WorkshopDetailController

@synthesize workshop = workshop_;
@synthesize managedObjectContext = managedObjectContext_;

@synthesize name = name_;
@synthesize presenter = presenter_;
@synthesize website = website_;
@synthesize desc = desc_;
@synthesize panel1 = panel1_;
@synthesize panel2 = panel2_;
@synthesize panel3 = panel3_;
@synthesize panel4 = panel4_;
@synthesize panel5 = panel5_;
@synthesize panel6 = panel6_;
@synthesize linkText = linkText_;
@synthesize link = link_;
@synthesize presentationTime = presentationTime_;   

- (void) dealloc {
    [workshop_ release];
    [managedObjectContext_ release];
    [name_ release];
    [presenter_ release];
    [website_ release];
    [desc_ release];
    [panel1_ release];
    [panel2_ release];
    [panel3_ release];
    [panel4_ release];
    [panel5_ release];
    [panel6_ release];
    [linkText_ release];
    [link_ release];
    [presentationTime_ release];

    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated {
    self.name.text = self.workshop.name;
    self.presenter.text = self.workshop.presenter;
    self.desc.text = self.workshop.desc;
//    NSLog (@"name, webiste is %@ %@", self.workshop.name, self.workshop.website);

//    if ([self.workshop.website length] >0)
//        self.website.text = self.workshop.website;
//    else self.website.text = @" ";
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    NSDate *date = self.workshop.presentationTime;
    NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    [dateFormatter setLocale:usLocale];
    
    // Convert date object to desired output format
    [dateFormatter setDateFormat:@"h:mm"];
    self.presentationTime.text = [dateFormatter stringFromDate:date]; 
}
// IBAction needs to be from touch on textfield
//  should it be a safari page within the app that then can go back????   YES change this

-(IBAction)launchURL:(id)sender {
    NSString* launchUrl = [[[NSString alloc] initWithString: [self mailOrWeb]] autorelease];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}
- (NSString *)  mailOrWeb;
{
    if ([self.website.text rangeOfString:@"@"].location == NSNotFound) {
        return [NSString stringWithFormat:@"http://%@",self.website.text];
    } else {
        return [NSString stringWithFormat:@"mailto:%@", self.website.text];
    }
    
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
    self.presenter = nil;
    self.website = nil;
    self.desc = nil;
    self.panel1 = nil;
    self.panel2 = nil;
    self.panel3 = nil;
    self.panel4 = nil;
    self.panel5 = nil;
    self.panel6 = nil;
    self.linkText = nil;
    self.link = nil;
    self.presentationTime = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
