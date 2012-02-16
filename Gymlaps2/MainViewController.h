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
#import "Timer.h"
#import "IntervalPickerController.h"
#import "AlarmModePickerController.h"
#import "LapsPickerController.h"
#import "BeepModePickerController.h"
#import "MKInfoPanel.h"
#import "SetlistViewController.h"

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

// timer save modes
#define timerSaveNew 0
#define timerEditName 1
#define timerEditFull 2

@class BeepModePickerController,AlarmModePickerController,LapsPickerController, SoundEffect;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,TouchableLabelDelegate,IntervalPickerControllerDelegate, AlarmModePickerControllerDelegate, LapsPickerControllerDelegate, BeepModePickerControllerDelegate, SetlistViewControllerDelegate> {
    
    UIView *screen;

    TouchableLabel *numberOfLapsLabel;
	TouchableLabel *alarmModeLabel;
	TouchableLabel *intervalOneMinutesLabel;
	TouchableLabel *intervalOneSecondsLabel;
	TouchableLabel *intervalTwoMinutesLabel;
	TouchableLabel *intervalTwoSecondsLabel;
	TouchableLabel *beepModeLabel;
		
	UIButton *infoButton;
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
	SoundEffect *alertSound;
    SoundEffect *endAlarm;
    SoundEffect *whooshSound;
    
	int timerSeconds;
	int alarmCount;
	int alarms[3];
	int currentLap;
	int currentstage;

    // The screenTimer variable is here only for loading and saving timers
    Timer *screenTimer;
    
    
    BOOL screenTimerModified; // Whether timer on screen has been edited without saving
    
    // this is to determine whether new timer is being saved or existing one is being updated.
    int timerSaveMode;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UIView *screen;
@property (strong, nonatomic) IBOutlet UIView *saveScreen;
@property (strong, nonatomic) IBOutlet UITextField *timerNameTextField;
@property (strong, nonatomic) IBOutlet UIButton *cancelSaveButton;
@property (strong, nonatomic) IBOutlet UILabel *timerSaveLabel;

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
@property (strong, nonatomic) SoundEffect *alertSound;
@property (strong, nonatomic) SoundEffect *endAlarm;
@property (strong, nonatomic) SoundEffect *whooshSound;

@property (strong, nonatomic) Timer *screenTimer;

- (IBAction)showInfo:(id)sender;
-(void)editLabel:(id)label;
-(void)setTouchesAllowed:(BOOL)isAllowed;
- (IBAction)longTap:(UIGestureRecognizer*)sender;

-(void)intervalPickerController:(id)controller didExitWithMins:(int)mins andSecs:(int)secs forInterval:(int)interval;
-(void)alarmModePickerController:(id)controller didExitWithAlarmMode:(int)am;
-(void)lapsPickerController:(id)controller didExitWithLaps:(int)l;
-(void)beepModePickerController:(id)controller didExitWithBeepMode:(int)bm;
-(IBAction)saveOnscreenTimer:(id)sender;
-(void)refreshScreen;
-(void)showSaveScreen;
-(void)hideSaveScreen;
-(void)loadScreenWithTimer:(Timer*)t;
-(void)showError:(NSString*)error withSubtitle:(NSString*)subtitle;
-(void)showInfo:(NSString*)info withSubtitle:(NSString*)subtitle;
-(void)setlistViewControllerDidCancel:(id)controller;
-(void)setlistViewController:(id)controller didLoadTimer:(Timer*)t;
-(void)setlistViewControllerDidDeleteTimer:(Timer*)timer;

// Timer
-(IBAction)start;
-(IBAction)reset;
-(void)startOne;
-(void)startTwo;
-(void)nextLap;
-(void)startAlarmOne;
-(void)startAlarmTwo;
-(void)intervalOrEndAlarm;
-(void)stop;
-(void)pauseForExit;

@end
