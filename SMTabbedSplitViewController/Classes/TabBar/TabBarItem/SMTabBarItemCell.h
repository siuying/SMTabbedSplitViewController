//
//  SMTabBarItemCell.h
//  SMSplitViewController
//
//  Created by Sergey Marchukov on 16.02.14.
//  Copyright (c) 2014 Sergey Marchukov. All rights reserved.
//
//  This content is released under the ( http://opensource.org/licenses/MIT ) MIT License.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSUInteger, SMTabBarItemCellType) {
    
    SMTabBarItemCellTab,
    SMTabBarItemCellAction
};

@interface SMTabBarItemCell : UITableViewCell

@property (nonatomic, assign) CGFloat width UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat height UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat iconWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat iconHeight UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat titleHeight UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor* separatorColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, copy) void (^actionBlock)(void);
@property (nonatomic) SMTabBarItemCellType cellType;
@property (nonatomic) BOOL isFirstCell;

@end