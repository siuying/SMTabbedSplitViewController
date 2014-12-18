//
//  SMDetailViewController.m
//  SMSplitViewController
//
//  Created by Sergey Marchukov on 16.02.14.
//  Copyright (c) 2014 Sergey Marchukov. All rights reserved.
//
//  This content is released under the ( http://opensource.org/licenses/MIT ) MIT License.
//

#import "SMDetailViewController.h"

@interface SMDetailViewController()
@property (nonatomic, strong) UIView* borderView;
@end

@implementation SMDetailViewController

#pragma mark -
#pragma mark - Initialization

- (id)init {
    return [self initWithFrame:CGRectMake(70 + 320 + 1, 0, self.view.bounds.size.width - 1, self.view.bounds.size.height)];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super init];
    
    if (self) {
        self.view.frame = frame;
        self.view.clipsToBounds = YES;
        self.view.backgroundColor = [UIColor clearColor];
        self.borderColor = [UIColor colorWithWhite:0.0 alpha:0.2];

        self.borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, CGRectGetHeight(self.view.bounds))];
        self.borderView.backgroundColor = self.borderColor;
        self.borderView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:self.borderView];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Properties

- (void)setViewController:(UIViewController *)viewController {
    
    if (viewController) {
        UIViewController *oldVC = _viewController;
        _viewController = viewController;
        _viewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width - 0, CGRectGetHeight(self.view.bounds));
        _viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addChildViewController:_viewController];
        [self.view addSubview:_viewController.view];
        [self.view sendSubviewToBack:_viewController.view];

        [oldVC.view removeFromSuperview];
        [oldVC removeFromParentViewController];
    }
}

- (void) setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.borderView.backgroundColor = borderColor;
}

#pragma mark -
#pragma mark - Autototate iOS 6.0 +

- (BOOL)shouldAutorotate {
    
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskAll;
}

@end
