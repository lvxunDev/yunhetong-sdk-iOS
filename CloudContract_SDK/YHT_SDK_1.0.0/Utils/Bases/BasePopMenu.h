#import <UIKit/UIKit.h>

typedef enum {
    BasePopMenuArrowPositionCenter = 0,
    BasePopMenuArrowPositionLeft = 1,
    BasePopMenuArrowPositionRight = 2
} BasePopMenuArrowPosition;

@class BasePopMenu;

@protocol BasePopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(BasePopMenu *)popMenu;
@end

@interface BasePopMenu : UIView
@property (nonatomic, weak) id<BasePopMenuDelegate> delegate;

@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;

@property (nonatomic, assign) BasePopMenuArrowPosition arrowPosition;

/**
 *  初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;

/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;

/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;

/**
 *  关闭菜单
 */
- (void)dismiss;
@end
