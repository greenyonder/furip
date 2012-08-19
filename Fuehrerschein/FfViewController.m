//
//  FfViewController.m
//  Fuehrerschein
//
//  Created by macbook on 16.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FfViewController.h"


@implementation FfViewController 


@synthesize ffbackground;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    UIColor * backg = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"actionbar_background.jpg"]];
    
    UIColor * backg = [UIColor colorWithPatternImage:[UIImage imageNamed:@"actionbar_background.jpg"]];
  
    
    ffbackground.backgroundColor = backg;
    
    UIImageView * logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"furlogo"]];
    
    [ffbackground addSubview:logo];
    
    
                       
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


-(void) openInfo {
    
    FfInfoViewController *infovc = [[FfInfoViewController alloc] initWithNibName:@"FfInfoViewController" bundle:nil];
    infovc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    
    
    
    [self presentViewController: infovc animated:YES completion:nil];
    
}

- (IBAction)buttonPressed:(id)sender {
    NSInteger tag= [sender tag];
    
 //   NSLog(@"tag: %d" , tag);
    
    if (tag==10) [self openInfo];
    
    if (tag>=0 && tag <=5) {
        
        [self openQuiz:tag];
    }
    
    if (tag==8) exit(0);
}

-(void) openQuiz:(NSInteger)intquiz {
    
    FfQuizViewController *vcquiz = [[FfQuizViewController alloc] initWithNibName:@"FfQuizViewController" bundle:nil];
    vcquiz.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    
    [vcquiz setValue:[NSString stringWithFormat:@"%d", intquiz] forKey:@"quiztag"];
    
    
    [self presentViewController: vcquiz animated:YES completion:nil];
    
}



-(IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Optionen" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"fehler",@"reset fehler", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleAutomatic;
    [popupQuery showInView:self.view];
    
    
}


-(void) actionSheet:(UIActionSheet *)actionSheet 
didDismissWithButtonIndex:(NSInteger)buttonIndex
 {
    //NSLog(@"button %d" , buttonIndex);
     if (buttonIndex==0) {
         // fehler
         
         FfErrorsViewController *vcerr = [[FfErrorsViewController alloc] initWithNibName:@"FfErrorsViewController" bundle:nil];
         vcerr.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
[vcerr setValue:@"9" forKey:@"quiztag"];
[vcerr setValue:@"0" forKey:@"quid"];         
         
         [self presentViewController: vcerr animated:YES completion:nil];

     } else if (buttonIndex==1) {
         //reset
         //NSString *dbName = @"fragenfur.db";
         //NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
//         NSMutableArray *dataList;
         //creiamo la lista degli autori
         Data *dataTmp;
            
         dataTmp = [[Data alloc]  init] ;
         [dataTmp resetFehler:@" 1 , 2 , 3 , 4 , 5 "];
         
         
        // [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
     }
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
