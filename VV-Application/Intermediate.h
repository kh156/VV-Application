//
//  Intermediate.h
//  VV-Application
//
//  Created by Kuang Han on 11/10/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Clickables, Landmark;

@interface Intermediate : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * num;
@property (nonatomic, retain) Landmark *landmark;
@property (nonatomic, retain) NSSet *clickables;
@end

@interface Intermediate (CoreDataGeneratedAccessors)

- (void)addClickablesObject:(Clickables *)value;
- (void)removeClickablesObject:(Clickables *)value;
- (void)addClickables:(NSSet *)values;
- (void)removeClickables:(NSSet *)values;

@end
