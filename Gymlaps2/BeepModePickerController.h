//
//  BeepModePickerController.h
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BeepModePickerControllerDelegate <NSObject>

@required
-(void)beepModePickerController:(id)controller didExitWithBeepMode:(int)bm;
@end

@interface BeepModePickerController : UIViewController {
    UISegmentedControl *_beepModeSegmentedControl;	
	int _selectedIndex;
	__weak id<BeepModePickerControllerDelegate> _delegate;
    
}

@property (nonatomic,strong) IBOutlet UISegmentedControl *beepModeSegmentedControl;
@property (nonatomic,assign) int selectedIndex;
@property (weak) id<BeepModePickerControllerDelegate> delegate;

-(IBAction)done;
-(id)initWithBeepMode:(int)beepMode;

@end
