//  SetlistViewController.h
//  Gymlaps2
//
//  Created by Faizan Bhat on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Timer.h"
@protocol SetlistViewControllerDelegate <NSObject>
@required
-(void)setlistViewController:(id)controller didLoadTimer:(Timer*)t;
-(void)setlistViewControllerDidCancel:(id)controller;
-(void)setlistViewControllerDidDeleteTimer:(Timer*)timer;
@end

@interface SetlistViewController : UITableViewController {
    NSArray *_timers;
    __unsafe_unretained id<SetlistViewControllerDelegate> _delegate;
}

@property (nonatomic,strong) NSArray *timers;
@property (nonatomic,assign) id<SetlistViewControllerDelegate> delegate;

-(NSArray*)fetchTimers;

@end

