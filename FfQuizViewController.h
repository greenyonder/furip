//
//  FfQuizViewController.h
//  Fuehrerschein
//
//  Created by macbook on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FfBackground.h"
#import "Frage.h"
#import "Data.h"
#import "MyLabel.h"
#import "UFMultiLineButton.h"
#import "FfErrorsViewController.h"




static NSInteger const  NUMFRAGEN = 30;

@interface FfQuizViewController : UIViewController {
    
    NSInteger quiztag;
    Data *datalist;
	MyLabel *lab0;


    
	UIImageView *iv0;
	
	UIButton *btn0;
	UFMultiLineButton *btn1;
	UFMultiLineButton *btn2;
	UFMultiLineButton *btn3;
	
	BOOL btnchk1;
	BOOL btnchk2;
	BOOL btnchk3;
	
	Frage *frage;
	Data *data;
	Bookmark bookmark;
    
FfBackground *bar;
    
}

 



//@property(nonatomic, retain) IBOutlet FfBackground *ffbackground;
@property(nonatomic, retain) Frage *frage;
@property(nonatomic, retain) Data *data;
@property(nonatomic, retain) IBOutlet MyLabel *lab0;




@property(nonatomic, retain) IBOutlet UIImageView *iv0;

//@property(nonatomic, retain) IBOutlet UIButton *btn0;
//@property(nonatomic, retain) IBOutlet UFMultiLineButton *btn1;
//@property(nonatomic, retain) IBOutlet UFMultiLineButton *btn2;
//@property(nonatomic, retain) IBOutlet UFMultiLineButton *btn3;

@property(nonatomic, assign) BOOL btnchk1;
@property(nonatomic, assign) BOOL btnchk2;
@property(nonatomic, assign) BOOL btnchk3;
@property(nonatomic, assign) Bookmark bookmark;


-(void)insertError;
-(IBAction) choose:(id)sender;
-(IBAction) confirm:(id)sender;
-(void)frageToView;

-(void) back:(id)sender;
-(BOOL) isPass;


@end
