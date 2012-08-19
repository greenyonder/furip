//
//  FfQuizViewController.m
//  Fuehrerschein
//
//  Created by macbook on 17.0.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FfQuizViewController.h"

@implementation FfQuizViewController



@synthesize lab0;


@synthesize iv0;
//@synthesize btn0;
//@synthesize btn1;
//@synthesize btn2;
//@synthesize btn3;

@synthesize btnchk1;
@synthesize btnchk2;
@synthesize btnchk3;
@synthesize frage;
@synthesize data;

@synthesize bookmark;

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

//+ (BOOL)accessInstanceVariablesDirectly {
//    return NO;
//}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     CGRect fr= [UIScreen mainScreen].bounds    ;
    
    //////////// BAR
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        bar = [[FfBackground alloc] initWithFrame:CGRectMake(0, 0, fr.size.width, 40)];
    } else {
        bar = [[FfBackground alloc] initWithFrame:CGRectMake(0, 0, fr.size.height, 40)];
    }

    UIButton* backb = [[UIButton alloc] init];
     [bar addSubview:backb];
    
    [backb setImage:[UIImage imageNamed:@"furlogob"] forState:UIControlStateNormal];

    [backb sizeToFit];

    [backb addTarget: self 
              action: @selector(back:) 
     forControlEvents: UIControlEventTouchUpInside];
   // NSLog(@"width %f" , fr.size.width);
   // NSLog(@"width %f" , fr.size.height);
    
    UIButton* fehlerb = [[UIButton alloc] initWithFrame:CGRectMake(bar.frame.size.width-bar.frame.size.height, -1, 0, 0)];
   // UIButton* fehlerb = [[UIButton alloc] init];
 
    [bar addSubview:fehlerb];
    
    [fehlerb setImage:[UIImage imageNamed:@"ipfuroptionpic"] forState:UIControlStateNormal];
    [fehlerb sizeToFit];
    [fehlerb setBounds:CGRectMake(0,0, bar.frame.size.height-10, bar.frame.size.height-10)];
    [fehlerb addTarget: self
              action: @selector(showActionSheet:)
    forControlEvents: UIControlEventTouchUpInside];

    
    [self.view addSubview:bar];
    


    
    /////////////////////


    	
	//NSMutableArray *dataList;
	//creiamo la lista degli autori
	//Data *dataTmp;
    
        
	//dataTmp = [[Data alloc]  init:defaultDBPath dbname:dbName] ;
	//dataTmp = [[Data alloc]  init] ;
    self.data = [[Data alloc]  init] ; //dataTmp;
    
    [self.data setNumeroQuiz];
    
    bookmark = [data getBookmark:self->quiztag];

    
    [data setValoriDaDbWithFehler:self->quiztag QuizId:bookmark.quid];
//	    NSLog(@"dataTmp ");  
	//[dataTmp release];
//    NSLog(@"dataList ");

	//dataList = data.lista;
   // NSLog(@"getPosition ");
	
		
	Frage *f = [data.lista objectAtIndex:bookmark.position];
	frage = f;
	//[frage retain];
    
	[self frageToView ];
    
    

    
    
}
     
