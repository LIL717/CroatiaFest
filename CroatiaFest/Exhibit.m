//
//  Exhibit.m
//  CroatiaFest
//
//  Created by Lori Hill on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Exhibit.h"

@implementation Exhibit

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


- (void)addExhibitsToCoreData:(NSArray *)exhibits {
    LogMethod();
    //this is an array of dictionaries
    
    NSError *error = nil;
    // insert the performers into Core Data
    for (id newExhibit in exhibits) {
        
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Exhibit" inManagedObjectContext:self.managedObjectContext];
        [newManagedObject setValue: [newExhibit valueForKey: @"Name"] forKey:@"name"];
        [newManagedObject setValue: [newExhibit valueForKey: @"Desc_1"] forKey:@"desc1"];
        [newManagedObject setValue: [newExhibit valueForKey: @"Desc_2"] forKey:@"desc2"];
        [newManagedObject setValue: [newExhibit valueForKey: @"Addr_1"] forKey:@"addr1"];
        [newManagedObject setValue: [newExhibit valueForKey: @"Addr_2"] forKey:@"addr2"];
        [newManagedObject setValue: [newExhibit valueForKey: @"Phone_1"] forKey:@"phone1"];
        [newManagedObject setValue: [newExhibit valueForKey: @"Phone_2"] forKey:@"phone2"];
        [newManagedObject setValue: [newExhibit valueForKey: @"Website"] forKey:@"website"];
        [newManagedObject setValue: [newExhibit valueForKey: @"Email"] forKey:@"email"];
        [newManagedObject setValue: [newExhibit valueForKey: @"Video"] forKey:@"video"];
        
        //        // Convert string to date object
        //        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        //        [dateFormatter setDateFormat:@"hh:mm:ss"];
        //        [newManagedObject setValue: [dateFormatter dateFromString: [newExhibit valueForKey: @"Time"]] forKey:@"presentationTime"];
        
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
        
    }
    
}

@end
