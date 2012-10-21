//
//  Monument.h
//  VV-Application
//
//  Created by Kuang Han on 10/21/12.
//  Copyright (c) 2012 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Monument : NSManagedObject

@property (nonatomic, retain) NSString * image_intro;
@property (nonatomic, retain) NSString * image_panelsAndProcession;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * text_history;
@property (nonatomic, retain) NSString * text_intro;
@property (nonatomic, retain) NSString * text_panelsAndProcession;
@property (nonatomic, retain) NSString * text_spaceInPainting;
@property (nonatomic, retain) NSString * video_spaceInPainting;
@property (nonatomic, retain) NSString * video_virtualSpaceConstruct;

@end
