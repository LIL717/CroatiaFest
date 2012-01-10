//
//  Workshop.m
//  CroatiaFest
//
//  Created by Lori Hill on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Workshop.h"

@implementation Workshop
@dynamic name;
@dynamic presenter;
@dynamic website;
@dynamic desc;
@dynamic panel1;
@dynamic panel2;
@dynamic panel3;
@dynamic panel4;
@dynamic panel5;
@dynamic panel6;
@dynamic linkText;
@dynamic link;
@dynamic presentationTime;

@synthesize managedObjectContext = managedObjectContext_;


- (void)addWorkshopsToCoreData:(NSArray *)workshops {
    LogMethod();
    //this is an array of dictionaries
    
    NSError *error = nil;
    // insert the performers into Core Data
    for (id newWorkshop in workshops) {
        
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Workshop" inManagedObjectContext:self.managedObjectContext];
        [newManagedObject setValue: [newWorkshop valueForKey: @"Name"] forKey:@"name"];
        [newManagedObject setValue: [newWorkshop valueForKey: @"Presenter"] forKey:@"presenter"];
        [newManagedObject setValue: [newWorkshop valueForKey: @"Website"] forKey:@"website"];
        [newManagedObject setValue: [newWorkshop valueForKey: @"Desc"] forKey:@"desc"];
        [newManagedObject setValue: [newWorkshop valueForKey: @"Panel_1"] forKey:@"panel1"];
        [newManagedObject setValue: [newWorkshop valueForKey: @"Panel_2"] forKey:@"panel2"];
        [newManagedObject setValue: [newWorkshop valueForKey: @"Panel_4"] forKey:@"panel4"];
        [newManagedObject setValue: [newWorkshop valueForKey: @"Panel_5"] forKey:@"panel5"];
        [newManagedObject setValue: [newWorkshop valueForKey: @"Panel_6"] forKey:@"panel6"];
        [newManagedObject setValue: [newWorkshop valueForKey: @"link_text"] forKey:@"linkText"];
        [newManagedObject setValue: [newWorkshop valueForKey: @"link"] forKey:@"link"];
        
        // Convert string to date object
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"hh:mm:ss"];
        [newManagedObject setValue: [dateFormatter dateFromString: [newWorkshop valueForKey: @"Time"]] forKey:@"presentationTime"];
        
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%s: Problem saving: %@", __PRETTY_FUNCTION__, error);
        }
        
    }
    
}

@end

