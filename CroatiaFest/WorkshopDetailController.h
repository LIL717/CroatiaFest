//
//  WorkshopDetailViewController.h
//  CroatiaFest
//
//  Created by Lori Hill on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Workshop;

@interface WorkshopDetailController : UIViewController {
    UITextField *name_;
    UITextField *presenter_;
    UITextField *website_;
    UITextView  *desc_;
    UITextField *panel1_;
    UITextField *panel2_;
    UITextField *panel3_;
    UITextField *panel4_;
    UITextField *panel5_;
    UITextField *panel6_;
    UITextField *linkText_;
    UITextField *link_;
    UITextField *presentationTime_;    
    
    Workshop *workshop_;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *presenter;
@property (nonatomic, retain) IBOutlet UITextField *website;
@property (nonatomic, retain) IBOutlet UITextView *desc;
@property (nonatomic, retain) IBOutlet UITextField *panel1;
@property (nonatomic, retain) IBOutlet UITextField *panel2;
@property (nonatomic, retain) IBOutlet UITextField *panel3;
@property (nonatomic, retain) IBOutlet UITextField *panel4;
@property (nonatomic, retain) IBOutlet UITextField *panel5;
@property (nonatomic, retain) IBOutlet UITextField *panel6;
@property (nonatomic, retain) IBOutlet UITextField *linkText;
@property (nonatomic, retain) IBOutlet UITextField *link;
@property (nonatomic, retain) IBOutlet UITextField *presentationTime;

@property (nonatomic, retain) Workshop *workshop;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)launchURL:(id)sender; 
- (NSString *) mailOrWeb;

@end