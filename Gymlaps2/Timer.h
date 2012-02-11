//
//  Timer.h
//  Gymlaps2
//
//  Created by Faizan Bhat on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Timer : NSManagedObject

@property (nonatomic, retain) NSNumber * alarmMode;
@property (nonatomic, retain) NSNumber * intervalOneMinutes;
@property (nonatomic, retain) NSNumber * intervalOneSeconds;
@property (nonatomic, retain) NSNumber * intervalTwoMinutes;
@property (nonatomic, retain) NSNumber * intervalTwoSeconds;
@property (nonatomic, retain) NSNumber * laps;
@property (nonatomic, retain) NSString * name;

@end
