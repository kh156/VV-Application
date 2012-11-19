//
//  CoreData.m
//  VV-Application
//
//  Created by Kuang Han on 10/15/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "CoreData.h"

@implementation CoreData
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (id)init {
    if (self = [super init]) {
        [self initializeData];
    }
    return self;
}

- (void)initializeData {
    [self initializeInsula];
}

- (void)initializeInsula {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Insula" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:des];
    NSPredicate *query = [NSPredicate predicateWithFormat:@"insula_name == %@", @"Gesuiti"];
    [request setPredicate:query];
    NSArray *fetchResults = [self.managedObjectContext executeFetchRequest:request error:NULL];
    if (fetchResults.count == 0) {
        Insula *gesuiti = (Insula *)[NSEntityDescription insertNewObjectForEntityForName:@"Insula"
                                                                  inManagedObjectContext:self.managedObjectContext];
        [gesuiti setInsula_name:@"Gesuiti"];
        [gesuiti setInsula_annotation_description:@"Gesuiti_annotation_description.txt"];
        [gesuiti setInsula_annotation_picture:@"Gesuiti_annotation_picture.jpg"];
        [gesuiti setInsula_general_description:@"Gesuiti_general_description.txt"];
        [gesuiti setInsula_general_picture:@"VisualizingVeniceLogo.jpg"];
        [gesuiti setLatitude:[NSNumber numberWithDouble:45.4333]];
        [gesuiti setLongitude:[NSNumber numberWithDouble:12.3167]];
        
        Timeslot *timeslot = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                       inManagedObjectContext:self.managedObjectContext];
        
        timeslot.year = [NSNumber numberWithInt:1508];
        timeslot.month = [NSNumber numberWithInt:10];
        timeslot.insula = gesuiti;
        
        Timeslot *timeslot2 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                       inManagedObjectContext:self.managedObjectContext];
        timeslot.year = [NSNumber numberWithInt:2012];
        timeslot.month = [NSNumber numberWithInt:11];
        timeslot.insula = gesuiti;
        
        
        [gesuiti addTimeslotsObject:timeslot];
        [gesuiti addTimeslotsObject:timeslot2];
        [self initializeLandmark:timeslot];
    }
}

