//
//  XYIndexView.m
//  XYIndexSelector
//
//  Created by 小萌 on 2017/5/16.
//  Copyright © 2017年 小萌. All rights reserved.
//

#import "XYIndexView.h"
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define indexTag 500
#define maxRadius 60

@interface XYIndexView()
@property (nonatomic, strong) UILabel *toastLabel;
@property (nonatomic, copy)EventHandler handler;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation XYIndexView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
- (UILabel *)toastLabel
{
    if (!_toastLabel) {
        _toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _toastLabel.center = CGPointMake(-(ScreenWidth - self.frame.size.width) * 0.5, self.frame.size.height * 0.5);
        _toastLabel.layer.masksToBounds = YES;
        _toastLabel.layer.cornerRadius = 5.0f;
        _toastLabel.backgroundColor = [UIColor blueColor];
        _toastLabel.textColor = [UIColor whiteColor];
        _toastLabel.alpha = 0;
        _toastLabel.textAlignment = NSTextAlignmentCenter;
        _toastLabel.font = [UIFont systemFontOfSize:18];
    }
    return _toastLabel;
}
- (void)setIndexViewWithArray:(NSArray *)array seleted:(EventHandler)handler;
{
    self.array = array;
    self.handler = handler;
    [self setUI];
}
- (void)setUI
{
    [self addSubview:self.toastLabel];
    CGFloat height = self.frame.size.height / self.array.count;
    for (NSInteger i = 0; i < self.array.count; i ++) {
        UILabel *label =[[UILabel alloc] init];
        label.frame = CGRectMake(0, i * height, self.frame.size.width, height);
        label.text = self.array[i];
        label.tag = indexTag + i;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blueColor];
        label.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:label];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self showAnimate:touches];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self showAnimate:touches];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endAnimate];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endAnimate];
}
- (void)showAnimate:(NSSet<UITouch *> *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGFloat height = self.frame.size.height / self.array.count;
    NSInteger index = point.y / height;
    for (NSInteger i = 0; i< self.array.count; i++) {
        UILabel *label = [self viewWithTag:indexTag + i];
        if (fabs(point.y - label.center.y) < maxRadius) {
            CGFloat centerX = self.frame.size.width * 0.5 - sqrt(maxRadius * maxRadius - fabs(point.y - label.center.y) *fabs(point.y - label.center.y));
            [UIView animateWithDuration:0.2 animations:^{
                label.center = CGPointMake(centerX, label.center.y);
                if (index <= self.array.count - 1 && index >= 0 && index != self.currentIndex) {
                    self.toastLabel.text = self.array[index];
                    self.toastLabel.alpha = 1;
                    self.currentIndex = index;
                    if (self.handler) {
                        self.handler(index);
                    };
                }
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                label.center = CGPointMake(self.frame.size.width * 0.5, i * height + height *0.5);
            }];
        }
    }
}
- (void)endAnimate
{
    CGFloat height = self.frame.size.height/self.array.count;
    for (int i = 0; i < self.array.count; i ++){
        UILabel * label = (UILabel *)[self viewWithTag:indexTag + i];
        [UIView animateWithDuration:0.2 animations:^{
            label.center = CGPointMake(self.frame.size.width/2, i * height + height/2);
            self.toastLabel.alpha = 0;
        }];
    }
    
}

@end
