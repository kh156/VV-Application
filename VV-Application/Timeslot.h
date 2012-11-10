//
//  Timeslot.h
//  VV-Application
//
//  Created by Kuang Han on 11/10/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Insula, Landmark;

@interface Timeslot : NSManagedObject

@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSNumber * month;
@property (nonatomic, retain) Insula *insula;
@property (nonatomic, retain) NSSet *landmarks;
@end

@interface Timeslot (CoreDataGeneratedAccessors)

- (void)addLandmarksObject:(Landmark *)value;
- (void)removeLandmarksObject:(Landmark *)value;
- (void)addLandmarks:(NSSet *)values;
- (void)removeLandmarks:(NSSet *)values;

@end
