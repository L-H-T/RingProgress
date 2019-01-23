//
//  GradientRingView.h
//  LHT_OC
//
//  Created by L-H-T on 2019/1/23.
//  Copyright © 2019 L-H-T. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradientRingView : UIView
@property(nonatomic, assign) UIColor * bgColor;         //背景色
@property(nonatomic, assign) CGFloat bgRingWidth;       //背景圆环的宽度
@property(nonatomic, assign) UIColor * bgRingColor;     //背景圆环的颜色
@property(nonatomic, assign) UIColor * ringLineColor;   //圆环内的线的颜色
@property(nonatomic, copy)   NSArray * progressColor;   //进度条的颜色(数组长度为1时代表纯色，其余渐变）
@property(nonatomic, assign) CGFloat percentage;        //百分占比
@property(nonatomic, assign) CGFloat labelFont;         //字体大小
@property(nonatomic, assign) UIColor * labelColor;      // 字体颜色
@end

NS_ASSUME_NONNULL_END
