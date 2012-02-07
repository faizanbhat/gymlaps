//
//  LapsPickerController.h
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LapsPickerControllerDelegate <NSObject>

@required
-(void)lapsPickerController:(id)controller didExitWithLaps:(int)laps;
@end

@class Timer;
@interface LapsPickerController : UIViewController {
    UIPickerView* _pickerView;
	__weak id<LapsPickerControllerDelegate> _delegate;
	int _laps;
}

@property (nonatomic,strong) UIPickerView *pickerView;
@property (weak) id<LapsPickerControllerDelegate> delegate;
@property (nonatomic,assign) int laps;

-(id)initWithLaps:(int)laps;
-(id)initWithTimer:(Timer*)timer;
- (CGRect)pickerFrameWithSize:(CGSize)size;
- (void)createPicker;
- (IBAction)done;

@end
