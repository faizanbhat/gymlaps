//
//  MainViewController.m
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "IntervalPickerController.h"
#import "BeepModePickerController.h"
#import "AlarmModePickerController.h"
#import "LapsPickerController.h"
#import "SoundEffect.h"
#import "MKInfoPanel.h"
#import "JWFolders.h"

@implementation MainViewController


@synthesize managedObjectContext = _managedObjectContext;
@synthesize numberOfLapsLabel, alarmModeLabel, intervalOneMinutesLabel, intervalOneSecondsLabel, intervalTwoMinutesLabel, intervalTwoSecondsLabel, beepModeLabel, setListLabel;
@synthesize infoButton, startButton, resetButton;
@synthesize intervalTimer, alarmTimer;
@synthesize intervalAlarm, startSound, errorSound, endAlarm;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{   
    [super viewDidLoad];
    currentstage = stagestopped;
    
	intervalOneMinutes = 0;
	intervalOneSeconds = 0;
	intervalTwoMinutes = 0;
	intervalTwoSeconds = 0;
	alarms[0] = 1;
	alarms[1] = 5;
	alarms[2] = 10;
	
	beepMode = beepModeBeepHigh;
	alarmMode = alarmMode1sec;
	laps = 0;
    runs=0;
    
	[self.intervalOneMinutesLabel setDelegate:self];
	[self.intervalTwoMinutesLabel setDelegate:self];
	[self.intervalOneSecondsLabel setDelegate:self];
	[self.intervalTwoSecondsLabel setDelegate:self];
	[self.alarmModeLabel setDelegate:self];
	[self.beepModeLabel setDelegate:self];
	[self.numberOfLapsLabel setDelegate:self];
    [self.setListLabel setDelegate:self];
	
	self.intervalAlarm = [SoundEffect soundEffectForResourceName:@"BH" ofType:@"caf"];
	self.startSound = [SoundEffect soundEffectForResourceName:@"Start" ofType:@"caf"];
	self.errorSound = [SoundEffect soundEffectForResourceName:@"Bottle" ofType:@"caf"];
	self.endAlarm = [SoundEffect soundEffectForResourceName:@"End" ofType:@"caf"];
    
	// enable touches
    
	[self setTouchesEnabled:YES];
	resetButton.enabled = NO;
    

}

-(void)setTouchesEnabled:(BOOL)isEnabled{
	self.intervalOneMinutesLabel.isEnabled = isEnabled;
	self.intervalOneSecondsLabel.isEnabled = isEnabled;
	self.intervalTwoMinutesLabel.isEnabled = isEnabled;
	self.intervalTwoSecondsLabel.isEnabled = isEnabled;
	self.beepModeLabel.isEnabled = isEnabled;
	self.alarmModeLabel.isEnabled = isEnabled;
	self.numberOfLapsLabel.isEnabled = isEnabled;
    self.setListLabel.isEnabled = isEnabled;
	infoButton.userInteractionEnabled = isEnabled;
    infoButton.enabled = isEnabled;
    
}

- (IBAction)longTap:(id)sender {
    NSLog(@"longtap");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

#pragma mark - Touchable Label Delegate

-(void)editLabel:(id)label {
    
    if (label == self.setListLabel) {

    }
}

#pragma mark - Set List View Controller Delegate
-(void)setListViewControllerDidFinish {
    
    [self dismissModalViewControllerAnimated:YES];
    
    
}


@end
