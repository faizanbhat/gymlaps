//
//  Timer.m
//  Gymlaps2
//
//  Created by Faizan Bhat on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Timer.h"


@implementation Timer

@dynamic alarmMode;
@dynamic intervalOneMinutes;
@dynamic intervalOneSeconds;
@dynamic intervalTwoMinutes;
@dynamic intervalTwoSeconds;
@dynamic laps;
@dynamic name;
@dynamic uuid;
@dynamic desc;

- (void)awakeFromInsert;
{
    [super awakeFromInsert];
    
    id result = nil;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid) {
        result = (__bridge_transfer id)uuid;
    }
    
    [self setValue:result forKey:@"uuid"];
}

@end
