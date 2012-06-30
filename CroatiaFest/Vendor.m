//
//  Vendor.m
//  CroatiaFest
//
//  Created by Lori Hill on 10/9/11.
//  Copyright 2011 CroatiaFest. All rights reserved.
//

#import "Vendor.h"

@implementation Vendor

@dynamic name;
@dynamic desc1;
@dynamic desc2;
@dynamic addr1;
@dynamic addr2;
@dynamic phone1;
@dynamic phone2;
@dynamic website;
@dynamic email;


@synthesize managedObjectContext = managedObjectContext_;
- (void)dealloc {

    [managedObjectContext_ release];
    [super dealloc];
    
} 

- (void)addVendorsToCoreData:(NSArray *)vendors {
    //LogMethod();
    //this is an array of dictionaries
    
    NSError *error = nil;
    // insert the directory into Core Data
    for (id newVendor in vendors) {
        
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Vendor" inManagedObjectContext:self.managedObjectContext];
        [newManagedObject setValue: [newVendor valueForKey: @"Name"] forKey:@"name"];
        [newManagedObject setValue: [newVendor valueForKey: @"Desc_1"] forKey:@"desc1"];
        [newManagedObject setValue: [newVendor valueForKey: @"Desc_2"] forKey:@"desc2"];
        [newManagedObject setValue: [newVendor valueForKey: @"Addr_1"] forKey:@"addr1"];
        [newManagedObject setValue: [newVendor valueForKey: @"Addr_2"] forKey:@"addr2"];
        [newManagedObject setValue: [newVendor valueForKey: @"Phone_1"] forKey:@"phone1"];
        [newManagedObject setValue: [newVendor valueForKey: @"Phone_2"] forKey:@"phone2"];
        [newManagedObject setValue: [newVendor valueForKey: @"Website"] forKey:@"website"];
        [newManagedObject setValue: [newVendor valueForKey: @"Email"] forKey:@"email"];
        
//        NSLog(@" newManagedObject is %@", newManagedObject);
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
    }
    
}

@end