//
//  MapAnnotation.m
//  VV-Application
//
//  Created by Nicholas Gordon on 10/18/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address latitude:(double) latitude longitude:(double) longitude {
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude;
        coordinate.longitude = longitude;
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return _name;
}

- (NSString *)subtitle {
    return _address;
}


@end