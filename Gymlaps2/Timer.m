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
    CFUUIDRef UUID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef UUIDString = CFUUIDCreateString(kCFAllocatorDefault,UUID);
    [self setValue:(__bridge_transfer NSString *)UUIDString forKey:@"uuid"];

}

@end
