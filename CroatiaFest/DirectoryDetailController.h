//
//  DirectoryDetailController.h
//  CroatiaFest
//
//  Created by Lori Hill on 1/10/12.
//  Copyright (c) 2012 CroatiaFest. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Directory;

@interface DirectoryDetailController : UIViewController {
    UITextField *name_;
    UITextField *desc1_;
    UITextView *desc2_;
    UITextField *addr1_;
    UITextField *addr2_;
    UITextView *phone1_;
    UITextField *phone2_;
    UITextField *website_;
    UITextField *email_;
    UIButton *webButton_;
  
    Directory *directory;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, strong) IBOutlet UITextField *name;
@property (nonatomic, strong) IBOutlet UITextField *desc1;
@property (nonatomic, strong) IBOutlet UITextView *desc2;
@property (nonatomic, strong) IBOutlet UITextField *addr1;
@property (nonatomic, strong) IBOutlet UITextField *addr2;
@property (nonatomic, strong) IBOutlet UITextView *phone1;
@property (nonatomic, strong) IBOutlet UITextField *phone2;
@property (nonatomic, strong) IBOutlet UITextField *website;
@property (nonatomic, strong) IBOutlet UITextField *email;
@property (nonatomic, strong) IBOutlet UIButton *webButton;


@property (nonatomic, strong) Directory *directory;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)launchWeb:(id)sender; 

@end