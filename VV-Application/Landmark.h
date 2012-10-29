//
//  Landmark.h
//  VV-Application
//
//  Created by Kuang Han on 10/29/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Insula;

@interface Landmark : NSManagedObject

@property (nonatomic, retain) NSString * insula_name;
@property (nonatomic, retain) NSString * landmark_name;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * landmark_annotation_description;
@property (nonatomic, retain) NSString * landmark_general_description;
@property (nonatomic, retain) NSString * landmark_3d;
@property (nonatomic, retain) NSString * landmark_intermediate2;
@property (nonatomic, retain) NSString * landmark_general_picture;
@property (nonatomic, retain) NSString * landmark_intermediate1;
@property (nonatomic, retain) NSString * landmark_intermediate3;
@property (nonatomic, retain) NSString * landmark_intermediate4;
@property (nonatomic, retain) NSString * landmark_intermediate5;
@property (nonatomic, retain) Insula *insula;

@end
