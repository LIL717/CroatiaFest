//
//  FoodDetailController.h
//  CroatiaFest
//
//  Created by Lori Hill on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Food;

@interface FoodDetailController : UIViewController {
    UITextField *name_;
    UITextField *desc_;
    UITextField *sponsor_;
    
    Food *food;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *desc;
@property (nonatomic, retain) IBOutlet UITextField *sponsor;



@property (nonatomic, retain) Food *food;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end