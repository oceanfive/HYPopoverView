//
//  HYPopoverView.m
//  StudyEvent
//
//  Created by ocean on 2019/3/13.
//  Copyright © 2019 ocean. All rights reserved.
//

#import "HYPopoverView.h"

static inline CGPoint HYCGPointOffset(CGPoint point, UIOffset offset) {
    CGPoint newPoint;
    newPoint.x = point.x;
    newPoint.y = point.y;
    
    newPoint.x += offset.horizontal;
    newPoint.y += offset.vertical;
    return newPoint;
}

#pragma mark HYPopoverViewCell

@interface HYPopoverViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

@property (nonatomic, strong) UIImageView *mImageView;
@property (nonatomic, strong) UILabel *mTextLabel;
@property (nonatomic, strong) UIView *mLineView;

@property (nonatomic, assign) CGSize mImageSize;
@property (nonatomic, strong) UIFont *mTextFont;
@property (nonatomic, strong) UIColor *mTextColor;

@property (nonatomic, assign) CGFloat horizontalEdgeMargin;
@property (nonatomic, assign) CGFloat horizontalViewSpacing;

@property (nonatomic, strong) UIColor *mLineColor;
@property (nonatomic, assign) CGFloat mLineLeftMargin;
@property (nonatomic, assign) CGFloat mLineRightMargin;
@property (nonatomic, assign) BOOL mLineHidden;

@end


@implementation HYPopoverViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    HYPopoverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HYPopoverViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    _mImageView = [[UIImageView alloc] init];
    _mImageView.contentMode = UIViewContentModeScaleAspectFit;
    _mImageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_mImageView];
    
    _mTextLabel = [[UILabel alloc] init];
    _mTextLabel.textAlignment = NSTextAlignmentLeft;
    _mTextLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_mTextLabel];
    
    _mLineView = [[UIView alloc] init];
    [self.contentView addSubview:_mLineView];
    
    _mImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _mTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _mLineView.translatesAutoresizingMaskIntoConstraints = NO;
}

#pragma mark - Layout
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    
    // _mImageView
    [_mImageView addConstraint:[NSLayoutConstraint constraintWithItem:_mImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:_mImageSize.width]];
    [_mImageView addConstraint:[NSLayoutConstraint constraintWithItem:_mImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:_mImageSize.height]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:_horizontalEdgeMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    // _mTextLabel
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mTextLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_mImageView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:_horizontalViewSpacing]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mTextLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-_horizontalViewSpacing]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mTextLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:-0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mTextLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-0]];
    
    // _mLineView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mLineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:_mLineLeftMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mLineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-_mLineRightMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mLineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [_mLineView addConstraint:[NSLayoutConstraint constraintWithItem:_mLineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.5]];
    
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - setter
- (void)setMTextFont:(UIFont *)mTextFont {
    _mTextFont = mTextFont;
    _mTextLabel.font = mTextFont;
}

- (void)setMTextColor:(UIColor *)mTextColor {
    _mTextColor = mTextColor;
    _mTextLabel.textColor = mTextColor;
}

- (void)setMLineColor:(UIColor *)mLineColor {
    _mLineColor = mLineColor;
    _mLineView.backgroundColor = mLineColor;
}

- (void)setMLineHidden:(BOOL)mLineHidden {
    _mLineHidden = mLineHidden;
    _mLineView.hidden = mLineHidden;
}

@end

#pragma mark ---------------

@interface HYPopoverView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *mBGView;
@property (nonatomic, strong) UIView *mContainer;
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) CGFloat mContentHeight;
@property (nonatomic, assign) CGFloat mTotalHeight;

@property (nonatomic, assign) CGRect mConvertedRect;

@property (nonatomic, strong) CAShapeLayer *bgLayer;

@property (nonatomic, strong) NSLayoutConstraint *containerLCWidth;
@property (nonatomic, strong) NSLayoutConstraint *containerLCHeight;
@end

