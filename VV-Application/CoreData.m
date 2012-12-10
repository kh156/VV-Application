//
//  CoreData.m
//  VV-Application
//
//  Created by Kuang Han on 10/15/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "CoreData.h"

@interface CoreData()
- (void)initializeData;
- (void)initializeInsula;
- (void)initializeBasilica:(Insula *)insula;
- (void)initializeCistern:(Insula *)insula;
- (void)initializeEquestrian:(Insula *)insula;
- (void)initializeScuola:(Insula *)insula;
@end

@implementation CoreData
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize insulaName, landmarkName;

- (id)init {
    if (self = [super init]) {
        [self initializeData];
    }
    return self;
}

- (void)initializeData {
    self.insulaName = @"Gesuiti";
    self.landmarkName = @"Scuola Grande di San Marco";
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
        
        Timeslot *t1508 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                    inManagedObjectContext:self.managedObjectContext];
        t1508.year = [NSNumber numberWithInt:1508];
        t1508.month = [NSNumber numberWithInt:10];
        t1508.insula_general_description = @"Gesuiti_general_description.txt";
        t1508.insula_general_picture = @"Gesuiti_general_picture_1508.png";
        [gesuiti addTimeslotsObject:t1508];
        
        Timeslot *t2012 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                    inManagedObjectContext:self.managedObjectContext];
        t2012.year = [NSNumber numberWithInt:2012];
        t2012.month = [NSNumber numberWithInt:11];
        t2012.insula_general_description = @"Gesuiti_general_description.txt";
        t2012.insula_general_picture = @"Gesuiti_general_picture_2012.png";
        [gesuiti addTimeslotsObject:t2012];

        [self initializeBasilica:gesuiti];
        [self initializeCistern:gesuiti];
        [self initializeEquestrian:gesuiti];
        [self initializeScuola:gesuiti];
    }
}

- (void)initializeBasilica:(Insula *)insula {
    Landmark *basilica = (Landmark *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmark"
                                                                   inManagedObjectContext:self.managedObjectContext];
    basilica.landmark_name = @"The Basilica di S.S. Giovanni e Paolo";
    basilica.insula_name = @"Gesuiti";
    basilica.landmark_annotation_description = @"Basilica_annotation_description.txt";
    basilica.landmark_annotation_picture = @"Basilica_annotation_picture.jpg";
    basilica.landmark_general_description = @"Basilica_general_description.txt";
    basilica.landmark_general_picture = @"Basilica_general_picture.jpg";
    basilica.latitude = [NSNumber numberWithDouble:45.439342];
    basilica.longitude = [NSNumber numberWithDouble:12.341980];
    basilica.insula = insula;
    [insula addLandmarksObject:basilica];
    
    Timeslot *t2012 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t2012.year = [NSNumber numberWithInt:2012];
    t2012.month = [NSNumber numberWithInt:0];
    t2012.landmark_general_description = @"Basilica_general_description_2012.txt";
    t2012.landmark_general_picture = @"Basilica_general_picture_2012.jpg";
    [basilica addTimeslotsObject:t2012];
}

- (void)initializeCistern:(Insula *)insula {
    
    Landmark *cistern = (Landmark *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmark"
                                                                   inManagedObjectContext:self.managedObjectContext];
    cistern.landmark_name = @"Cistern";
    cistern.insula_name = @"Gesuiti";
    cistern.landmark_annotation_description = @"Cistern_annotation_description.txt";
    cistern.landmark_annotation_picture = @"Cistern_annotation_picture.jpg";
    cistern.landmark_general_description = @"Cistern_general_description.txt";
    cistern.landmark_general_picture = @"Cistern_general_picture.jpg";
    cistern.latitude = [NSNumber numberWithDouble:45.439065];
    cistern.longitude = [NSNumber numberWithDouble:12.341623];
    cistern.insula = insula;
    [insula addLandmarksObject:cistern];
    
    Timeslot *t2012 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t2012.year = [NSNumber numberWithInt:2012];
    t2012.month = [NSNumber numberWithInt:0];
    t2012.landmark_general_description = @"Cistern_general_description_2012.txt";
    t2012.landmark_general_picture = @"Cistern_general_picture_2012.jpg";
    [cistern addTimeslotsObject:t2012];
}

