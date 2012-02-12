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
@end

@interface SetlistViewController : UITableViewController {
    NSArray *_timers;
    __weak id<SetlistViewControllerDelegate> _delegate;
    
}

@property (nonatomic,strong) NSArray *timers;
@property (nonatomic,weak) id<SetlistViewControllerDelegate> delegate;

-(NSArray*)fetchTimers;

@end