-(void) frageToView {
    
    // remove scroll view if present
    for (UIView *subview in self.view.subviews) {
        
        if ([subview isKindOfClass:[UIScrollView class]]) {
            [subview removeFromSuperview];
        }
    }
    
    CGRect fr= [UIScreen mainScreen].bounds    ;
    NSInteger w = fr.size.width;
    NSInteger h = fr.size.height;
    UIScrollView * uisv;
     if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
     // per ipad
      w = fr.size.height;
       
      uisv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, w, h)];            
     } else {
      uisv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, w, h)];   
     }
         
    self.view.backgroundColor = [UIColor whiteColor];
    
 //   NSLog(@"fr.size.width %f" , fr.size.width);
         
    
    
    
    MyLabel *uil0 = [[MyLabel alloc] initWithFrame:CGRectMake(0,0,w,20) ];
   //UILabel *uil1 = [[UILabel alloc] init ]; 
    
    NSMutableString * domanda = [NSMutableString stringWithString:@""];
    if (self->quiztag==0) [domanda appendFormat:@"%@/%d)" , frage.nfrage , NUMFRAGEN];
    [domanda appendString:frage.qid];
    [domanda appendString:@" "];
    [domanda appendString:frage.domanda];
    [domanda appendString:@" "];
    [domanda appendString:frage.header];
    [domanda appendString:@"("]; 
    [domanda appendString:frage.weight]; 
    [domanda appendString:@"-Punkte)"]; 
    
	uil0.text=domanda;	
    uil0.numberOfLines=0;
    
    CGRect l0rect = [uil0 textRectForBounds:uil0.bounds limitedToNumberOfLines:999];
    CGRect fl0= uil0.frame;
    fl0.size.height=l0rect.size.height;
    uil0.frame=fl0;

    
    [uil0 sizeToFit];
   
    [uisv addSubview:uil0];
    
    NSInteger posh = uil0.frame.size.height;
    
    
    NSString * imgstr = [NSString stringWithFormat:@"%@.jpg", frage.image];
	imgstr = [imgstr stringByReplacingOccurrencesOfString:@"p_1_" withString:@"p1"];
	imgstr = [imgstr stringByReplacingOccurrencesOfString:@"p_2_" withString:@"p2"];
	
	//NSString *fileimg = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imgstr];
	
    
	
	//NSLog(@"image %@" , imgstr);
	//	UIImage * image = [UIImage imageNamed:imgstr];
	UIImage * image = [UIImage imageNamed:imgstr];
	if(nil!=image) {
		
        UIImageView * uiv = [[UIImageView alloc] initWithImage:image] ;
       
        CGRect frameuiv;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
          frameuiv= CGRectMake(0, posh, w, 200);
        } else {
             frameuiv= CGRectMake(w/2-uiv.frame.size.width/2, posh, uiv.frame.size.width, uiv.frame.size.height);
        }
            [uiv setFrame:frameuiv];
        [uisv addSubview:uiv];
        //  NSLog(@"fr.size.width %f" , fr.size.width);    
        //  NSLog(@"posh prima image %d" , posh);
        posh += uiv.frame.size.height;
	
		
	}
    
    
    CGRect framebtn1 = CGRectMake(0, posh, w, 40);
    btn1 = [[UFMultiLineButton alloc] init];
    [btn1 setFrame:framebtn1];
    
    [btn1 setTitle: frage.Risposte_campo2 forState: UIControlStateNormal];
    [btn1 setTag:1];
    
   // btn1.backgroundColor=[UIColor redColor];
    [btn1 addTarget: self 
             action: @selector(choose:) 
   forControlEvents: UIControlEventTouchUpInside];
   
    [uisv addSubview:btn1];

    
    posh += btn1.frame.size.height+20;


    
    CGRect framebtn2 = CGRectMake(0, posh, w, 40);
    btn2 = [[UFMultiLineButton alloc] init];
    [btn2 setFrame:framebtn2];
    
    [btn2 setTitle: frage.Risposte_campo3 forState: UIControlStateNormal];
    [btn2 setTag:2];
    
    // btn1.backgroundColor=[UIColor redColor];
    [btn2 addTarget: self 
             action: @selector(choose:) 
   forControlEvents: UIControlEventTouchUpInside];
    
    [uisv addSubview:btn2];
    
    
    posh += btn2.frame.size.height+20;
    
    
    

    if (frage.Risposte_campo4.length>0) {
   
    
        CGRect framebtn3 = CGRectMake(0, posh, w, 40);
        btn3 = [[UFMultiLineButton alloc] init];
        [btn3 setFrame:framebtn3];
        
        [btn3 setTitle: frage.Risposte_campo4 forState: UIControlStateNormal];
        [btn3 setTag:3];
        
        // btn1.backgroundColor=[UIColor redColor];
        [btn3 addTarget: self 
                 action: @selector(choose:) 
       forControlEvents: UIControlEventTouchUpInside];
        
        [uisv addSubview:btn3];
        
        
        posh += btn3.frame.size.height;

        
        btn3.hidden=NO;
    } else {
        btn3.hidden=YES;
    }
    
    
 
    CGRect framebtn0 = CGRectMake(w/2-70, posh+20, 140, 40);
    btn0 = [[UIButton alloc] initWithFrame:framebtn0];
    [btn0 setTitle: @"OK" forState: UIControlStateNormal];
    
    
    btn0.backgroundColor = [UIColor redColor];
    [btn0 setTag:4];
    [uisv addSubview:btn0];
    
    [btn0 addTarget: self 
              action: @selector(confirm:) 
    forControlEvents: UIControlEventTouchUpInside];
    
    posh += btn0.frame.size.height;


    
    [uisv sizeToFit];

    [self.view addSubview:uisv];
    
	[uisv setScrollEnabled:YES];
    
    [uisv setContentSize:CGSizeMake(w, posh+100)];
    //NSLog(@"frame height %f", h);
    
    uil0.font = [UIFont fontWithName:@"Arial" size:14.0f];
    btn1.titleLabel.font =  [UIFont fontWithName:@"Arial" size:13.0f];
    btn2.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    btn3.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    

     if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
         uil0.font = [UIFont fontWithName:@"Arial" size:16.0f];
         btn1.titleLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
         btn2.titleLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
         btn3.titleLabel.font = [UIFont fontWithName:@"Arial" size:15.0f]; 
     }
    
    
    UIImage *imguncheck = [UIImage imageNamed:@"icounchecked.png"];
    [btn1 setImage:imguncheck forState:UIControlStateNormal ];
    [btn1 sizeToFit]; 
    btnchk1=NO;
    [btn2 setImage:imguncheck forState:UIControlStateNormal ];
    [btn2 sizeToFit]; 
    btnchk2=NO;
    [btn3 setImage:imguncheck forState:UIControlStateNormal ];
   [btn3 sizeToFit]; 
    btnchk3=NO;
    
}
-(IBAction)choose:(id)sender{
	
	NSInteger tag= [sender tag];
		
	if (tag==1) {

		if (btnchk1) {
			UIImage *imguncheck = [UIImage imageNamed:@"icounchecked.png"];
			[btn1 setImage:imguncheck forState:UIControlStateNormal ];

			
			btnchk1=NO;
		} else {
			UIImage *imguncheck = [UIImage imageNamed:@"icochecked.png"];
			[btn1 setImage:imguncheck forState:UIControlStateNormal];
			btnchk1=YES;		

		}
		
        
		
	} else if (tag==2) {
		//[btn2 setEnabled:NO];
		if (btnchk2) {
			UIImage *imguncheck = [UIImage imageNamed:@"icounchecked.png"];
			[btn2 setImage:imguncheck forState:UIControlStateNormal ];

			
			btnchk2=NO;
		} else {
			UIImage *imguncheck = [UIImage imageNamed:@"icochecked.png"];
			[btn2 setImage:imguncheck forState:UIControlStateNormal];
			btnchk2=YES;		
			
		}
	} else if (tag==3) {
		//[btn3 setEnabled:NO];
		if (btnchk3) {
			UIImage *imguncheck = [UIImage imageNamed:@"icounchecked.png"];
			[btn3 setImage:imguncheck forState:UIControlStateNormal ];

			
			btnchk3=NO;
		} else {
			UIImage *imguncheck = [UIImage imageNamed:@"icochecked.png"];
			[btn3 setImage:imguncheck forState:UIControlStateNormal];
			btnchk3=YES;		
			
		}
	}
	
}

