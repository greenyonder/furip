//
//  FfAppDelegate.h
//  Fuehrerschein
//
//  Created by macbook on 16.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FfViewController;


@interface FfAppDelegate : UIResponder <UIApplicationDelegate> {

}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FfViewController *viewController;



-(NSString *) getQuizNumeber;

@end
