//
//  MainViewController.m
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "SoundEffect.h"

@implementation MainViewController
@synthesize timerSaveLabel;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize screen, saveScreen;
@synthesize timerNameTextField,cancelSaveButton;
@synthesize numberOfLapsLabel, alarmModeLabel, intervalOneMinutesLabel, intervalOneSecondsLabel, intervalTwoMinutesLabel, intervalTwoSecondsLabel, beepModeLabel, setListLabel;
@synthesize infoButton, startButton, resetButton;
@synthesize intervalTimer, alarmTimer;
@synthesize intervalAlarm, startSound, alertSound, endAlarm, whooshSound;
@synthesize screenTimer;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{   
    [super viewDidLoad];
    currentstage = stagestopped;
    
    //TODO: load from timer
    
	intervalOneMinutes = 0;
	intervalOneSeconds = 0;
	intervalTwoMinutes = 0;
	intervalTwoSeconds = 0;
	alarms[0] = 1;
	alarms[1] = 5;
	alarms[2] = 10;
	
    screenTimerModified = NO;
    
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
	self.alertSound = [SoundEffect soundEffectForResourceName:@"Bottle" ofType:@"caf"];
	self.endAlarm = [SoundEffect soundEffectForResourceName:@"End" ofType:@"caf"];
    self.whooshSound = [SoundEffect soundEffectForResourceName:@"Whoosh" ofType:@"caf"];

	// enable touches
    
	[self setTouchesEnabled:YES];
	resetButton.enabled = NO;
    

}

-(void)refreshScreen {
    
    // set interval labels
    [intervalOneMinutesLabel setMinutes:intervalOneMinutes];
    [intervalOneSecondsLabel setSeconds:intervalOneSeconds];    
    [intervalTwoMinutesLabel setMinutes:intervalTwoMinutes];
    [intervalTwoSecondsLabel setSeconds:intervalTwoSeconds];
    
    // set alarm mode label
    
    if (alarmMode == alarmMode1sec)
		alarmModeLabel.text = @"1";
	else if (alarmMode == alarmMode5sec)
		alarmModeLabel.text = @"5";
	else if (alarmMode == alarmMode10sec)
		alarmModeLabel.text = @"10";
    
    // set beep mode label
    if (beepMode == 0)
		beepModeLabel.text = @"BH";
	else if (beepMode == 1)
		beepModeLabel.text = @"V";
    else if (beepMode == 2)
		beepModeLabel.text = @"BHV";
    
    // set laps label
    if (laps == 0)
		numberOfLapsLabel.text = [NSString stringWithFormat:@"00"];
	else
        numberOfLapsLabel.text = [NSString stringWithFormat:@"%d",laps];
    
    // if a saved timer has been modified since last screen refresh, change color to indicate dirty timer
    if (self.screenTimer!=nil) {
        
        setListLabel.text = self.screenTimer.name;
        
        if (screenTimerModified) {
            
            // first check if user has switched timer back to original value
            if (intervalOneMinutes==[screenTimer.intervalOneMinutes intValue] && intervalTwoMinutes==[screenTimer.intervalTwoMinutes intValue] && intervalOneSeconds==[screenTimer.intervalOneSeconds intValue] && intervalTwoSeconds==[screenTimer.intervalTwoSeconds intValue] && laps==[screenTimer.laps intValue] && alarmMode==[screenTimer.alarmMode intValue]) {
                
                screenTimerModified = NO;
                self.setListLabel.textColor = [UIColor blackColor];   

            }
                                                                                                                                                    
            else
                self.setListLabel.textColor = [UIColor redColor];  
        }

        else
            self.setListLabel.textColor = [UIColor blackColor];   
    }
}

#pragma mark - TODO: Make sure SaveScreen is disabled when timer is running
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


