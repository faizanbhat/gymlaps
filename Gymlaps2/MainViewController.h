//
//  MainViewController.h
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"
#import <CoreData/CoreData.h>
#import "TouchableLabel.h"

// beep mode
#define beepModeBeepHigh 0
#define beepModeVibrate 1
#define beepModeBeepHighVibrate 2

// alarm mode
#define alarmMode1sec 0
#define alarmMode5sec 1
#define alarmMode10sec 2

// stages
#define stagestopped 0
#define stageintervalonecountdown 1
#define stagealarmonecountdown 2
#define stageintervaltwocountdown 3
#define stagealarmtwocountdown 4
#define stageintervalonepaused 5
#define stagealarmonepaused 6
#define stageintervaltwopaused 7
#define stagealarmtwopaused 8
#define stagealarmend 9

@class IntervalPickerController,BeepModePickerController,AlarmModePickerController,LapsPickerController, SoundEffect;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,TouchableLabelDelegate> {
    
    TouchableLabel *numberOfLapsLabel;
	TouchableLabel *alarmModeLabel;
	TouchableLabel *intervalOneMinutesLabel;
	TouchableLabel *intervalOneSecondsLabel;
	TouchableLabel *intervalTwoMinutesLabel;
	TouchableLabel *intervalTwoSecondsLabel;
	TouchableLabel *beepModeLabel;
	
	IntervalPickerController *intervalOnePickerController;
	IntervalPickerController *intervalTwoPickerController;
	BeepModePickerController *beepModeController;
	AlarmModePickerController *alarmModeController;
	LapsPickerController *numberOfLapsController;
	
	
	UIButton *infoButton;
	UIButton *setListButton;
	UIButton *startButton;
	UIButton *resetButton;
	
	int intervalOneMinutes;
	int intervalOneSeconds;
	int intervalTwoMinutes;
	int intervalTwoSeconds;
	
	int beepMode;
	int alarmMode;
	int laps;
	int runs;
    
	NSTimer *intervalTimer;
	NSTimer *alarmTimer;
    
	SoundEffect *intervalAlarm;
	SoundEffect *startSound;
	SoundEffect *errorSound;
    SoundEffect *endAlarm;
    
	int timerSeconds;
	int alarmCount;
	int alarms[3];
	int currentLap;
	int currentstage;

}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet TouchableLabel *numberOfLapsLabel;
@property (strong, nonatomic) IBOutlet TouchableLabel *alarmModeLabel;
@property (strong, nonatomic) IBOutlet TouchableLabel *beepModeLabel;
@property (strong, nonatomic) IBOutlet TouchableLabel *intervalOneMinutesLabel;
@property (strong, nonatomic) IBOutlet TouchableLabel *intervalOneSecondsLabel;
@property (strong, nonatomic) IBOutlet TouchableLabel *intervalTwoMinutesLabel;
@property (strong, nonatomic) IBOutlet TouchableLabel *intervalTwoSecondsLabel;
@property (strong, nonatomic) IBOutlet TouchableLabel *setListLabel;

@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *resetButton;

@property (strong, nonatomic) NSTimer *intervalTimer;
@property (strong, nonatomic) NSTimer *alarmTimer;

@property (strong, nonatomic) SoundEffect *intervalAlarm;
@property (strong, nonatomic) SoundEffect *startSound;
@property (strong, nonatomic) SoundEffect *errorSound;
@property (strong, nonatomic) SoundEffect *endAlarm;

- (IBAction)showInfo:(id)sender;
-(void)editLabel:(id)label;
-(void)setTouchesEnabled:(BOOL)isEnabled;

@end
