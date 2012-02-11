//
//  IntervalPickerController.m
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntervalPickerController.h"
#import "Timer.h"

@implementation IntervalPickerController
@synthesize pickerView = _pickerView, minutes=_minutes, seconds=_seconds, delegate=_delegate, interval=_interval;

- (CGRect)pickerFrameWithSize:(CGSize)size
{
	CGRect pickerRect = CGRectMake(	0.0,
								   0.0 + 44,
								   size.width,
								   size.height);
	return pickerRect;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        return self;
    }
    return nil;
}

- (id)initWithMinutes:(int)min seconds:(int)sec andInterval:(int)interval{
	
    self.interval = interval;
	if (self.interval == 1) {
		if ((self = [super initWithNibName:@"IntervalOnePickerController" bundle:nil])) {
			
			self.minutes = min;
			self.seconds = sec;
			return self;
		}
		return nil;
	}
	
	else if (self.interval == 2) {
		if ((self = [super initWithNibName:@"IntervalTwoPickerController" bundle:nil])) 
		{
			self.minutes = min;
			self.seconds = sec;
			return self;
            
		}
        return nil;
	}
	
	return nil;
}

- (id)initWithTimer:(Timer*)timer andInterval:(int)interval{
    if (interval==1)
        return [self initWithMinutes:[timer.intervalOneMinutes intValue] seconds:[timer.intervalOneSeconds intValue] andInterval:1];
    else if (interval==2)
        return [self initWithMinutes:[timer.intervalTwoMinutes intValue] seconds:[timer.intervalTwoSeconds intValue] andInterval:2];
    else
        return nil;
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
	[self createPicker];
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

- (void)createPicker {
	self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
	CGSize pickerSize = [self.pickerView sizeThatFits:CGSizeZero];
	self.pickerView.frame = [self pickerFrameWithSize:pickerSize];
	
	self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	self.pickerView.showsSelectionIndicator = YES;	// note this is default to NO
	
	// this view controller is the data source and delegate
	self.pickerView.delegate = self;
	self.pickerView.dataSource = self;
	
	// add this picker to our view controller, initially hidden
	self.pickerView.hidden = NO;
	[self.pickerView selectRow:self.minutes inComponent:0 animated:NO];
	[self.pickerView selectRow:self.seconds inComponent:1 animated:NO];
	
	[self.view addSubview:self.pickerView];
	[self.view bringSubviewToFront:[self.view viewWithTag:1]];
	[self.view bringSubviewToFront:[self.view viewWithTag:2]];    
}

- (IBAction)done {
    if ([self.delegate respondsToSelector:@selector(intervalPickerController:didExitWithMins:andSecs:forInterval:)]) {
        
        [self.delegate intervalPickerController:self didExitWithMins:[self.pickerView selectedRowInComponent:0] andSecs:[self.pickerView selectedRowInComponent:1] forInterval:self.interval];
    }
    
}

#pragma mark pickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;	
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	
	return 60;
}


# pragma mark Delegate methods 

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	
	return [NSString stringWithFormat:@"%d",row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}


@end
