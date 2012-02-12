//
//  TimerCell.m
//  Gymlaps2
//
//  Created by Faizan Bhat on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimerCell.h"

@implementation TimerCell
@synthesize t1mins;
@synthesize t1secs;
@synthesize t2mins;
@synthesize t2secs;
@synthesize laps;
@synthesize alarmMode;
@synthesize name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(NSString*)textForMinutes:(NSNumber*)min{
    int m = [min intValue];
    if (m<10)
        return [NSString stringWithFormat:@"0%d:",m];
    else return [NSString stringWithFormat:@"%d:",m];
}

+(NSString*)textForSeconds:(NSNumber*)sec{
    int s = [sec intValue];
    if (s<10)
        return [NSString stringWithFormat:@"0%d",s];
    else return [NSString stringWithFormat:@"%d",s];
}
                 
+(NSString*)textForAlarmMode:(NSNumber*)am {
    
    int a = [am intValue];
    
    if (a == 0)
		return @"1";
	else if (a == 1)
		return @"5";
	else if (a == 2)
		return @"10";
    
    else return @"?";
}

+(NSString*)textForLaps:(NSNumber*)laps {
    
    int l = [laps intValue];
    if (l == 0)
		return [NSString stringWithFormat:@"00"];
	else
        return [NSString stringWithFormat:@"%d",l];
}

@end
