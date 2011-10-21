//
//  MainViewController.m
//  FontDispayer
//
//  Created by Yuichi Fujiki on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

#define kLabelX 20
#define kLabelY 20

@implementation MainViewController

@synthesize scrollView = _scrollView;
@synthesize currentLabelY = _currentLabelY;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    
    [self.view addSubview:self.scrollView];
    
    self.currentLabelY = kLabelY;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];   
    NSArray *fontNames;   
    NSInteger indFamily, indFont;   
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)   {       
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);       
        fontNames = [[NSArray alloc] initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];      
        for (indFont=0; indFont<[fontNames count]; ++indFont)       {           
            NSString * fontName = [fontNames objectAtIndex:indFont];
            NSLog(@"    Font name: %@", fontName);            
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont fontWithName:fontName size:16];
            label.text = fontName;
            CGSize labelSize = [fontName sizeWithFont:label.font];            
            label.frame = CGRectMake(kLabelX, self.currentLabelY, labelSize.width, labelSize.height);            
            [self.scrollView addSubview:label];
            
            self.currentLabelY += labelSize.height;
        }       
    }   
    
    if([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeLeft ||
       [[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeRight)
    {
        [self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.height, self.currentLabelY + 40)];        
    }
    else
    {
        [self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, self.currentLabelY + 40)];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeLeft ||
       [[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeRight)
    {
        [self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.height, self.currentLabelY + 40)];
    }
    else
    {
        [self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, self.currentLabelY + 40)];        
    }
}

@end
