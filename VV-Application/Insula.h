//
//  Insula.h
//  VV-Application
//
//  Created by Kuang Han on 11/10/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Timeslot;

@interface Insula : NSManagedObject

@property (nonatomic, retain) NSString * insula_annotation_description;
@property (nonatomic, retain) NSString * insula_general_description;
@property (nonatomic, retain) NSString * insula_general_picture;
@property (nonatomic, retain) NSString * insula_name;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * insula_annotation_picture;
@property (nonatomic, retain) NSSet *timeslots;
@end

@interface Insula (CoreDataGeneratedAccessors)

- (void)addTimeslotsObject:(Timeslot *)value;
- (void)removeTimeslotsObject:(Timeslot *)value;
- (void)addTimeslots:(NSSet *)values;
- (void)removeTimeslots:(NSSet *)values;

@end
