//
//  MyLabel.m
//  Fuehrerschein
//
//  Created by macbook on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {

     
    
    CGSize sz = [self.text sizeWithFont:self.font 
                      constrainedToSize:CGSizeMake(self.bounds.size.width, 10000)
                          lineBreakMode:self.lineBreakMode]; 
    
    //NSLog(@"TEST textRectForBounds %f %f" , sz.width, sz.height );
    
    return (CGRect){bounds.origin, CGSizeMake(self.bounds.size.width, sz.height)};
    
    

}

-(id)init {
     self = [super init];
    return self;
}


@end
