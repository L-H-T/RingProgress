//
//  RingProgressView.m
//  LHT_OC
//
//  Created by L-H-T on 2019/1/22.
//  Copyright © 2019 L-H-T. All rights reserved.
//

#import "RingProgressView.h"

@interface RingProgressView()
@property(nonatomic, strong) UILabel * precentLabel;

@end

@implementation RingProgressView

#pragma mark - init

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = self.bgColor;
        self.precentLabel = [[UILabel alloc]init];
        self.precentLabel.textColor = self.labelColor;
        self.precentLabel.font = [UIFont systemFontOfSize:self.labelFont];
        self.precentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.precentLabel];
    }
    return self;
}

-(UIColor *)bgColor {
    if (!_bgColor) {
        _bgColor = [UIColor clearColor];
    }
    return _bgColor;
}

// 字体颜色
-(UIColor *)labelColor {
    if (!_labelColor) {
        _labelColor = [UIColor blackColor];
    }
    return _labelColor;
}

// 字体大小
-(CGFloat)labelFont {
    if (!_labelFont) {
        _labelFont = 16;
    }
    return _labelFont;
}

// 圆环宽度
-(CGFloat)bgCircleWidth {
    if (!_bgCircleWidth) {
        _bgCircleWidth = 10;
    }
    return _bgCircleWidth;
}

//进度大小
-(CGFloat)prcent {
    if (!_prcent) {
        _prcent = 1;
    }
    return _prcent;
}

// 圆环背景色
-(UIColor *)bgCircleColor {
    if (!_bgCircleColor) {
        _bgCircleColor = [UIColor grayColor];
    }
    return _bgCircleColor;
}

//圆环中间线的颜色
-(UIColor *)linelColor {
    if (!_linelColor) {
        _linelColor = [UIColor blackColor];
    }
    return _linelColor;
}

//进度条的颜色
-(UIColor *)progressColor {
    if (!_progressColor) {
        _progressColor = [UIColor blueColor];
    }
    return _progressColor;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.precentLabel.frame = self.bounds;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 背景圆环
    [self.bgCircleColor set];
    CGFloat radius = self.bounds.size.height - self.bgCircleWidth; //直径
    CGRect rectFrame = CGRectMake(self.bgCircleWidth / 2, self.bgCircleWidth / 2, radius, radius);
    UIBezierPath * bgCircle = [UIBezierPath bezierPathWithOvalInRect:rectFrame];
    bgCircle.lineWidth = self.bgCircleWidth;
    [bgCircle stroke];
    
    //背景圆环中的线
    [self.linelColor set];
    CGRect linePathRect = CGRectMake(self.bgCircleWidth / 2, self.bgCircleWidth / 2, radius, radius);
    UIBezierPath * linePath = [UIBezierPath bezierPathWithOvalInRect:linePathRect];
    linePath.lineWidth = 1;
    [linePath stroke];
    
    CAShapeLayer * layer = [CAShapeLayer new];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineCap = kCALineCapRound;
    layer.strokeColor = self.progressColor.CGColor;
    layer.lineWidth = self.bgCircleWidth;
    layer.path = bgCircle.CGPath;
    layer.strokeEnd = 0;
    [self.layer addSublayer:layer];
    
    __block CGFloat precntValue = 0;
    dispatch_queue_t queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue_t);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.02 * NSEC_PER_SEC, 0.05 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (precntValue <= self.prcent) {
                precntValue = precntValue + 0.01;
                layer.strokeEnd = precntValue;
                self.precentLabel.text = [NSString stringWithFormat:@"%0.0f%@", precntValue * 100, @"%"];
            } else {
                dispatch_source_cancel(timer);
            }
        });
    });
    dispatch_resume(timer);
}

@end