@implementation HYPopoverView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _mContentWidth = 125.0f;
        _mLayoutMargin = 10.0f;
        _mContentCornerRadius = 4.0f;
        _mContentBackgroundColor = [UIColor whiteColor];
        _mArrowSize = CGSizeMake(16.0, 14.0);
        _mContentOffset = UIOffsetMake(0, 0);
        
        _cellHeight = 42.0f;
        _cellImageSize = CGSizeMake(24.0f, 24.0f);
        _cellTextFont = [UIFont systemFontOfSize:14];
        _cellTextColor = [UIColor colorWithRed:102 / 255.0f
                                         green:102 / 255.0f
                                          blue:102 / 255.0f
                                         alpha:1.0];
        _cellHorizontalEdgeMargin = 12.0f;
        _cellHorizontalViewSpacing = 10.0f;
        
        _cellLineColor = [UIColor grayColor];
        _cellLineLeftMargin = 0.0f;
        _cellLineRightMargin = 0.0f;
        
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    _mBGView = [[UIView alloc] init];
    _mBGView.backgroundColor = [UIColor clearColor];
    [self addSubview:_mBGView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTapGesture)];
    [_mBGView addGestureRecognizer:tapGesture];
    
    _mContainer = [[UIView alloc] init];
    _mContainer.backgroundColor = [UIColor clearColor];
    [self addSubview:_mContainer];
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mTableView.scrollEnabled = NO;
    _mTableView.delegate   = self;
    _mTableView.dataSource = self;
    _mTableView.estimatedRowHeight = 0;
    _mTableView.backgroundColor = [UIColor clearColor];
    [_mContainer addSubview:_mTableView];
    
    _mBGView.translatesAutoresizingMaskIntoConstraints = NO;
    _mContainer.translatesAutoresizingMaskIntoConstraints = NO;
    _mTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
}

