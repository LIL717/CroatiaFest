//
//  WebViewController.m
//  CroatiaFest
//
//  Created by Lori Hill on 3/10/12.
//  Copyright (c) 2012 CroatiaFest. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController
@synthesize webView = webView_;
@synthesize backButton = backButton_;
@synthesize forwardButton = forwardButton_;
@synthesize urlObject = urlObject_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    LogMethod();
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
//    LogMethod();
// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated
{
//    LogMethod();
	[super viewWillAppear: animated];
    self.backButton = [[UIBarButtonItem alloc] 
                       initWithImage:[UIImage imageNamed:@"back-button.png"]
                        style:UIBarButtonItemStyleBordered
                        target:self 
                        action:@selector(goBack)];
    
    self.forwardButton = [[UIBarButtonItem alloc]
                                    initWithImage:[UIImage imageNamed:@"forward-button.png"]
//                                      initWithTitle:@"▶"  
                                   style:UIBarButtonItemStylePlain
                                   target:self 
                                   action:@selector(goForward)]; 
      
    NSArray *navItems = [[NSArray alloc] initWithObjects: self.forwardButton, self.backButton, nil];

    [[self navigationItem] setRightBarButtonItems:navItems];
    [self updateButtons];


}
- (void)viewDidLoad
{
//    LogMethod();

    [super viewDidLoad];
    NSAssert(self.webView, @"Unconnected IBOutlet 'webView'");
    
    // Do any additional setup after loading the view from its nib.
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;

    [self.webView loadRequest:[NSURLRequest requestWithURL:self.urlObject]];
    [self updateButtons];
		//don't extend under nav bar and tab bar
	self.edgesForExtendedLayout = UIRectEdgeNone;

}

- (void)viewDidUnload
{
//    LogMethod();
    [self setWebView:nil];
    [self setBackButton:nil];
    [self setForwardButton:nil];
    [self setUrlObject:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void) viewWillDisappear:(BOOL)animated
{
//    LogMethod();
	[super viewWillDisappear: animated];
    // hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    LogMethod();

    if ([[[request URL] scheme] isEqual:@"mailto"]) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    LogMethod();

    // starting the load, show the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    LogMethod();

    // finished loading, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    LogMethod();

    // load error, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];

    
    // -999 == "Operation could not be completed", note -999 occurs when the user clicks away before
    // the page has completely loaded, if we find cases where we want this to result in dialog failure
    // (usually this just means quick-user), then we should add something more robust here to account
    // for differences in application needs
    
    if (!(([error.domain isEqualToString:@"NSURLErrorDomain"] && error.code == -999) ||
            ([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code == 102))) {
        // report the error inside the webview
        NSString* errorString = [NSString stringWithFormat:
                                 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
                                 error.localizedDescription];
        [self.webView loadHTMLString:errorString baseURL:nil];
    }
}
-(void)updateButtons {
//    LogMethod();

    self.forwardButton.enabled = self.webView.canGoForward;
    self.backButton.enabled = self.webView.canGoBack;
}
-(void)goBack {
//    LogMethod();

    [self.webView goBack];
    
}
-(void)goForward {
//    LogMethod();

    [self.webView goForward];
    
}
@end
