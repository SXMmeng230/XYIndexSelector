//
//  XYIndexView.h
//  XYIndexSelector
//
//  Created by 小萌 on 2017/5/16.
//  Copyright © 2017年 小萌. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^EventHandler) (NSInteger index);
@interface XYIndexView : UIView
- (void)setIndexViewWithArray:(NSArray *)array seleted:(EventHandler)handler;
@end
