//
//  TouchableLabel.m
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TouchableLabel.h"
#import "SoundEffect.h"

@implementation TouchableLabel
@synthesize delegate = _delegate;
@synthesize touchAllowed = _touchAllowed;
@synthesize clickSound = _clickSound;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        return self;
    }
    return nil;
}

// Method detects double tap and sends the message editLabel: to _delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
	
	if ((touch.tapCount==2 && self.touchAllowed))
    {
            if (self.clickSound == nil)
                self.clickSound = [SoundEffect soundEffectForResourceName:@"Click" ofType:@"caf"];
            
            [self.clickSound play];
            
            [self.delegate editLabel:self];
    }
}

// Method converts from into to string and sets as label text
- (void)setMinutes:(int)time {
    
	if (time<10)
		[super setText:[NSString stringWithFormat:@"0%d:",time]];
	else
		[super setText:[NSString stringWithFormat:@"%d:",time]];
	
}

// Method converts from into to string and sets as label text with a : prefix
- (void)setSeconds:(int)time {
	
	if (time<10)
		[super setText:[NSString stringWithFormat:@"0%d",time]];
	else
		[super setText:[NSString stringWithFormat:@"%d",time]];
}

@end
