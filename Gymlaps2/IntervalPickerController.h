//
//  IntervalPickerController.h
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IntervalPickerControllerDelegate <NSObject>
@required
-(void)intervalPickerController:(id)controller didExitWithMins:(int)mins andSecs:(int)secs forInterval:(int)interval;
@end

@class Timer;
@interface IntervalPickerController : UIViewController {
    UIPickerView* _pickerView;
	__weak id<IntervalPickerControllerDelegate> _delegate;
	int _minutes;
	int _seconds;
    int _interval;
}

@property (strong,nonatomic) UIPickerView *pickerView;
@property (weak) id<IntervalPickerControllerDelegate> delegate;
@property (nonatomic,assign) int minutes, seconds, interval;

- (id)initWithMinutes:(int)min seconds:(int)sec andInterval:(int)interval;
- (id)initWithTimer:(Timer*)timer andInterval:(int)interval;
- (void)createPicker;
- (CGRect)pickerFrameWithSize:(CGSize)size;
@end
