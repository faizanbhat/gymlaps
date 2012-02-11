//
//  BeepModePickerController.m
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BeepModePickerController.h"

@implementation BeepModePickerController
@synthesize delegate=_delegate,beepModeSegmentedControl=_beepModeSegmentedControl,selectedIndex=_selectedIndex;

- (id)initWithBeepMode:(int)beepMode{
    if (self = [super initWithNibName:@"BeepModePickerController" bundle:nil]) {
		self.selectedIndex = beepMode;
    }
    return self;
}

-(IBAction)done {
	
    if ([self.delegate respondsToSelector:@selector(beepModePickerController:didExitWithBeepMode:)]) {
	
        [self.delegate beepModePickerController:self didExitWithBeepMode:[self.beepModeSegmentedControl selectedSegmentIndex]];
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
    [self.beepModeSegmentedControl setSelectedSegmentIndex:self.selectedIndex];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
