//
//  LapsPickerController.m
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LapsPickerController.h"
#import "Timer.h"
@implementation LapsPickerController
@synthesize laps=_laps, delegate=_delegate, pickerView=_pickerView;

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
        // Custom initialization
    }
    return self;
}

-(id)initWithLaps:(int)laps {
	
	if ((self = [super initWithNibName:@"LapsPickerController" bundle:nil])) {
        
		self.laps = laps;
		return self;
	}	
    return nil;
}

-(id)initWithTimer:(Timer*)timer{
	if ((self = [super initWithNibName:@"LapsPickerController" bundle:nil])) {
        self.laps = [timer.laps intValue];
        return self;
    }
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

-(void)createPicker {
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
	[self.pickerView selectRow:self.laps inComponent:0 animated:NO];
	
	[self.view addSubview:self.pickerView];	
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

- (IBAction)done {
    
    if ([self.delegate respondsToSelector:@selector(lapsPickerController:didExitWithLaps:)]) {
        [self.delegate lapsPickerController:self didExitWithLaps:[self.pickerView selectedRowInComponent:0]];
    }
	
}

#pragma mark pickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;	
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	
	return 21;
}

# pragma mark Delegate methods 

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	
	if (row == 0)
		return [NSString stringWithFormat:@"Infinite"];
	else
        return [NSString stringWithFormat:@"%d",row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}


@end
