//
//  AppDelegate.h
//  Dictionary
//
//  Created by Son Lui on 2013/07/17.
//  Copyright (c) 2013年 SONLUI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *naviController;
    MainViewController *a1Controller;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *viewController;

@end
