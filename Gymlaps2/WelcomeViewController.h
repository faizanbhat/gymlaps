//
//  WelcomeViewController.h
//  Gymlaps2
//
//  Created by Faizan Bhat on 16/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WelcomeViewControllerDelegate<NSObject>
@required
-(void)welcomeViewControllerDidFinish:(id)controller;
@end

@interface WelcomeViewController : UIViewController  {
    
    NSArray *images;
    NSArray *titles;
    NSArray *texts;
    __unsafe_unretained id<WelcomeViewControllerDelegate> _delegate;
}

@property (assign, nonatomic) IBOutlet UIImageView *pageImage;
@property (assign, nonatomic) IBOutlet UILabel *pageTitle;
@property (assign, nonatomic) IBOutlet UILabel *pageText;
@property (assign, nonatomic) IBOutlet UIPageControl *pageControl;
@property (assign, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *texts;

@property (assign, nonatomic) IBOutlet UIButton *doneButton;
@property (assign, nonatomic) id<WelcomeViewControllerDelegate> delegate;

-(IBAction)changePage:(id)sender;
-(IBAction)nextPage;
-(void)loadPage:(int)page;

@end
