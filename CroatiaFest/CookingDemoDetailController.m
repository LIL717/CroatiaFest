//
//  CookingDemoDetailController.m
//  CroatiaFest
//
//  Created by Lori Hill on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CookingDemoDetailController.h"
#import "CookingDemo.h"
#import "WebViewController.h"

@implementation CookingDemoDetailController

@synthesize cookingDemo = cookingDemo_;
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
@synthesize video = video_;  

- (void) dealloc {
    [cookingDemo_ release];
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
    [video_ release];
    
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
    self.name.text = self.cookingDemo.name;
    self.desc1.text = self.cookingDemo.desc1;
    self.desc2.text = self.cookingDemo.desc2;
    self.addr1.text = self.cookingDemo.addr1;
    self.addr2.text = self.cookingDemo.addr2;
    self.phone1.text = self.cookingDemo.phone1;
    self.phone2.text = self.cookingDemo.phone2;
    self.website.text = self.cookingDemo.website;
    self.email.text = self.cookingDemo.email;
    self.video.text = self.cookingDemo.video;
    //    NSLog (@"name, webiste is %@ %@", self.cookingDemo.name, self.cookingDemo.website);
    
    //    if ([self.cookingDemo.website length] >0)
    //        self.website.text = self.cookingDemo.website;
    //    else self.website.text = @" ";
    
    //    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    //    NSDate *date = self.cookingDemo.presentationTime;
    //    NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    //    [dateFormatter setLocale:usLocale];
    //    
    //    // Convert date object to desired output format
    //    [dateFormatter setDateFormat:@"h:mm"];
    //    self.presentationTime.text = [dateFormatter stringFromDate:date]; 
}
// IBAction from touch on invisible button

-(IBAction)launchWeb:(id)sender {
    NSString* launchUrl = [[[NSString alloc] initWithString: [NSString stringWithFormat:@"http://%@",self.website.text]] autorelease];
    NSURL *url = [NSURL URLWithString: launchUrl];
    
    WebViewController *webViewController = [[[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil] autorelease];
    
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
    self.video = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}
@end
