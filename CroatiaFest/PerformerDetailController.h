//
//  PerformerDetailController.h
//  CroatiaFest
//
//  Created by Lori Hill on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Performer;

@interface PerformerDetailController : UIViewController {

    UITextField *name_;
    UITextField *desc_;
    UITextField *performanceTime_;
    UITextField *city_;
    UITextField *website_;
    
    Performer *performer_;
    NSManagedObjectContext *managedObjectContext_;
}
@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *desc;
@property (nonatomic, retain) IBOutlet UITextField *performanceTime;
@property (nonatomic, retain) IBOutlet UITextField *city;
@property (nonatomic, retain) IBOutlet UITextField *website;

@property (nonatomic, retain) Performer *performer;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)launchURL:(id)sender; 
- (NSString *) mailOrWeb;

@end