- (void)initializeLandmark:(Timeslot *)timeslot {
    Landmark *scuola = (Landmark *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmark"
                                                                 inManagedObjectContext:self.managedObjectContext];
    [scuola setLandmark_name:@"Scuola Grande di San Marco"];
    [scuola setInsula_name: @"Gesuiti"];
    [scuola setLandmark_3d:@"house.obj"];
    [scuola setLandmark_annotation_description:@"Scuola_annotation_description.txt"];
    [scuola setLandmark_annotation_picture:@"Scuola_annotation_picture.jpg"];
    [scuola setLandmark_general_description:@"Scuola_general_description.txt"];
    [scuola setLandmark_general_picture:@"Scuola_general_picture.png"];
    [scuola setLandmark_video:@"Scuola_video.m4v"];
    [scuola setLatitude:[NSNumber numberWithDouble:45.433]];
    [scuola setLongitude:[NSNumber numberWithDouble:12.316]];
    [scuola addTimeslotsObject:timeslot];
    
    Intermediate *north = (Intermediate *)[NSEntityDescription insertNewObjectForEntityForName:@"Intermediate"
                                                                        inManagedObjectContext:self.managedObjectContext];
    north.num = @"N";
    north.image = @"Scuola_intermediate1.png";
    north.landmark = scuola;

    Popover *p1 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                                inManagedObjectContext:self.managedObjectContext];
    p1.title = @"Scoula Grande di San Marco";
    p1.x = [NSNumber numberWithDouble:50.0];
    p1.y = [NSNumber numberWithDouble:50.0];
    p1.width = [NSNumber numberWithDouble:1386 - 50];
    p1.height = [NSNumber numberWithDouble:967 - 50];
    p1.text = @"Scoula_i1_p1.txt";
    p1.intermediate = north;
    [north addPopoversObject:p1];
    
    Popover *p2 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    p2.title = @"Virtual Space";
    p2.x = [NSNumber numberWithDouble:40.0];
    p2.y = [NSNumber numberWithDouble:967.0];
    p2.width = [NSNumber numberWithDouble:1386 - 40];
    p2.height = [NSNumber numberWithDouble:1326 - 967];
    p2.text = @"Scoula_i1_p2.txt";
    p2.intermediate = north;
    [north addPopoversObject:p2];

    
    Intermediate *east = (Intermediate *)[NSEntityDescription insertNewObjectForEntityForName:@"Intermediate"
                                                                       inManagedObjectContext:self.managedObjectContext];
    east.num = @"E";
    east.image = @"Scuola_intermediate2.png";
    east.landmark = scuola;
    
    Popover *p3 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    p3.x = [NSNumber numberWithDouble:0];
    p3.y = [NSNumber numberWithDouble:65];
    p3.width = [NSNumber numberWithDouble:1422 - 0];
    p3.height = [NSNumber numberWithDouble:912 - 65];
    p3.intermediate = east;
    [east addPopoversObject:p3];

    Popover *p4 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    p4.x = [NSNumber numberWithDouble:44];
    p4.y = [NSNumber numberWithDouble:918];
    p4.width = [NSNumber numberWithDouble:1424 - 44];
    p4.height = [NSNumber numberWithDouble:1344 - 918];
    p4.intermediate = east;
    [east addPopoversObject:p4];
    
    
    Intermediate *south = (Intermediate *)[NSEntityDescription insertNewObjectForEntityForName:@"Intermediate"
                                                                        inManagedObjectContext:self.managedObjectContext];
    south.num = @"S";
    south.image = @"Scuola_intermediate3.png";
    south.landmark = scuola;
    
    Popover *p5 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    p5.x = [NSNumber numberWithDouble:0];
    p5.y = [NSNumber numberWithDouble:0];
    p5.width = [NSNumber numberWithDouble:1097 - 0];
    p5.height = [NSNumber numberWithDouble:988 - 0];
    p5.intermediate = south;
    [south addPopoversObject:p5];

    Popover *p6 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    p6.x = [NSNumber numberWithDouble:0];
    p6.y = [NSNumber numberWithDouble:988];
    p6.width = [NSNumber numberWithDouble:1097 - 0];
    p6.height = [NSNumber numberWithDouble:1401 - 988];
    p6.intermediate = south;
    [south addPopoversObject:p6];

    
    Intermediate *west = (Intermediate *)[NSEntityDescription insertNewObjectForEntityForName:@"Intermediate"
                                                                       inManagedObjectContext:self.managedObjectContext];
    west.num = @"W";
    west.image = @"Scuola_intermediate4.png";
    west.landmark = scuola;
    
    Popover *p7 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    p7.x = [NSNumber numberWithDouble:0];
    p7.y = [NSNumber numberWithDouble:313];
    p7.width = [NSNumber numberWithDouble:527 - 0];
    p7.height = [NSNumber numberWithDouble:988 - 313];
    p7.intermediate = west;
    [west addPopoversObject:p7];
    
    Popover *p8 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    p8.x = [NSNumber numberWithDouble:0];
    p8.y = [NSNumber numberWithDouble:988];
    p8.width = [NSNumber numberWithDouble:527 - 0];
    p8.height = [NSNumber numberWithDouble:1405 - 988];
    p8.intermediate = west;
    [west addPopoversObject:p8];
    
    [scuola addIntermediatesObject:north];
    [scuola addIntermediatesObject:east];
    [scuola addIntermediatesObject:south];
    [scuola addIntermediatesObject:west];
    
    [timeslot addLandmarksObject:scuola];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"VV-Application" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"VV-Application.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