- (void)initializeEquestrian:(Insula *)insula {
    Landmark *equestrian = (Landmark *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmark"
                                                                     inManagedObjectContext:self.managedObjectContext];
    equestrian.landmark_name = @"Equestrian Monument to Bartolommeo Colleoni";
    equestrian.insula_name = @"Gesuiti";
    equestrian.landmark_annotation_description = @"Equestrian_annotation_description.txt";
    equestrian.landmark_annotation_picture = @"Equestrian_annotation_picture.jpg";
    equestrian.landmark_general_description = @"Equestrian_general_description.txt";
    equestrian.landmark_general_picture = @"Equestrian_general_picture.jpg";
    equestrian.latitude = [NSNumber numberWithDouble:45.439187];
    equestrian.longitude = [NSNumber numberWithDouble:12.341398];
    equestrian.insula = insula;
    
    Timeslot *t1475 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1475.year = [NSNumber numberWithInt:1475];
    t1475.month = [NSNumber numberWithInt:0];
    t1475.landmark_general_description = @"Equestrian_general_description_1475.txt";
    t1475.landmark_general_picture = @"Equestrian_general_picture_1475.jpg";
    [equestrian addTimeslotsObject:t1475];
    
    Timeslot *t1478 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1478.year = [NSNumber numberWithInt:1478];
    t1478.month = [NSNumber numberWithInt:0];
    t1478.landmark_general_description = @"Equestrian_general_description_1478.txt";
    t1478.landmark_general_picture = @"Equestrian_general_picture_1478.jpg";
    [equestrian addTimeslotsObject:t1478];
    
    Timeslot *t1481 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1481.year = [NSNumber numberWithInt:1481];
    t1481.month = [NSNumber numberWithInt:0];
    t1481.landmark_general_description = @"Equestrian_general_description_1481.txt";
    t1481.landmark_general_picture = @"Equestrian_general_picture_1481.jpg";
    [equestrian addTimeslotsObject:t1481];
    
    Timeslot *t1482 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1482.year = [NSNumber numberWithInt:1482];
    t1482.month = [NSNumber numberWithInt:0];
    t1482.landmark_general_description = @"Equestrian_general_description_1482.txt";
    t1482.landmark_general_picture = @"Equestrian_general_picture_1482.jpg";
    [equestrian addTimeslotsObject:t1482];
    
    Timeslot *t1488 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1488.year = [NSNumber numberWithInt:1488];
    t1488.month = [NSNumber numberWithInt:0];
    t1488.landmark_general_description = @"Equestrian_general_description_1488.txt";
    t1488.landmark_general_picture = @"Equestrian_general_picture_1488.jpg";
    [equestrian addTimeslotsObject:t1488];
    
    Timeslot *t1489 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1489.year = [NSNumber numberWithInt:1489];
    t1489.month = [NSNumber numberWithInt:0];
    t1489.landmark_general_description = @"Equestrian_general_description_1489.txt";
    t1489.landmark_general_picture = @"Equestrian_general_picture_1489.jpg";
    [equestrian addTimeslotsObject:t1489];
    
    Timeslot *t1492 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1492.year = [NSNumber numberWithInt:1492];
    t1492.month = [NSNumber numberWithInt:0];
    t1492.landmark_general_description = @"Equestrian_general_description_1492.txt";
    t1492.landmark_general_picture = @"Equestrian_general_picture_1492.jpg";
    [equestrian addTimeslotsObject:t1492];
    
    Timeslot *t1495 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1495.year = [NSNumber numberWithInt:1495];
    t1495.month = [NSNumber numberWithInt:0];
    t1495.landmark_general_description = @"Equestrian_general_description_1495.txt";
    t1495.landmark_general_picture = @"Equestrian_general_picture_1495.jpg";
    [equestrian addTimeslotsObject:t1495];
    
    Timeslot *t1496 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1496.year = [NSNumber numberWithInt:1496];
    t1496.month = [NSNumber numberWithInt:0];
    t1496.landmark_general_description = @"Equestrian_general_description_1496.txt";
    t1496.landmark_general_picture = @"Equestrian_general_picture_1496.jpg";
    [equestrian addTimeslotsObject:t1496];
    
    Timeslot *t1782 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1782.year = [NSNumber numberWithInt:1782];
    t1782.month = [NSNumber numberWithInt:0];
    t1782.landmark_general_description = @"Equestrian_general_description_1782.txt";
    t1782.landmark_general_picture = @"Equestrian_general_picture_1782.jpg";
    [equestrian addTimeslotsObject:t1782];
    
    Timeslot *t1796 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1796.year = [NSNumber numberWithInt:1796];
    t1796.month = [NSNumber numberWithInt:0];
    t1796.landmark_general_description = @"Equestrian_general_description_1796.txt";
    t1796.landmark_general_picture = @"Equestrian_general_picture_1796.jpg";
    [equestrian addTimeslotsObject:t1796];
    
    Timeslot *t1829 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1829.year = [NSNumber numberWithInt:1829];
    t1829.month = [NSNumber numberWithInt:0];
    t1829.landmark_general_description = @"Equestrian_general_description_1829.txt";
    t1829.landmark_general_picture = @"Equestrian_general_picture_1829.jpg";
    [equestrian addTimeslotsObject:t1829];
    
    Timeslot *t1917 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1917.year = [NSNumber numberWithInt:1917];
    t1917.month = [NSNumber numberWithInt:0];
    t1917.landmark_general_description = @"Equestrian_general_description_1917.txt";
    t1917.landmark_general_picture = @"Equestrian_general_picture_1917.jpg";
    [equestrian addTimeslotsObject:t1917];
    
    Timeslot *t1940 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1940.year = [NSNumber numberWithInt:1940];
    t1940.month = [NSNumber numberWithInt:0];
    t1940.landmark_general_description = @"Equestrian_general_description_1940.txt";
    t1940.landmark_general_picture = @"Equestrian_general_picture_1940.jpg";
    [equestrian addTimeslotsObject:t1940];
    
    Timeslot *t1990 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1990.year = [NSNumber numberWithInt:1990];
    t1990.month = [NSNumber numberWithInt:0];
    t1990.landmark_general_description = @"Equestrian_general_description_1990.txt";
    t1990.landmark_general_picture = @"Equestrian_general_picture_1990.jpg";
    [equestrian addTimeslotsObject:t1990];
    
    
    [insula addLandmarksObject:equestrian];
}

