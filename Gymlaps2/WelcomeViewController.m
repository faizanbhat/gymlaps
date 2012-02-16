//
//  WelcomeViewController.m
//  Gymlaps2
//
//  Created by Faizan Bhat on 16/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WelcomeViewController.h"

@implementation WelcomeViewController
@synthesize doneButton;
@synthesize pageImage;
@synthesize pageTitle;
@synthesize pageText;
@synthesize pageControl;
@synthesize nextButton;
@synthesize images,titles,texts;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.images = [NSArray arrayWithObjects:[UIImage imageNamed:@"wc-page1.png"],[UIImage imageNamed:@"wc-page2.png"],[UIImage imageNamed:@"wc-page3.png"],[UIImage imageNamed:@"wc-page4.png"],nil];
        self.titles = [NSArray arrayWithObjects:@"Thank you for purchasing Gymlaps",@"Setting Timers", @"Saving Timers", @"Loading Timers",@"That's all", nil];
        self.texts = [NSArray arrayWithObjects:@"Please take a moment to familiarize yourself with the timer", @"Double tap the screen to choose time intervals and other settings", @"Hold down on the timer name for a split second to save the timer on screen", @"Double tap the timer name to load a saved timer",@"Enjoy your workouts", nil];
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [self setPageTitle:nil];
    [self setPageText:nil];
    [self setNextButton:nil];
    [self setPageControl:nil];
    [self setPageImage:nil];
    [self setDoneButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(IBAction)nextPage{ 


    if ((self.pageControl.currentPage+1)==self.pageControl.numberOfPages) {
        if ([self.delegate respondsToSelector:@selector(welcomeViewControllerDidFinish:)])
            [self.delegate welcomeViewControllerDidFinish:self];
    }
    
    else {
        [self loadPage:self.pageControl.currentPage+1];
    }
}

-(void)loadPage:(int)page {
    
    self.pageControl.currentPage = page;
    
    [UIView beginAnimations:@"page out" context:nil];
    [UIView setAnimationDuration:0.25];
    self.pageImage.alpha = 0;
    self.pageText.alpha = 0;
    self.pageTitle.alpha = 0;
    self.doneButton.alpha = 0;
    [UIView commitAnimations];
    
    if (page!=self.pageControl.numberOfPages-1)
    self.pageImage.image = [self.images objectAtIndex:page];
    self.pageTitle.text = [self.titles objectAtIndex:page];
    self.pageText.text = [self.texts objectAtIndex:page];

    
    [UIView beginAnimations:@"page in" context:nil];
    [UIView setAnimationDuration:0.50];

    if (page!=self.pageControl.numberOfPages-1)
        self.pageImage.alpha = 1;
    else
        self.doneButton.alpha = 1;
    
    self.pageText.alpha = 1;
    self.pageTitle.alpha = 1;
    [UIView commitAnimations];
}


-(IBAction)changePage:(id)sender {
    
    [self loadPage:self.pageControl.currentPage];
}

-(IBAction)done{
 
    if ([self.delegate respondsToSelector:@selector(welcomeViewControllerDidFinish:)])
        [self.delegate welcomeViewControllerDidFinish:self];
    
}


#pragma mark - UIScrollViewDelegate

@end