#pragma mark - Layout

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    // _mBGView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mBGView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mBGView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mBGView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mBGView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    // _mContainer
    _containerLCWidth = [NSLayoutConstraint constraintWithItem:_mContainer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:_mContentWidth];
    [_mContainer addConstraint:_containerLCWidth];
    _containerLCHeight = [NSLayoutConstraint constraintWithItem:_mContainer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:_mTotalHeight];
    [_mContainer addConstraint:_containerLCHeight];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mContainer attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-_mLayoutMargin + _mContentOffset.horizontal]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_mContainer attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:CGRectGetMaxY(_mConvertedRect) + _mContentOffset.vertical]];
    
    // _mTableView
    [_mContainer addConstraint:[NSLayoutConstraint constraintWithItem:_mTableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_mContainer attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [_mContainer addConstraint:[NSLayoutConstraint constraintWithItem:_mTableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_mContainer attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    [_mContainer addConstraint:[NSLayoutConstraint constraintWithItem:_mTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_mContainer attribute:NSLayoutAttributeTop multiplier:1.0 constant:_mArrowSize.height]];
    [_mContainer addConstraint:[NSLayoutConstraint constraintWithItem:_mTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_mContainer attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];

    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self drawBgShapeLayer];
}

- (void)drawBgShapeLayer {
    if (_bgLayer) {
        [_bgLayer removeFromSuperlayer];
        _bgLayer = nil;
    }
    
    CGRect convertedRect = [_mContainer convertRect:_sourceView.frame fromView:_sourceView.superview];
    CGFloat mindX = CGRectGetMidX(convertedRect);
    
    CGPoint startPoint = CGPointMake(mindX, 0);
    CGPoint ltArcPoint = CGPointMake(_mContentCornerRadius, _mArrowSize.height + _mContentCornerRadius);
    CGPoint lbArcPoint = CGPointMake(ltArcPoint.x, _mTotalHeight - _mContentCornerRadius);
    CGPoint rbArcPoint = CGPointMake(_mContentWidth - _mContentCornerRadius, lbArcPoint.y);
    CGPoint rtArcPoint = CGPointMake(rbArcPoint.x, ltArcPoint.y);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:HYCGPointOffset(startPoint, UIOffsetMake(- _mArrowSize.width * 0.5, _mArrowSize.height))];
    
    [path addLineToPoint:HYCGPointOffset(ltArcPoint, UIOffsetMake(0, -_mContentCornerRadius))];
    [path addArcWithCenter:ltArcPoint radius:_mContentCornerRadius startAngle:M_PI_2 * 3 endAngle:M_PI clockwise:NO];
    
    [path addLineToPoint:HYCGPointOffset(lbArcPoint, UIOffsetMake(-_mContentCornerRadius, 0))];
    [path addArcWithCenter:lbArcPoint radius:_mContentCornerRadius startAngle:M_PI endAngle:M_PI_2 clockwise:NO];
    
    [path addLineToPoint:HYCGPointOffset(rbArcPoint, UIOffsetMake(0, _mContentCornerRadius))];
    [path addArcWithCenter:rbArcPoint radius:_mContentCornerRadius startAngle:M_PI_2 endAngle:0 clockwise:NO];
    
    [path addLineToPoint:HYCGPointOffset(rtArcPoint, UIOffsetMake(_mContentCornerRadius, 0))];
    [path addArcWithCenter:rtArcPoint radius:_mContentCornerRadius startAngle:0 endAngle:M_PI_2 * 3 clockwise:NO];
    
    [path addLineToPoint:HYCGPointOffset(startPoint, UIOffsetMake(_mContentCornerRadius, _mArrowSize.height))];
    
    _bgLayer = [CAShapeLayer layer];
    _bgLayer.path = [path CGPath];
    _bgLayer.fillColor = [_mContentBackgroundColor CGColor];
    _bgLayer.strokeColor = [_mContentBackgroundColor CGColor];
    [_mContainer.layer insertSublayer:_bgLayer atIndex:0];
}

#pragma mark - setter

- (void)setSourceView:(UIView *)sourceView {
    _sourceView = sourceView;
    CGRect rect = [[self p_keywindow] convertRect:sourceView.frame fromView:sourceView.superview];
    _mConvertedRect = rect;
}

#pragma mark -

- (void)addActions:(NSArray<HYPopoverAction *> *)actions {
    if (!actions || actions.count <= 0) return;
    [self.dataSource addObjectsFromArray:actions];
    [self computeHeight];
    [_mTableView reloadData];
}

#pragma mark -

- (void)computeHeight {
    _mContentHeight = self.dataSource.count * _cellHeight;
    _mTotalHeight = _mContentHeight + _mArrowSize.height;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark - UITableView - Rows - Display

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"HYPopoverViewCellId";
    HYPopoverViewCell *cell = [HYPopoverViewCell cellWithTableView:tableView identifier:identifier];
    
    HYPopoverAction *action = [self.dataSource objectAtIndex:indexPath.row];
    cell.mImageView.image = action.image;
    cell.mTextLabel.text = action.title;
    
    cell.mImageSize = self.cellImageSize;
    cell.mTextFont = self.cellTextFont;
    cell.mTextColor = self.cellTextColor;
    
    cell.mLineColor = self.cellLineColor;
    cell.mLineLeftMargin = self.cellLineLeftMargin;
    cell.mLineRightMargin = self.cellLineRightMargin;
    
    cell.horizontalEdgeMargin = self.cellHorizontalEdgeMargin;
    cell.horizontalViewSpacing = self.cellHorizontalViewSpacing;
    
    cell.mLineHidden = indexPath.row == self.dataSource.count - 1;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HYPopoverAction *action = [self.dataSource objectAtIndex:indexPath.row];
    if (action.handler) {
        action.handler();
    }
    [self dismiss];
}

#pragma mark - Event

- (void)bgTapGesture {
    [self dismiss];
}

#pragma mark - show / dismiss

- (void)show {
    UIWindow *keyWindow = [self p_keywindow];
    [keyWindow addSubview:self];
    [keyWindow bringSubviewToFront:self];
    self.frame = keyWindow.bounds;
    
    self.alpha = 0.1;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.1;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Private

- (UIWindow *)p_keywindow {
    return [[UIApplication sharedApplication] keyWindow];
}

#pragma mark - lazy
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
