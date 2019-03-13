//
//  HYPopoverView.h
//  StudyEvent
//
//  Created by ocean on 2019/3/13.
//  Copyright © 2019 ocean. All rights reserved.
//

/**
 使用例子:
 
 一、从 UIBarButtonItem 弹出
 
 UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
 [myButton setTitle:@"更多" forState:UIControlStateNormal];
 [myButton addTarget:self action:@selector(myButtonClick) forControlEvents:UIControlEventTouchUpInside];
 
 UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:myButton];
 self.navigationItem.rightBarButtonItem = item;
 
 UIView *sourceView = self.navigationItem.rightBarButtonItem.customView;
 
 二、从 UIView 弹出
 
 UIView *sourceView = [[UIView alloc] init];
 [self.view addSubview:sourceView];
 sourceView.backgroundColor = [UIColor orangeColor];
 sourceView.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 100, 100, 80, 80);
 
 HYPopoverView *view = [[HYPopoverView alloc] init];
 //    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
 //    view.mContentWidth = 300.0f;
 //    view.mLayoutMargin = 50.0f;
 //    view.mContentBackgroundColor = [UIColor redColor];
 //    view.mContentCornerRadius = 10.0f;
 //    view.mContentOffset = UIOffsetMake(-50, 30);
 //    view.mArrowSize = CGSizeMake(50, 50);
 
 //    view.cellHeight = 80.0f;
 view.cellImageSize = CGSizeMake(18, 18);
 view.cellTextColor = [UIColor redColor];
 view.cellTextFont = [UIFont systemFontOfSize:10];
 
 //    view.cellHorizontalViewSpacing = 0.0f;
 //    view.cellHorizontalEdgeMargin = 0.0f;
 
 view.cellLineColor = [UIColor redColor];
 view.cellLineLeftMargin = 10.0f;
 view.cellLineRightMargin = 10.0f;
 
 view.sourceView = sourceView;
 
 HYPopoverAction *action1 = [HYPopoverAction actionWithTitle:@"考勤记录" image:[UIImage imageNamed:@"考勤记录"] handler:^{
 
 NSLog(@"考勤记录");
 }];
 HYPopoverAction *action2 = [HYPopoverAction actionWithTitle:@"请假记录" image:[UIImage imageNamed:@"请假记录"] handler:^{
 
 NSLog(@"请假记录");
 }];
 
 // 最后添加
 [view addActions:@[action1, action2]];
 [view show];
 */

#import <UIKit/UIKit.h>
#import "HYPopoverAction.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYPopoverView : UIView

#pragma mark - 内容样式
/** 内容的宽度 */
@property (nonatomic, assign) CGFloat mContentWidth;
/** 内容距离屏幕边缘的距离 */
@property (nonatomic, assign) CGFloat mLayoutMargin;
/** 内容的背景颜色，包含箭头 */
@property (nonatomic, strong) UIColor *mContentBackgroundColor;
/** 圆角大小 */
@property (nonatomic, assign) CGFloat mContentCornerRadius;
/** 位置偏移量，在原有的基础上偏移 */
@property (nonatomic, assign) UIOffset mContentOffset;
/** 箭头的大小 */
@property (nonatomic, assign) CGSize mArrowSize;

#pragma mark - cell 样式
/** 每一行cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** cell的图片大小 */
@property (nonatomic, assign) CGSize cellImageSize;
/** cell的文字字体 */
@property (nonatomic, strong) UIFont *cellTextFont;
/** cell的文字颜色 */
@property (nonatomic, strong) UIColor *cellTextColor;

/** cell的内容距离左右边缘的间距 */
@property (nonatomic, assign) CGFloat cellHorizontalEdgeMargin;
/** cell的图片和文字的间距 */
@property (nonatomic, assign) CGFloat cellHorizontalViewSpacing;

/** cell的分割线颜色 */
@property (nonatomic, strong) UIColor *cellLineColor;
/** cell的分割线左侧间距 */
@property (nonatomic, assign) CGFloat cellLineLeftMargin;
/** cell的分割线右侧间距 */
@property (nonatomic, assign) CGFloat cellLineRightMargin;

#pragma mark - 弹出点
/** 从哪个view弹出来 */
@property (nonatomic, strong) UIView *sourceView;

#pragma mark - 添加 Action (最后调用!)
- (void)addActions:(NSArray<HYPopoverAction *> *)actions;

#pragma mark - show
- (void)show;

@end

NS_ASSUME_NONNULL_END
