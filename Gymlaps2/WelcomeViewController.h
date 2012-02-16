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
    __weak id<WelcomeViewControllerDelegate> _delegate;
}

@property (weak, nonatomic) IBOutlet UIImageView *pageImage;
@property (weak, nonatomic) IBOutlet UILabel *pageTitle;
@property (weak, nonatomic) IBOutlet UILabel *pageText;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *texts;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) id<WelcomeViewControllerDelegate> delegate;

-(IBAction)changePage:(id)sender;
-(IBAction)nextPage;
-(void)loadPage:(int)page;

@end