- (void)viewDidUnload
{
    screen = nil;
    [self setSaveScreen:nil];
    [self setSaveScreen:nil];
    [self setTimerNameTextField:nil];
    [self setCancelSaveButton:nil];
    [self setTimerSaveLabel:nil];
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
    
    if (label == self.intervalOneMinutesLabel || label == self.intervalOneSecondsLabel)
    {
     
        IntervalPickerController *intervalOnePickerController = [[IntervalPickerController alloc] initWithMinutes:intervalOneMinutes seconds:intervalOneSeconds andInterval:1];
        intervalOnePickerController.delegate = self;
        [self presentModalViewController:intervalOnePickerController animated:YES];
    }
    
    else if (label == self.intervalTwoMinutesLabel || label == self.intervalTwoSecondsLabel)
    {
        
        IntervalPickerController *intervalTwoPickerController = [[IntervalPickerController alloc] initWithMinutes:intervalTwoMinutes seconds:intervalTwoSeconds andInterval:2];
        intervalTwoPickerController.delegate = self;
        [self presentModalViewController:intervalTwoPickerController animated:YES];
    }
	
	else if (label == alarmModeLabel)
	{
			
			AlarmModePickerController *alarmModePickerController = [[AlarmModePickerController alloc] initWithAlarmMode:alarmMode];
			alarmModePickerController.delegate = self;
			[self presentModalViewController:alarmModePickerController animated:YES];
	}
    
	
	else if (label == numberOfLapsLabel)
	{
			LapsPickerController *lapsPickerController = [[LapsPickerController alloc] initWithLaps:laps];
			lapsPickerController.delegate = self;
			[self presentModalViewController:lapsPickerController animated:YES];
	}
    
    else if (label == beepModeLabel)
	{
        BeepModePickerController *beepModePickerController = [[BeepModePickerController alloc] initWithBeepMode:beepMode];
        
        beepModePickerController.delegate = self;
        [self presentModalViewController:beepModePickerController animated:YES];
	}
    
    else if (label == setListLabel) {

        NSManagedObjectContext *context = self.managedObjectContext;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription 
                                       entityForName:@"Timer" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        
        NSError *error;
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (NSManagedObject *info in fetchedObjects) {
            NSLog(@"Name: %@", [info valueForKey:@"name"]);
        }                
        [self loadScreenWithTimer:[fetchedObjects objectAtIndex:([fetchedObjects count]-1)]];
    }
    
}

#pragma mark - Save Screen Methods

- (IBAction)longTap:(UIGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        if (intervalOneMinutes==0&&intervalOneSeconds==0)
        {
            [self showError:@"Intervals have not been set" withSubtitle:@"Double tap screen to set time intervals before saving the timer"];
        }
        
        else{
            
            // figure out what type of save operation must be performed
            
            if (self.screenTimer == nil)
                timerSaveMode = timerSaveNew; // new timer is being saved
            
            else { 
                if (!screenTimerModified) // existing timer name change
                    timerSaveMode = timerEditName;
                    
                else
                    timerSaveMode = timerEditFull;
            }
            
            
            
            [self showSaveScreen];
            [self.timerNameTextField becomeFirstResponder];
        }
        
    }
}

- (void)showSaveScreen{
    
    // set label text based on timerSaveMode
    NSArray *array  = [NSArray arrayWithObjects:@"SAVE NEW TIMER", @"RENAME UNMODIFIED TIMER", @"SAVE MODIFIED TIMER",nil];
    self.timerSaveLabel.text = [array objectAtIndex:timerSaveMode];
    
    screen.alpha = 0.0;    
    if (timerSaveMode==timerEditName||timerSaveMode==timerEditFull) {
        self.timerNameTextField.text = screenTimer.name;
    }
    
    [UIView beginAnimations:@"Save Screen in" context:nil];
    [UIView setAnimationDuration:0.50];
    saveScreen.alpha = 1.0;    
    [UIView commitAnimations];
    [whooshSound play];    
}

