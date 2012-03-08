//
//  VendorDetailController.h
//  CroatiaFest
//
//  Created by Lori Hill on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Vendor;

@interface VendorDetailController : UIViewController {
    UITextField *name_;
    UITextField *desc1_;
    UITextView *desc2_;
    UITextField *addr1_;
    UITextField *addr2_;
    UITextField *phone1_;
    UITextField *phone2_;
    UITextField *website_;
    UITextField *email_;
    
    Vendor *vendor;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *desc1;
@property (nonatomic, retain) IBOutlet UITextView *desc2;
@property (nonatomic, retain) IBOutlet UITextField *addr1;
@property (nonatomic, retain) IBOutlet UITextField *addr2;
@property (nonatomic, retain) IBOutlet UITextField *phone1;
@property (nonatomic, retain) IBOutlet UITextField *phone2;
@property (nonatomic, retain) IBOutlet UITextField *website;
@property (nonatomic, retain) IBOutlet UITextField *email;



@property (nonatomic, retain) Vendor *vendor;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)launchWeb:(id)sender; 

@end