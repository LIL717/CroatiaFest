//
//  WebViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 3/10/12.
//  Copyright (c) 2012 CroatiaFest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIWebView.h>

@interface WebViewController : UIViewController  <UIWebViewDelegate> {
    UIWebView *webView_;
    UIBarButtonItem *backButton_;
    UIBarButtonItem *forwardButton_;
    NSURL *urlObject_;

}
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *forwardButton;
@property (nonatomic, strong) NSURL *urlObject;

-(void) updateButtons;
-(void) goForward;
-(void) goBack;

@end
