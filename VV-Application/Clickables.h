//
//  Clickables.h
//  VV-Application
//
//  Created by Kuang Han on 10/29/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Clickables : NSManagedObject

@property (nonatomic, retain) NSString * insula_name;
@property (nonatomic, retain) NSString * landmark_name;
@property (nonatomic, retain) NSString * landmark_intermediate_num;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSNumber * height;

@end
