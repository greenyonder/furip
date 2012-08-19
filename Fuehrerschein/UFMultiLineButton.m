//
//  UFMultiLineButton.m
//  http://unsolicitedfeedback.com
//
//  Created by Jorge Pedroso <jpedroso@unsolicitedfeedback.com>
//  All code is provided under the New BSD license.
//

#import "UFMultiLineButton.h"
#import "MyLabel.h"


@implementation UFMultiLineButton



#define TITLE_LABEL_TAG 3

- (CGRect)titleRectForContentRect:(CGRect)rect
{   
    // define the desired title inset margins based on the whole rect and its padding
    UIEdgeInsets padding = [self titleEdgeInsets];
    
    int width=600;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        width=250;
    }
    
    CGRect titleRect = CGRectMake( 60 + padding.left, 
                                  rect.origin.x    + padding.top, 
                                  width,
                                  rect.size.height - (padding.bottom + padding.top));
       
    // save the current title view appearance
    NSString *title = [self currentTitle];
    UIColor  *titleColor = [self currentTitleColor];
    UIColor  *titleShadowColor = [self currentTitleShadowColor];
    
    NSRange startRange = [title rangeOfString:@"Fehler"];
    //NSLog(@"range %d" , startRange.location);
    
    if (startRange.location>0 && startRange.length) {
        titleColor =[UIColor redColor];
    } else {
        titleColor =[UIColor blackColor];
    }
    // we only want to add our custom label once; only 1st pass shall return nil
    // remove subview
    for (UIView *subview in self.subviews) {
        
        if ([subview isKindOfClass:[MyLabel class]]) {
            [subview removeFromSuperview];
        }
    }
   
    MyLabel  *titleLabel = [[MyLabel alloc] initWithFrame:titleRect];
    [titleLabel setTag:TITLE_LABEL_TAG];
    
    // make it multi-line
    [titleLabel setNumberOfLines:0];
    [titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    
    // title appearance setup; be at will to modify
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[self font]];
    [titleLabel setShadowOffset:CGSizeMake(0, 1)];
    [titleLabel setTextAlignment:UITextAlignmentLeft];
    
    [self addSubview:titleLabel];
    
    [titleLabel setText:title];
    [titleLabel setTextColor:titleColor];
    [titleLabel setShadowColor:titleShadowColor];
        
    [titleLabel sizeToFit];
    
    
    
    

    // and return empty rect so that the original title view is hidden
    return CGRectZero;
}




@end
