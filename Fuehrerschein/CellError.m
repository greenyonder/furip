//
//  CellError.m
//  FuhrerscheinAuto
//
//  Created by ultravox on 04.01.12.
//  Copyright 2012 Falcofinder. All rights reserved.
//

#import "CellError.h"


@implementation CellError


@synthesize tv0;
@synthesize tv1;
@synthesize tv2;
@synthesize tv3;

@synthesize iv0;
@synthesize btn0;
@synthesize btn1;
@synthesize btn2;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
   // [super dealloc];
}


@end
