//
//  HYPopoverAction.m
//  StudyEvent
//
//  Created by ocean on 2019/3/13.
//  Copyright © 2019 ocean. All rights reserved.
//

#import "HYPopoverAction.h"

@interface HYPopoverAction ()

@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) UIImage *image;
@property (nonatomic, copy, readwrite) HYPopoverActionHandler handler;

@end

@implementation HYPopoverAction

+ (instancetype)actionWithTitle:(NSString *)title
                          image:(UIImage *)image
                        handler:(HYPopoverActionHandler)handler {
    HYPopoverAction *action = [[HYPopoverAction alloc] init];
    action.title = title;
    action.image = image;
    action.handler = handler;
    return action;
}

@end