- (void)initializeScuola:(Insula *)insula {
    Landmark *scuola = (Landmark *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmark"
                                                                 inManagedObjectContext:self.managedObjectContext];
    [scuola setLandmark_name:@"Scuola Grande di San Marco"];
    scuola.insula_name = @"Gesuiti";
    [scuola setLandmark_3d:@"Scuola_3D.obj"];
    [scuola setLandmark_annotation_description:@"Scuola_annotation_description.txt"];
    [scuola setLandmark_annotation_picture:@"Scuola_annotation_picture.jpg"];
    [scuola setLandmark_general_description:@"Scuola_general_description.txt"];
    [scuola setLandmark_general_picture:@"Scuola_general_picture.jpg"];
    [scuola setLandmark_video:@"Scuola_video.m4v"];
    [scuola setLatitude:[NSNumber numberWithDouble:45.439641]];
    [scuola setLongitude:[NSNumber numberWithDouble:12.341350]];
    [scuola setInsula:insula];
    
    Timeslot *t1260 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1260.year = [NSNumber numberWithInt:1260];
    t1260.month = [NSNumber numberWithInt:10];
    t1260.landmark_general_description = @"Scuola_general_description_1260.txt";
    t1260.landmark_general_picture = @"Scuola_general_picture_1260.jpg";
    [scuola addTimeslotsObject:t1260];
    
    Timeslot *t1421 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1421.year = [NSNumber numberWithInt:1421];
    t1421.month = [NSNumber numberWithInt:11];
    t1421.landmark_general_description = @"Scuola_general_description_1421.txt";
    t1421.landmark_general_picture = @"Scuola_general_picture_1421.jpg";
    [scuola addTimeslotsObject:t1421];
    
    Timeslot *t1437 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1437.year = [NSNumber numberWithInt:1437];
    t1437.month = [NSNumber numberWithInt:11];
    t1437.landmark_general_description = @"Scuola_general_description_1437.txt";
    t1437.landmark_general_picture = @"Scuola_general_picture_1437.jpg";
    [scuola addTimeslotsObject:t1437];
    
    Timeslot *t1438 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1438.year = [NSNumber numberWithInt:1438];
    t1438.month = [NSNumber numberWithInt:11];
    t1438.landmark_general_description = @"Scuola_general_description_1438.txt";
    t1438.landmark_general_picture = @"Scuola_general_picture_1438.jpg";
    [scuola addTimeslotsObject:t1438];
    
    Timeslot *t1485 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1485.year = [NSNumber numberWithInt:1485];
    t1485.month = [NSNumber numberWithInt:11];
    t1485.landmark_general_description = @"Scuola_general_description_1485.txt";
    t1485.landmark_general_picture = @"Scuola_general_picture_1485.jpg";
    [scuola addTimeslotsObject:t1485];
    
    Timeslot *t1486 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1486.year = [NSNumber numberWithInt:1486];
    t1486.month = [NSNumber numberWithInt:11];
    t1486.landmark_general_description = @"Scuola_general_description_1486.txt";
    t1486.landmark_general_picture = @"Scuola_general_picture_1486.jpg";
    [scuola addTimeslotsObject:t1486];
    
    Timeslot *t1489 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1489.year = [NSNumber numberWithInt:1489];
    t1489.month = [NSNumber numberWithInt:11];
    t1489.landmark_general_description = @"Scuola_general_description_1489.txt";
    t1489.landmark_general_picture = @"Scuola_general_picture_1489.jpg";
    [scuola addTimeslotsObject:t1489];
    
    Timeslot *t1490 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1490.year = [NSNumber numberWithInt:1490];
    t1490.month = [NSNumber numberWithInt:11];
    t1490.landmark_general_description = @"Scuola_general_description_1490.txt";
    t1490.landmark_general_picture = @"Scuola_general_picture_1490.jpg";
    [scuola addTimeslotsObject:t1490];
    
    Timeslot *t1495 = (Timeslot *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeslot"
                                                                inManagedObjectContext:self.managedObjectContext];
    t1495.year = [NSNumber numberWithInt:1495];
    t1495.month = [NSNumber numberWithInt:11];
    t1495.landmark_general_description = @"Scuola_general_description_1495.txt";
    t1495.landmark_general_picture = @"Scuola_general_picture_1495.jpg";
    [scuola addTimeslotsObject:t1495];
    
    
    Intermediate *north = (Intermediate *)[NSEntityDescription insertNewObjectForEntityForName:@"Intermediate"
                                                                        inManagedObjectContext:self.managedObjectContext];
    north.num = @"N";
    north.image = @"Scuola_intermediate1.png";
    north.landmark = scuola;
    
    Popover *pn1 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    pn1.title = @"Scuola Grande di San Marco";
    pn1.x = [NSNumber numberWithDouble:31];
    pn1.y = [NSNumber numberWithDouble:212];
    pn1.width = [NSNumber numberWithDouble:670];
    pn1.height = [NSNumber numberWithDouble:255];
    pn1.text = @"Scuola_i1_p1.txt";
    pn1.intermediate = north;
    [north addPopoversObject:pn1];
    
    Popover *pn2 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    pn2.title = @"Virtual Space";
    pn2.x = [NSNumber numberWithDouble:45];
    pn2.y = [NSNumber numberWithDouble:477];
    pn2.width = [NSNumber numberWithDouble:85];
    pn2.height = [NSNumber numberWithDouble:115];
    pn2.text = @"Scuola_i1_p2.txt";
    pn2.intermediate = north;
    [north addPopoversObject:pn2];

    Popover *pn3 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                            inManagedObjectContext:self.managedObjectContext];
    pn3.title = @"Virtual Space";
    pn3.x = [NSNumber numberWithDouble:322];
    pn3.y = [NSNumber numberWithDouble:477];
    pn3.width = [NSNumber numberWithDouble:85];
    pn3.height = [NSNumber numberWithDouble:115];
    pn3.text = @"Scuola_i1_p2.txt";
    pn3.intermediate = north;
    [north addPopoversObject:pn3];

    Popover *pn4 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                            inManagedObjectContext:self.managedObjectContext];
    pn4.title = @"Virtual Space";
    pn4.x = [NSNumber numberWithDouble:600];
    pn4.y = [NSNumber numberWithDouble:475];
    pn4.width = [NSNumber numberWithDouble:85];
    pn4.height = [NSNumber numberWithDouble:115];
    pn4.text = @"Scuola_i1_p2.txt";
    pn4.intermediate = north;
    [north addPopoversObject:pn4];

    
    Intermediate *east = (Intermediate *)[NSEntityDescription insertNewObjectForEntityForName:@"Intermediate"
                                                                       inManagedObjectContext:self.managedObjectContext];
    east.num = @"E";
    east.image = @"Scuola_intermediate2.png";
    east.landmark = scuola;
    
    Popover *pe1 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    pe1.title = @"Scuola Grande di San Marco";
    pe1.text = @"Scuola_i1_p1.txt";
    pe1.x = [NSNumber numberWithDouble:0];
    pe1.y = [NSNumber numberWithDouble:206];
    pe1.width = [NSNumber numberWithDouble:542];
    pe1.height = [NSNumber numberWithDouble:437];
    pe1.intermediate = east;
    [east addPopoversObject:pe1];

    Popover *pe2 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                            inManagedObjectContext:self.managedObjectContext];
    pe2.title = @"Virtual Space";
    pe2.text = @"Scuola_i1_p2.txt";
    pe2.x = [NSNumber numberWithDouble:255];
    pe2.y = [NSNumber numberWithDouble:495];
    pe2.width = [NSNumber numberWithDouble:85];
    pe2.height = [NSNumber numberWithDouble:125];
    pe2.intermediate = east;
    [east addPopoversObject:pe2];

    Popover *pe3 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                            inManagedObjectContext:self.managedObjectContext];
    pe3.x = [NSNumber numberWithDouble:697];
    pe3.y = [NSNumber numberWithDouble:243];
    pe3.width = [NSNumber numberWithDouble:142];
    pe3.height = [NSNumber numberWithDouble:138];
    pe3.intermediate = east;
    [east addPopoversObject:pe3];

    Popover *pe4 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                            inManagedObjectContext:self.managedObjectContext];
    pe4.x = [NSNumber numberWithDouble:665];
    pe4.y = [NSNumber numberWithDouble:398];
    pe4.width = [NSNumber numberWithDouble:206];
    pe4.height = [NSNumber numberWithDouble:236];
    pe4.intermediate = east;
    [east addPopoversObject:pe4];

    Popover *pe5 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                            inManagedObjectContext:self.managedObjectContext];
    pe5.x = [NSNumber numberWithDouble:883];
    pe5.y = [NSNumber numberWithDouble:266];
    pe5.width = [NSNumber numberWithDouble:85];
    pe5.height = [NSNumber numberWithDouble:241];
    pe5.intermediate = east;
    [east addPopoversObject:pe5];

    
    Intermediate *south = (Intermediate *)[NSEntityDescription insertNewObjectForEntityForName:@"Intermediate"
                                                                        inManagedObjectContext:self.managedObjectContext];
    south.num = @"S";
    south.image = @"Scuola_intermediate3.png";
    south.landmark = scuola;
    
    Popover *ps5 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                            inManagedObjectContext:self.managedObjectContext];
    ps5.x = [NSNumber numberWithDouble:588];
    ps5.y = [NSNumber numberWithDouble:61];
    ps5.width = [NSNumber numberWithDouble:291];
    ps5.height = [NSNumber numberWithDouble:604];
    ps5.intermediate = south;
    [south addPopoversObject:ps5];

    Popover *ps1 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    ps1.title = @"Scuola Grande di San Marco";
    ps1.text = @"Scuola_i1_p1.txt";
    ps1.x = [NSNumber numberWithDouble:0];
    ps1.y = [NSNumber numberWithDouble:206];
    ps1.width = [NSNumber numberWithDouble:247];
    ps1.height = [NSNumber numberWithDouble:437];
    ps1.intermediate = south;
    [south addPopoversObject:ps1];
    
    Popover *ps2 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    ps2.x = [NSNumber numberWithDouble:263];
    ps2.y = [NSNumber numberWithDouble:208];
    ps2.width = [NSNumber numberWithDouble:84];
    ps2.height = [NSNumber numberWithDouble:435];
    ps2.intermediate = south;
    [south addPopoversObject:ps2];

    Popover *ps3 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    ps3.x = [NSNumber numberWithDouble:416];
    ps3.y = [NSNumber numberWithDouble:242];
    ps3.width = [NSNumber numberWithDouble:142];
    ps3.height = [NSNumber numberWithDouble:138];
    ps3.intermediate = south;
    [south addPopoversObject:ps3];

    Popover *ps4 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    ps4.x = [NSNumber numberWithDouble:374];
    ps4.y = [NSNumber numberWithDouble:407];
    ps4.width = [NSNumber numberWithDouble:206];
    ps4.height = [NSNumber numberWithDouble:236];
    ps4.intermediate = south;
    [south addPopoversObject:ps4];
    
    Popover *ps6 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    ps6.x = [NSNumber numberWithDouble:605];
    ps6.y = [NSNumber numberWithDouble:273];
    ps6.width = [NSNumber numberWithDouble:83];
    ps6.height = [NSNumber numberWithDouble:236];
    ps6.intermediate = south;
    [south addPopoversObject:ps6];

    Popover *ps7 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    ps7.x = [NSNumber numberWithDouble:770];
    ps7.y = [NSNumber numberWithDouble:279];
    ps7.width = [NSNumber numberWithDouble:83];
    ps7.height = [NSNumber numberWithDouble:236];
    ps7.intermediate = south;
    [south addPopoversObject:ps7];

    
    Intermediate *west = (Intermediate *)[NSEntityDescription insertNewObjectForEntityForName:@"Intermediate"
                                                                       inManagedObjectContext:self.managedObjectContext];
    west.num = @"W";
    west.image = @"Scuola_intermediate4.png";
    west.landmark = scuola;
    
    Popover *pw1 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    pw1.x = [NSNumber numberWithDouble:32];
    pw1.y = [NSNumber numberWithDouble:180];
    pw1.width = [NSNumber numberWithDouble:84];
    pw1.height = [NSNumber numberWithDouble:476];
    pw1.intermediate = west;
    [west addPopoversObject:pw1];
    
    Popover *pw2 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                            inManagedObjectContext:self.managedObjectContext];
    pw2.x = [NSNumber numberWithDouble:203];
    pw2.y = [NSNumber numberWithDouble:241];
    pw2.width = [NSNumber numberWithDouble:142];
    pw2.height = [NSNumber numberWithDouble:138];
    pw2.intermediate = west;
    [west addPopoversObject:pw2];

    Popover *pw3 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    pw3.x = [NSNumber numberWithDouble:171];
    pw3.y = [NSNumber numberWithDouble:404];
    pw3.width = [NSNumber numberWithDouble:206];
    pw3.height = [NSNumber numberWithDouble:236];
    pw3.intermediate = west;
    [west addPopoversObject:pw3];

    Popover *pw4 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    pw4.x = [NSNumber numberWithDouble:385];
    pw4.y = [NSNumber numberWithDouble:63];
    pw4.width = [NSNumber numberWithDouble:291];
    pw4.height = [NSNumber numberWithDouble:604];
    pw4.intermediate = west;
    [west addPopoversObject:pw4];

    Popover *pw5 = (Popover *)[NSEntityDescription insertNewObjectForEntityForName:@"Popover"
                                                           inManagedObjectContext:self.managedObjectContext];
    pw5.x = [NSNumber numberWithDouble:684];
    pw5.y = [NSNumber numberWithDouble:470];
    pw5.width = [NSNumber numberWithDouble:331];
    pw5.height = [NSNumber numberWithDouble:197];
    pw5.intermediate = west;
    [west addPopoversObject:pw5];

    [scuola addIntermediatesObject:north];
    [scuola addIntermediatesObject:east];
    [scuola addIntermediatesObject:south];
    [scuola addIntermediatesObject:west];
    
    [insula addLandmarksObject:scuola];
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
