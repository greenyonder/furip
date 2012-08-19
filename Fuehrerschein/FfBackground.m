//
//  FfBackground.m
//  Fuehrerschein
//
//  Created by macbook on 16.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FfBackground.h"

@implementation FfBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        
        //////////// BAR
        UIColor * backg = [UIColor colorWithPatternImage:[UIImage imageNamed:@"actionbar_background.jpg"]];
        
        self.backgroundColor = backg;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
