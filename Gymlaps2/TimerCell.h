//
//  TimerCell.h
//  Gymlaps2
//
//  Created by Faizan Bhat on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *t1mins;
@property (strong, nonatomic) IBOutlet UILabel *t1secs;
@property (strong, nonatomic) IBOutlet UILabel *t2mins;
@property (strong, nonatomic) IBOutlet UILabel *t2secs;
@property (strong, nonatomic) IBOutlet UILabel *laps;
@property (strong, nonatomic) IBOutlet UILabel *alarmMode;
@property (strong, nonatomic) IBOutlet UILabel *name;

+(NSString*)textForMinutes:(NSNumber*)min;
+(NSString*)textForSeconds:(NSNumber*)sec;
+(NSString*)textForAlarmMode:(NSNumber*)am;
+(NSString*)textForLaps:(NSNumber*)laps;

@end
