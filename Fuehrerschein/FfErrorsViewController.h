//
//  ErrorsViewController.h
//  FuhrerscheinAuto
//
//  Created by ultravox on 03.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "CellError.h"
#import "FfBackground.h"

@interface FfErrorsViewController : UITableViewController {

     NSInteger quiztag;
    NSInteger quid;
	NSMutableArray *errorsList;
	CellError* cellError;
	FfBackground *bar;
}

-(void)back:(id)sender;
@property(nonatomic, retain) NSMutableArray *errorsList;
@property(nonatomic, retain) IBOutlet CellError *cellError;



@end
