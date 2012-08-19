//
//  CellError.h
//  FuhrerscheinAuto
//
//  Created by ultravox on 04.01.12.
//  Copyright 2012 Falcofinder. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellError : UITableViewCell {
UITextView *tv0;
	UITextView *tv1;
	UITextView *tv2;
	UITextView *tv3;
	
	UIImageView *iv0;
	
	UIButton *btn0;
	UIButton *btn1;
	UIButton *btn2;
	

}

@property(nonatomic, retain) IBOutlet UITextView *tv0;
@property(nonatomic, retain) IBOutlet UITextView *tv1;
@property(nonatomic, retain) IBOutlet UITextView *tv2;
@property(nonatomic, retain) IBOutlet UITextView *tv3;

@property(nonatomic, retain) IBOutlet UIImageView *iv0;

@property(nonatomic, retain) IBOutlet UIButton *btn0;
@property(nonatomic, retain) IBOutlet UIButton *btn1;
@property(nonatomic, retain) IBOutlet UIButton *btn2;

@end
