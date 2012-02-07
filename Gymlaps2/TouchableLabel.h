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
    
    //__weak indicates a weak reference
	__weak id<TouchableLabelDelegate> _delegate;
	BOOL _isEnabled;
	SoundEffect* _clickSound;
}

@property (weak)  id<TouchableLabelDelegate> delegate;
@property (assign,nonatomic) BOOL isEnabled;
@property (strong,nonatomic) SoundEffect *clickSound;

-(void)setMinutes:(int)time;
-(void)setSeconds:(int)time;



@end
