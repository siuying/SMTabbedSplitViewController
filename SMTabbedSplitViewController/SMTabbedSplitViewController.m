//
//  SMSplitViewController.m
//  SMSplitViewController
//
//  Created by Sergey Marchukov on 15.02.14.
//  Copyright (c) 2014 Sergey Marchukov. All rights reserved.
//
//  This content is released under the ( http://opensource.org/licenses/MIT ) MIT License.
//  Repository: https://github.com/sergik-ru/SMTabbedSplitViewController
//  Version 1.0.3
//

#import "SMTabbedSplitViewController.h"
#import "SMMasterViewController.h"
#import "SMDetailViewController.h"
#import "SMTabBar.h"
#import "SMTabBarItemCell.h"

@interface SMTabbedSplitViewController () <SMTabBarDelegate>
{
    SMMasterViewController *_masterVC;
    SMDetailViewController *_detailVC;
    BOOL _masterIsHidden;
}
@end

@implementation SMTabbedSplitViewController

#pragma mark -
#pragma mark - Inititalization

- (id)init {
    
    return [self initTabbedSplit];
}

- (id)initTabbedSplit {
    
    self = [super init];
    
    if (self) {
        
        _tabBar = [[SMTabBar alloc] init];
        _tabBar.delegate = self;
        _masterVC = [[SMMasterViewController alloc] init];
        _detailVC = [[SMDetailViewController alloc] init];
    }
    
    return self;
}

- (id)initSplit {
    
    self = [super init];
    
    if (self) {
        
        _splitType = SMDefaultSplit;
        _masterVC = [[SMMasterViewController alloc] init];
        _detailVC = [[SMDetailViewController alloc] init];
    }
    
    return self;
}

#pragma mark -
#pragma mark - ViewController Lifecycle

- (void)loadView {
    
    [super loadView];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    if (_splitType == SMTabbedSplt) {
        
        [self.view addSubview:_tabBar.view];
    }
    
    [self.view addSubview:_masterVC.view];
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_masterVC.view.frame];
    _masterVC.view.layer.masksToBounds = NO;
    _masterVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    _masterVC.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    _masterVC.view.layer.shadowOpacity = 1.5f;
    _masterVC.view.layer.shadowRadius = 2.5f;
    _masterVC.view.layer.shadowPath = shadowPath.CGPath;
    
    [self.view addSubview:_detailVC.view];
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    if (_masterIsHidden)
        return;

    _detailVC.view.frame = [self detailVCFrame];
    _masterVC.view.frame = [self masterVCFrame];
}


#pragma mark -
#pragma mark - Frames

-(CGFloat) tabBarWidth
{
    return (_splitType == SMTabbedSplt) ? [[SMTabBarItemCell appearance] width] : 0.0;
}

- (CGRect)masterVCFrame {
    if (_masterIsHidden) {
        return CGRectMake([self tabBarWidth], 0, 0, self.view.bounds.size.height);
    }

    BOOL isPortrait = UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation);
    CGFloat widthDif = isPortrait ? 10 : 0;
    return CGRectMake([self tabBarWidth], 0,
                      320 - widthDif, self.view.bounds.size.height);
}

- (CGRect)detailVCFrame {
    BOOL isPortrait = UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation);
    CGFloat tabbarWidth = [self tabBarWidth];
    CGFloat masterWidth = _masterIsHidden ? 0 : (isPortrait ? 310 : 320);
    return CGRectMake(tabbarWidth + masterWidth + 1, 0,
                      self.view.bounds.size.width - masterWidth - tabbarWidth - 1, self.view.bounds.size.height);
}

#pragma mark -
#pragma mark - Properties

- (void)setDetailViewController:(UIViewController *)detailViewController {
    
    _detailVC.viewController = detailViewController;
}

- (UIViewController *)detailViewController {
    
    return _detailVC.viewController;
}

- (UIViewController *)masterViewController {
    
    return _masterVC.viewController;
}

- (void)setViewControllers:(NSArray *)viewControllers {
    
    _viewControllers = viewControllers;
    
    _masterVC.viewController = _viewControllers[0];
    _detailVC.viewController = _viewControllers[1];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _tabBar.view.backgroundColor = backgroundColor;
    _masterVC.view.backgroundColor = backgroundColor;
    _detailVC.view.backgroundColor = backgroundColor;
}

- (void)setTabsViewControllers:(NSArray *)tabsViewControllers {
    
    _tabsViewControllers = tabsViewControllers;
    _tabBar.tabsButtons = _tabsViewControllers;
}

- (void)setActionsButtons:(NSArray *)actionsTabs {
    
    _actionsButtons = actionsTabs;
    _tabBar.actionsButtons = _actionsButtons;
}

#pragma mark -
#pragma mark - Actions

- (void)hideMaster {
    _masterIsHidden = YES;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }];
}

- (void)showMaster {
    _masterIsHidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }];
}

#pragma mark -
#pragma mark - Autorotation

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskAll;
}

#pragma mark -
#pragma mark - TabBarDelegate

- (void)tabBar:(SMTabBar *)tabBar selectedViewController:(UIViewController *)vc {
    
    if (_masterIsHidden) {
        
        _masterIsHidden = NO;
        [self.view setNeedsLayout];
    }
    
    _masterVC.viewController = vc;
}

@end