- (void)hideSaveScreen{
    saveScreen.alpha = 0.0;    
    
    [UIView beginAnimations:@"Screen in" context:nil];
    [UIView setAnimationDuration:0.50];
    screen.alpha = 1.0;    
    [UIView commitAnimations];
}

// hide save screen
- (IBAction)saveScreenCancelled:(id)sender {
    if ([self.timerNameTextField isFirstResponder])
        [self.timerNameTextField resignFirstResponder];
    
    //clear the textField
    self.timerNameTextField.text = nil;
    [self hideSaveScreen];
}

#pragma mark - Core Data Methods

-(IBAction)saveOnscreenTimer:(id)sender{
    
    
    if ([self.timerNameTextField isFirstResponder])
        [self.timerNameTextField resignFirstResponder];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *t;
    
    if (timerSaveMode==timerSaveNew) {
        t = [NSEntityDescription
             insertNewObjectForEntityForName:@"Timer" 
             inManagedObjectContext:context];
        [t setValue:[NSNumber numberWithInt:intervalOneMinutes] forKey:@"intervalOneMinutes"];
        [t setValue:[NSNumber numberWithInt:intervalOneSeconds] forKey:@"intervalOneSeconds"];
        [t setValue:[NSNumber numberWithInt:intervalTwoMinutes] forKey:@"intervalTwoMinutes"];
        [t setValue:[NSNumber numberWithInt:intervalTwoSeconds] forKey:@"intervalTwoSeconds"];
        [t setValue:[NSNumber numberWithInt:laps] forKey:@"laps"];
        [t setValue:[NSNumber numberWithInt:alarmMode] forKey:@"alarmMode"];
        [t setValue:self.timerNameTextField.text forKey:@"name"];
        
        NSError *error;
        if (![context save:&error]) {
            [self showError:@"Whoops, couldn't save!" withSubtitle:[error localizedDescription]];
            return NO;
        }
        
        self.screenTimer = (Timer*)t;
        [self showInfo:@"Timer Saved" withSubtitle:nil];
        
    }
    
    else if (timerSaveMode==timerEditName) {
        
        if (![self.timerNameTextField.text isEqualToString:screenTimer.name]==1) {
            
            screenTimer.name = timerNameTextField.text;
            NSError *error;
            if (![context save:&error]) {
                [self showError:@"Whoops, couldn't rename!" withSubtitle:[error localizedDescription]];
                return NO;
            }       
            
            [self showInfo:@"Timer Renamed" withSubtitle:nil];
        }
    }
    
    else if (timerSaveMode==timerEditFull) {
        
        if (![self.timerNameTextField.text isEqualToString:screenTimer.name]) {
            t = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Timer" 
                 inManagedObjectContext:context];
            [t setValue:[NSNumber numberWithInt:intervalOneMinutes] forKey:@"intervalOneMinutes"];
            [t setValue:[NSNumber numberWithInt:intervalOneSeconds] forKey:@"intervalOneSeconds"];
            [t setValue:[NSNumber numberWithInt:intervalTwoMinutes] forKey:@"intervalTwoMinutes"];
            [t setValue:[NSNumber numberWithInt:intervalTwoSeconds] forKey:@"intervalTwoSeconds"];
            [t setValue:[NSNumber numberWithInt:laps] forKey:@"laps"];
            [t setValue:[NSNumber numberWithInt:alarmMode] forKey:@"alarmMode"];
            
            [t setValue:self.timerNameTextField.text forKey:@"name"];
            
            NSError *error;
            if (![context save:&error]) {
                [self showError:@"Whoops, couldn't save!" withSubtitle:[error localizedDescription]];
                return NO;
            }
            
            [self showInfo:@"New Timer Saved" withSubtitle:[NSString stringWithFormat:@"Created new timer with the specified name"]];
            self.screenTimer = (Timer*)t;
        }
        
        else {
            screenTimer.intervalOneMinutes = [NSNumber numberWithInt:intervalOneMinutes];
            screenTimer.intervalOneSeconds = [NSNumber numberWithInt:intervalOneSeconds];
            screenTimer.intervalTwoMinutes = [NSNumber numberWithInt:intervalTwoMinutes];
            screenTimer.intervalTwoSeconds = [NSNumber numberWithInt:intervalTwoSeconds];
            screenTimer.laps = [NSNumber numberWithInt:laps];
            screenTimer.alarmMode = [NSNumber numberWithInt:alarmMode];
            // no need to change name
            NSError *error;
            if (![context save:&error]) {
                [self showError:@"Whoops, couldn't save!" withSubtitle:[error localizedDescription]];
                return NO;
            }
            
            [self showInfo:@"Timer Updated" withSubtitle:@"Updated existing timer with matching name"];
        }
    }
    
    
    screenTimerModified = NO; //reset dirty flag as timer has been freshly saved
    [self refreshScreen];
    [self hideSaveScreen];
}

