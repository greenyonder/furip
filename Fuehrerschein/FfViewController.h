//
//  FfViewController.h
//  Fuehrerschein
//
//  Created by macbook on 16.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FfBackground.h"
#import "FfQuizViewController.h"
#import "FfErrorsViewController.h"
#import "FfInfoViewController.h"


@interface FfViewController : UIViewController <UIActionSheetDelegate> {

    
}


@property(nonatomic, retain) IBOutlet FfBackground *ffbackground;



-(void) openQuiz:(NSInteger) intquiz;


-(IBAction)showActionSheet:(id)sender;

@end
