//
//  GradientRingView.m
//  LHT_OC
//
//  Created by L-H-T on 2019/1/23.
//  Copyright © 2019 L-H-T. All rights reserved.
//

#import "GradientRingView.h"
@interface GradientRingView()
@property(nonatomic, strong) UIBezierPath * progressPath;
@property(nonatomic, strong) UILabel * progressLabel;
@end

@implementation GradientRingView

-(UIColor *)bgColor {
    if (!_bgColor) {
        _bgColor = [UIColor clearColor];
    }
    return _bgColor;
}

-(UIColor *)bgRingColor {
    if (!_bgRingColor) {
        _bgRingColor = [UIColor grayColor];
    }
    return _bgRingColor;
}

-(CGFloat)bgRingWidth {
    if (!_bgRingWidth) {
        _bgRingWidth = 5;
    }
    return _bgRingWidth;
}

-(UIColor *)ringLineColor {
    if (!_ringLineColor) {
        _ringLineColor = [UIColor blackColor];
    }
    return _ringLineColor;
}

-(NSArray *)progressColor {
    if (!_progressColor) {
        _progressColor = @[(id)[UIColor blueColor].CGColor];
    }
    return _progressColor;
}

-(CGFloat)percentage {
    if (!_percentage) {
        _percentage = 1.0;
    }
    return _percentage;
}

-(UIColor *)labelColor {
    if (!_labelColor) {
        _labelColor = [UIColor blackColor];
    }
    return _labelColor;
}

-(CGFloat) labelFont {
    if (!_labelFont) {
        _labelFont = 14;
    }
    return _labelFont;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = self.bounds.size.width / 2;
        self.layer.masksToBounds = YES;
        self.backgroundColor = self.bgColor;
        self.progressLabel = [[UILabel alloc]init];
        [self addSubview:self.progressLabel];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.progressLabel.font = [UIFont systemFontOfSize:self.labelFont];
    self.progressLabel.textColor = self.labelColor;
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    self.progressLabel.frame = self.bounds;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGFloat ringWidth = self.bounds.size.width - self.bgRingWidth;
    [self.bgRingColor set];
    CGPoint progressCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    self.progressPath = [UIBezierPath bezierPathWithArcCenter:progressCenter radius:ringWidth / 2 startAngle:-M_PI / 2 endAngle:M_PI * 2 - (M_PI / 2) clockwise:YES];
    self.progressPath.lineWidth = self.bgRingWidth;
    [self.progressPath stroke];
    
    [self.ringLineColor set];
    UIBezierPath * linePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bgRingWidth / 2, self.bgRingWidth / 2, ringWidth, ringWidth)];
    linePath.lineWidth = 1;
    [linePath stroke];
    
    CAShapeLayer * shapLayer = [CAShapeLayer layer];
    shapLayer.lineWidth = self.bgRingWidth;
    shapLayer.fillColor = [UIColor clearColor].CGColor;
    shapLayer.strokeColor = [UIColor redColor].CGColor;
    shapLayer.path = self.progressPath.CGPath;
    shapLayer.lineCap = kCALineCapRound;
    shapLayer.strokeEnd = 0;
    [self.layer addSublayer:shapLayer];
    
    __block CGFloat percent = 0.00;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.02 * NSEC_PER_SEC, 0.05 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (percent <= self.percentage) {
                percent += 0.01;
                shapLayer.strokeEnd = percent;
                self.progressLabel.text = [NSString stringWithFormat:@"%.0f%@", percent * 100, @"%"];
            }else{
                dispatch_source_cancel(timer);
            }
        });
    });
    dispatch_resume(timer);
}

@end
