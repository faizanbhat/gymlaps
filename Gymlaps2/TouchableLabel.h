//
//  TouchableLabel.h
//  Gymlaps2
//
//  Created by Faizan Bhat on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TouchableLabelDelegate<NSObject>

@required
-(void)editLabel:(id)label;
@end

@class SoundEffect;
@interface TouchableLabel : UILabel {
    
    //__unsafe_unretained indicates a assign reference
	__unsafe_unretained id<TouchableLabelDelegate> _delegate;
	BOOL _touchAllowed;
	SoundEffect* _clickSound;
}

@property (assign)  id<TouchableLabelDelegate> delegate;
@property (assign,nonatomic) BOOL touchAllowed;
@property (strong,nonatomic) SoundEffect *clickSound;

-(void)setMinutes:(int)time;
-(void)setSeconds:(int)time;



@end