-(void)loadScreenWithTimer:(Timer*)t{
    intervalOneMinutes = [t.intervalOneMinutes intValue];
    intervalOneSeconds = [t.intervalOneSeconds intValue];
    intervalTwoMinutes = [t.intervalTwoMinutes intValue];
    intervalTwoSeconds = [t.intervalTwoSeconds intValue];
    laps = [t.laps intValue];
    alarmMode = [t.alarmMode intValue];
    
    self.screenTimer = t;
    
    // clear the dirty timer flag
    screenTimerModified = NO;
    [self refreshScreen];
}

#pragma mark - Picker Controller Delegates

-(void)intervalPickerController:(id)controller didExitWithMins:(int)mins andSecs:(int)secs forInterval:(int)interval {

    if (interval == 1) {
        if(intervalOneMinutes!=mins || intervalOneSeconds!=secs) {
            // only update if there has been a value change
            screenTimerModified = YES;
            intervalOneMinutes = mins;
            intervalOneSeconds = secs;	
        }
	}
    
    else if (interval == 2) {
        if(intervalTwoMinutes!=mins || intervalTwoSeconds!=secs) {
            screenTimerModified = YES;
            intervalTwoMinutes = mins;
            intervalTwoSeconds = secs;	
        }
	}
    
    [self refreshScreen];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)alarmModePickerController:(id)controller didExitWithAlarmMode:(int)am {
    
    if (alarmMode!=am){
        alarmMode = am;
        screenTimerModified = YES;
        [self refreshScreen];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void)lapsPickerController:(id)controller didExitWithLaps:(int)l {
    
    if(laps!=l) {
        laps = l;
        screenTimerModified = YES;
        [self refreshScreen];
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)beepModePickerController:(id)controller didExitWithBeepMode:(int)bm {
    
    if (beepMode!=bm) {
        beepMode = bm;
        [self refreshScreen];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}



#pragma mark - MKInfoPanel
-(void)showError:(NSString*)error withSubtitle:(NSString*)subtitle{
 [MKInfoPanel showPanelInView:self.view 
                         type:MKInfoPanelTypeError 
                        title:error 
                     subtitle:subtitle 
                    hideAfter:3];
    
    if (beepMode==beepModeBeepHigh)
        [alertSound play];
    else if (beepMode == beepModeBeepHighVibrate)
        [alertSound playVibrate];
    else
        [alertSound vibrate];
}

-(void)showInfo:(NSString*)info withSubtitle:(NSString*)subtitle{
    [MKInfoPanel showPanelInView:self.view 
                            type:MKInfoPanelTypeInfo 
                           title:info 
                        subtitle:subtitle 
                       hideAfter:3];
    
    if (beepMode==beepModeBeepHigh)
        [alertSound play];
    else if (beepMode == beepModeBeepHighVibrate)
        [alertSound playVibrate];
    else
        [alertSound vibrate];
}

@end
