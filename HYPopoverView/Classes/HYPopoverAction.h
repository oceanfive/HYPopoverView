//
//  HYPopoverAction.h
//  StudyEvent
//
//  Created by ocean on 2019/3/13.
//  Copyright © 2019 ocean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HYPopoverActionHandler)(void);

@interface HYPopoverAction : NSObject

/**
 类方法快速的创建 HYPopoverAction 对象

 @param title 文字标题
 @param image 图片，推荐尺寸为 24*24，也可以设置属性 cellImageSize 来调整
 @param handler 回调
 @return HYPopoverAction
 */
+ (instancetype)actionWithTitle:(NSString *)title
                          image:(UIImage *)image
                        handler:(HYPopoverActionHandler)handler;

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, copy, readonly) HYPopoverActionHandler handler;

@end

NS_ASSUME_NONNULL_END
