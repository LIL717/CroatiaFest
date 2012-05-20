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
    IBOutlet UIWebView *webView;

}
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSURL *urlObject;

@end
