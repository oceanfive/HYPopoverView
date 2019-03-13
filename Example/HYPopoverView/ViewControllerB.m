//
//  ViewControllerB.m
//  StudyEvent
//
//  Created by ocean on 2019/2/15.
//  Copyright © 2019 ocean. All rights reserved.
//

#import "ViewControllerB.h"
#import "HYPopoverView.h"

@interface ViewControllerB ()

@end

@implementation ViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    NSLog(@"%s", __FUNCTION__);
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton setTitle:@"更多" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(myButtonClick) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:myButton];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)myButtonClick {
    UIView *sourceView = self.navigationItem.rightBarButtonItem.customView;
    
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
