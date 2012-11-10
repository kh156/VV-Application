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
        [gesuiti setInsula_annotation_picture:@""];
        [gesuiti setInsula_general_description:@"Gesuiti_general_description.txt"];
        [gesuiti setInsula_general_picture:@"Gesuiti_general_picture.jpg"];
        [gesuiti setLatitude:[NSNumber numberWithDouble:45.4333]];
        [gesuiti setLongitude:[NSNumber numberWithDouble:12.3167]];
        
        Timeslot *timeslot = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                       inManagedObjectContext:self.managedObjectContext];
        
        timeslot.year = [NSNumber numberWithInt:1508];
        timeslot.month = [NSNumber numberWithInt:10];
        timeslot.insula = gesuiti;
        
        [gesuiti addTimeslotsObject:timeslot];
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
    [scuola setLandmark_annotation_picture:@""];
    [scuola setLandmark_general_description:@"Scuola_general_description.txt"];
    [scuola setLandmark_general_picture:@"Scuola_general_picture.png"];
    [scuola setLatitude:[NSNumber numberWithDouble:45.433]];
    [scuola setLongitude:[NSNumber numberWithDouble:12.316]];
    [scuola addTimeslotsObject:timeslot];
    
    Intermediate *north = (Intermediate *)[NSEntityDescription insertNewObjectForEntityForName:@"Intermediate"
                                                                        inManagedObjectContext:self.managedObjectContext];
    north.num = @"N";
    north.image = @"";
    north.landmark = scuola;
    
    Intermediate *south = (Intermediate *)[NSEntityDescription insertNewObjectForEntityForName:@"Intermediate"
                                                                        inManagedObjectContext:self.managedObjectContext];
    south.num = @"S";
    south.image = @"";
    south.landmark = scuola;
    
    Intermediate *west = (Intermediate *)[NSEntityDescription insertNewObjectForEntityForName:@"Intermediate"
                                                                       inManagedObjectContext:self.managedObjectContext];
    west.num = @"W";
    west.image = @"";
    west.landmark = scuola;
    
    Intermediate *east = (Intermediate *)[NSEntityDescription insertNewObjectForEntityForName:@"Intermediate"
                                                                       inManagedObjectContext:self.managedObjectContext];
    east.num = @"E";
    east.image = @"";
    east.landmark = scuola;
    
    [scuola addIntermediatesObject:north];
    [scuola addIntermediatesObject:south];
    [scuola addIntermediatesObject:west];
    [scuola addIntermediatesObject:east];
    
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
