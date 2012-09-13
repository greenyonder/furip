//
//  FfInfoViewController.m
//  Fuehrerschein
//
//  Created by macbook on 06.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FfInfoViewController.h"

@implementation FfInfoViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    
     CGRect fr= [UIScreen mainScreen].bounds    ;
    NSInteger w = fr.size.width;
    NSInteger h = fr.size.height;

    UIScrollView * uisv;
    //////////// BAR
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {

        bar = [[FfBackground alloc] initWithFrame:CGRectMake(0, 0, w, 40)];
         uisv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, w, h)]; 
    } else {
        w = fr.size.height;
        h=fr.size.width;
        bar = [[FfBackground alloc] initWithFrame:CGRectMake(0, 0, w, 40)];
     uisv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, w, h)];
    }
    uisv.backgroundColor = [UIColor redColor];
    UIButton* backb = [[UIButton alloc] init];
    [bar addSubview:backb];
    
    [backb setImage:[UIImage imageNamed:@"furlogob"] forState:UIControlStateNormal];
    
    [backb sizeToFit];
    
    [backb addTarget: self 
              action: @selector(back:) 
    forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:bar];
    
    /////////////////////

       
   
    
    NSString * info = NSLocalizedStringFromTable(@"info", @"InfoPlist", @"");

    
    MyLabel *lbl;
    
       lbl = [[MyLabel alloc] initWithFrame:CGRectMake(0, 0, w , 70)];
        
    lbl.text=info;
    lbl.numberOfLines=0;
    
    CGRect l0rect = [lbl textRectForBounds:lbl.bounds limitedToNumberOfLines:999];

    lbl.frame=CGRectMake(0, 0, w, l0rect.size.height);
    
    lbl.backgroundColor = [UIColor yellowColor];
    [lbl sizeToFit];
    [uisv addSubview:lbl];

    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        lbl.font = [UIFont fontWithName:@"Arial" size:16.0f];
    } else {
        lbl.font = [UIFont fontWithName:@"Arial" size:14.0f];
    }

    
    //[uisv sizeToFit];
//    NSLog(@"framie info y %d" , lbl.frame.origin.y);
    [uisv setContentSize:CGSizeMake(w, h+200)];
    [self.view addSubview:uisv];

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // NSLog(@"back");
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        
        
        
        if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)  return YES;
        return NO;
        
    }
}

@end
