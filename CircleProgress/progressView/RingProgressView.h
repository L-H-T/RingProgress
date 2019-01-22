//
//  RingProgressView.h
//  LHT_OC
//
//  Created by L-H-T on 2019/1/22.
//  Copyright © 2019 L-H-T. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RingProgressView : UIView
@property(nonatomic, strong) UIColor * bgColor;         // 背景色
@property(nonatomic, assign) CGFloat bgCircleWidth;     // 背景圆环的宽度
@property(nonatomic, assign) CGFloat prcent;            // 圆环占比
@property(nonatomic, strong) UIColor * labelColor;      // 展示字体的颜色
@property(nonatomic, assign) CGFloat labelFont;         // 字体大小
@property(nonatomic, strong) UIColor * bgCircleColor;   // 背景圆环的颜色
@property(nonatomic, strong) UIColor * linelColor;      // 圆环中间线的颜色
@property(nonatomic, strong) UIColor * progressColor;   // 进度条的颜色
@end

NS_ASSUME_NONNULL_END
