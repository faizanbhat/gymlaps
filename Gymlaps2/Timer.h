//
//  Timer.h
//  Gymlaps2
//
//  Created by Faizan Bhat on 07/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Timer : NSManagedObject

@property (nonatomic, retain) NSNumber * alarm;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * intervalOneMins;
@property (nonatomic, retain) NSNumber * intervalOneSecs;
@property (nonatomic, retain) NSNumber * intervalTwoMins;
@property (nonatomic, retain) NSNumber * intervalTwoSecs;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * laps;

@end