-(IBAction)confirm:(id)sender{
	
	
	NSInteger tag= [sender tag];
	
	if (tag==4) {
		
        
        BOOL errore = NO;
        
        NSString* fur2 = [frage Furanswer_campo2];
        NSString* fur3 = frage.Furanswer_campo3;
        NSString* fur4 = frage.Furanswer_campo4;
        
        if ((btnchk1 && [fur2 isEqualToString:@"0"])
            || (!btnchk1 && [fur2 isEqualToString:@"1"]))  
        {
            NSString *str = [[frage Risposte_campo2] stringByAppendingString:@" (Fehler!)"];
            
            [btn1 setTitle: str forState: UIControlStateNormal];
            
            [btn1 sizeToFit];
            
            errore=YES;	
        }
        
        if ((btnchk2 && [frage.Furanswer_campo3 isEqualToString:@"0"])
            || (!btnchk2 && [frage.Furanswer_campo3 isEqualToString:@"1"]) ) 
        {
            NSString *str = [[frage Risposte_campo3] stringByAppendingString:@" (Fehler!)"];

            [btn2 setTitle: str forState: UIControlStateNormal];
            
            [btn2 sizeToFit];
            //		[tv2 setText:@"test"];
            //NSLog(@"err2 %@" , [NSString stringWithFormat:str , @" (Fehler!)"]);		 
            errore=YES;	
        }		
        
        if ((btnchk3 && [frage.Furanswer_campo4 isEqualToString:@"0"])
            || (!btnchk3 && [frage.Furanswer_campo4 isEqualToString:@"1"]) )
        {
            NSString *str = [[frage Risposte_campo4] stringByAppendingString:@" (Fehler!)"];
          
            [btn3 setTitle: str forState: UIControlStateNormal];
            
            [btn3 sizeToFit];
            
            
            errore=YES;	
        }
        
        NSMutableString *an2= [NSMutableString stringWithString: @"0"];
        NSMutableString *an3=[NSMutableString stringWithString:@"0"];
        NSMutableString *an4=[NSMutableString stringWithString:@"0"];
        if (btnchk1) an2=[NSString stringWithString:@"1" ];
        if (btnchk2) an3=[NSString stringWithString:@"1" ];
        if (btnchk3) an4=[NSString stringWithString:@"1" ];
        
        if (errore) [data insertError:frage answer2:an2 answer3:an3 answer4:an4 mode:self->quiztag];
        else NSLog(@"OK");
        
        
        
        
        if (self->quiztag==0) {
            
            
            if ([frage.nfrage isEqualToString:[NSString stringWithFormat:@"%d", NUMFRAGEN]]) {
                BOOL pass = [self isPass];
                                      
                 NSString * msg;
                                      
                 if (pass) {
                         msg = @"Bestanden:)";
                    } else {
                         msg = @"Nicht bestanden:(";
                    
                    }
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Prüfung" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
              
                //carico domande quiz successivo
               
                                      
                [alert show];
                 [btn0 setTitle:@"Neue" forState:UIControlStateNormal];
                } else {
                    [btn0 setTitle:@"Nächste Frage" forState:UIControlStateNormal];
                }
        } else {
            [btn0 setTitle:@"Nächste Frage" forState:UIControlStateNormal];
        }
        

        bookmark.position++;
        
        if (self->quiztag==0 &&  [frage.nfrage isEqualToString:[NSString stringWithFormat:@"%d", NUMFRAGEN]]) {
            bookmark.quid++;
            
            if (bookmark.quid > [data getNumeroQuiz]) {
                // last quiz
                bookmark.quid=1;
            }
            
             [data setValoriDaDbWithFehler:self->quiztag QuizId:bookmark.quid];
        }
        
        
        
        if (data.lista.count==bookmark.position) {
            bookmark.position=0;
        }
        
       
        
        [data saveBookmark:bookmark Quizmode:self->quiztag];

        
        btn0.tag=5;
        
	} else {
        

		Frage *f = [[data lista] objectAtIndex:bookmark.position];
        //	[frage release];
		frage = f;
        //	[frage retain];
		
		[self frageToView ];
        
		[btn0 setTitle:@"Ok" forState:UIControlStateNormal];
		btn0.tag=4;
        
        // cancello errori quiz alla prima domanda
        if (self->quiztag==0  && bookmark.position==0) {
            [data resetFehler:[NSString stringWithFormat:@"%d" , self->quiztag]];
        }
	}
    
	
}

