//
//  VideoViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSURL *urlObject;

@end
