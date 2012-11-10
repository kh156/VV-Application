//
//  Clickables.h
//  VV-Application
//
//  Created by Kuang Han on 11/10/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Intermediate;

@interface Clickables : NSManagedObject

@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * insula_name;
@property (nonatomic, retain) NSString * landmark_name;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) Intermediate *intermediate;

@end
