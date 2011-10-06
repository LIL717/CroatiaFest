//
//  PerformerDetailController.m
//  CroatiaFest
//
//  Created by Lori Hill on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PerformerDetailController.h"
#import "Performer.h"

@implementation PerformerDetailController

@synthesize performer = performer_;
@synthesize managedObjectContext = managedObjectContext_;

@synthesize name = name_;
@synthesize desc = desc_;
@synthesize performanceTime = performanceTime_;
@synthesize city = city_;
@synthesize website = website_;

- (void) dealloc {
    [performer_ release];
    [managedObjectContext_ release];
    [name_ release];
    [desc_ release];
    [performanceTime_ release];
    [city_ release];
    [website_ release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated {
    self.name.text = self.performer.name;
    self.desc.text = self.performer.desc;
    self.city.text = self.performer.city;
    self.website.text = self.performer.website;

    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    NSDate *date = self.performer.performanceTime;
    NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    [dateFormatter setLocale:usLocale];
    
    // Convert date object to desired output format
    [dateFormatter setDateFormat:@"h:mm"];
    self.performanceTime.text = [dateFormatter stringFromDate:date]; 
}
// IBAction needs to be from touch on textfield
//  should it be a safari page within the app that then can go back????

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
    self.desc = nil;
    self.performanceTime = nil;
    self.city = nil;
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
