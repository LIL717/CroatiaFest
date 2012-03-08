//
//  CookingDemo.m
//  CroatiaFest
//
//  Created by Lori Hill on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CookingDemo.h"

@implementation CookingDemo
@dynamic name;
@dynamic desc1;
@dynamic desc2;
@dynamic addr1;
@dynamic addr2;
@dynamic phone1;
@dynamic phone2;
@dynamic website;
@dynamic email;
@dynamic video;

@synthesize managedObjectContext = managedObjectContext_;


- (void)addCookingDemosToCoreData:(NSArray *)cookingDemos {
    LogMethod();
    //this is an array of dictionaries
    
    NSError *error = nil;
    // insert the performers into Core Data
    for (id newCookingDemo in cookingDemos) {
        
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"CookingDemo" inManagedObjectContext:self.managedObjectContext];
        [newManagedObject setValue: [newCookingDemo valueForKey: @"Name"] forKey:@"name"];
        [newManagedObject setValue: [newCookingDemo valueForKey: @"Desc_1"] forKey:@"desc1"];
        [newManagedObject setValue: [newCookingDemo valueForKey: @"Desc_2"] forKey:@"desc2"];
        [newManagedObject setValue: [newCookingDemo valueForKey: @"Addr_1"] forKey:@"addr1"];
        [newManagedObject setValue: [newCookingDemo valueForKey: @"Addr_2"] forKey:@"addr2"];
        [newManagedObject setValue: [newCookingDemo valueForKey: @"Phone_1"] forKey:@"phone1"];
        [newManagedObject setValue: [newCookingDemo valueForKey: @"Phone_2"] forKey:@"phone2"];
        [newManagedObject setValue: [newCookingDemo valueForKey: @"Website"] forKey:@"website"];
        [newManagedObject setValue: [newCookingDemo valueForKey: @"Email"] forKey:@"email"];
        [newManagedObject setValue: [newCookingDemo valueForKey: @"Video"] forKey:@"video"];
        
        //        // Convert string to date object
        //        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        //        [dateFormatter setDateFormat:@"hh:mm:ss"];
        //        [newManagedObject setValue: [dateFormatter dateFromString: [newWorkshop valueForKey: @"Time"]] forKey:@"presentationTime"];
        
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
        
    }
    
}

@end