-(BOOL) isPass {
    
    return [data isPassed:bookmark.quid];
}

-(void) back:(id)sender {
         [self dismissViewControllerAnimated:YES completion:nil];
    
   // NSLog(@"back");
     }

-(void) watchFehler {
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    // NSLog(@"back");
    FfErrorsViewController *vcerr = [[FfErrorsViewController alloc] initWithNibName:@"FfErrorsViewController" bundle:nil];
    vcerr.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;

    [vcerr setValue:[NSString stringWithFormat:@"%d", self->quiztag] forKey:@"quiztag"];
    [vcerr setValue:[NSString stringWithFormat:@"%d",  bookmark.quid] forKey:@"quid"];
    
    [self presentViewController: vcerr animated:YES completion:nil];

    
}


-(void) showActionSheet:(id)sender {
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
        
               
        [self watchFehler];
        
    } else if (buttonIndex==1) {
        //reset
        //NSString *dbName = @"fragenfur.db";
        //NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
        //         NSMutableArray *dataList;
        //creiamo la lista degli autori
        //Data *dataTmp;
        
        //dataTmp = [[Data alloc]  init] ;
        [data resetFehler:[NSString stringWithFormat:@"%d" , self->quiztag]];
        
        
        // [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        
        
        
        if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)  return YES;
        return NO;
        
    }
}

@end
