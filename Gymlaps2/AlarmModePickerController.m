//
//  AlarmModePickerController.m
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AlarmModePickerController.h"
#import "Timer.h"

@implementation AlarmModePickerController
@synthesize delegate = _delegate;
@synthesize selectedIndex = _selectedIndex;
@synthesize alarmModeSegmentedControl = _alarmModeSegmentedControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithSelectedSegmentedIndex:(int)index{
    if (self = [self initWithNibName:@"AlarmModePickerController" bundle:nil]) {
		self.selectedIndex = index;
        return self;
    }
    return nil;
}

- (id)initWithTimer:(Timer*)timer {
    
    if (self = [self initWithNibName:@"AlarmModePickerController" bundle:nil]) 
        {
            switch ([timer.alarm intValue]) {
                case 1:
                    self.selectedIndex = 0;
                    break;
                case 5:
                    self.selectedIndex = 1;
                    break;
                case 10:
                    self.selectedIndex = 2;
                    break;
                default:
                    NSLog(@"AlarmModePickerController encountered an unrecognized alarm setting on timer");
                    break;
            }
            return self;
        }
    return nil;
}

-(IBAction)done {
	
    int modes[3];
    modes[0]=1;
    modes[1]=5;
    modes[2]=10;
    if ([self.delegate respondsToSelector:@selector(alarmModePickerController:didExitWithAlarmMode:)]) {
        [self.delegate alarmModePickerController:self didExitWithAlarmMode:(modes[self.alarmModeSegmentedControl.selectedSegmentIndex])];
    }        
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.alarmModeSegmentedControl setSelectedSegmentIndex:self.selectedIndex];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
