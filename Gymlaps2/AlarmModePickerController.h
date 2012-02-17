//
//  AlarmModePickerController.h
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlarmModePickerControllerDelegate <NSObject>

@required
-(void)alarmModePickerController:(id)controller didExitWithAlarmMode:(int)am;
@end

@class Timer;
@interface AlarmModePickerController : UIViewController {
    UISegmentedControl *_alarmModeSegmentedControl;	
	int _selectedIndex;
	__unsafe_unretained id<AlarmModePickerControllerDelegate> _delegate;
    
}

@property (nonatomic,strong) IBOutlet UISegmentedControl *alarmModeSegmentedControl;
@property (nonatomic,assign) int selectedIndex;
@property (assign) id<AlarmModePickerControllerDelegate> delegate;

-(IBAction)done;
-(id)initWithAlarmMode:(int)alarmMode;
-(id)initWithTimer:(Timer*)timer;

@end
