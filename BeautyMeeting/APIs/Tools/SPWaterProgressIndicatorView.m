//
//  SPWaterProgressIndicatorView.m
//
//  Created by Antonio081014 on 9/4/15.
//  Copyright (c) 2015 antonio081014.com. All rights reserved.
//

#import "SPWaterProgressIndicatorView.h"

static const CGFloat kDefaultFrequency          = 0.5f;
static const CGFloat kDefaultAmplitude          = 0.8f;
static const CGFloat kDefaultIdleAmplitude      = 0.05f;
static const CGFloat kDefaultPhaseShift         = -0.1f;
static const CGFloat kDefaultDensity            = 3.0f;
static const NSUInteger kDefaultPercent         = 0;
static const NSUInteger kDefaultMaximumPercent  = 100;
static const CGFloat kDefaultPrimaryLineWidth   = 2.0f;

@interface SPWaterProgressIndicatorView ()
/*
 * Line width used for the proeminent wave
 * Default: 3.0f
 */
@property (nonatomic) CGFloat primaryWaveLineWidth; //波浪的高度

/*
 * The amplitude that is used when the incoming amplitude is near zero.
 * Setting a value greater 0 provides a more vivid visualization.
 * Default: 0.01
 */
@property (nonatomic) CGFloat idleAmplitude;

/*
 * The frequency of the sinus wave. The higher the value, the more sinus wave peaks you will have.
 * Default: 1.5  频率
 */
@property (nonatomic) CGFloat frequency;

/*
 * The current amplitude 振幅
 */
@property (nonatomic) CGFloat amplitude;

/*
 * The lines are joined stepwise, the more dense you draw, the more CPU power is used.
 * Default: 5
 */
@property (nonatomic) CGFloat density;

/*
 * The phase shift that will be applied with each level setting
 * Change this to modify the animation speed or direction
 * Default: -0.15
 */
@property (nonatomic) CGFloat phaseShift; //波纹摆动的频率
@property (nonatomic) CGFloat phase;
@property (nonatomic) NSUInteger completionInPercent;
@property (nonatomic, strong) CADisplayLink *displaylink;

@end

@implementation SPWaterProgressIndicatorView
{
    BOOL isAnimation;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    isAnimation = NO;
    //底色黄色
    self.backgroundColor = [UIColor colorWithRed:253/255.f green:250/255.f blue:233/255.f alpha:1.0];
    //进度颜色
    self.waveColor = [UIColor colorWithRed:1 green:127/255.f blue:0 alpha:1.0];
    
    self.completionInPercent = kDefaultPercent;
    
    self.frequency = kDefaultFrequency;
    
    self.amplitude = kDefaultAmplitude;
    self.idleAmplitude = kDefaultIdleAmplitude;
    
    self.phaseShift = kDefaultPhaseShift;
    self.density = kDefaultDensity;
    
    self.primaryWaveLineWidth = kDefaultPrimaryLineWidth;
    
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    CAShapeLayer *layer = [CAShapeLayer layer];
    [layer setPath:progressPath.CGPath];
    layer.lineWidth = MIN(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds)) / 10.f;
    self.layer.mask = layer;
    
//
}

/**
 * Ensure the size is always square.
 */
- (void)setFrame:(CGRect)frame {
    if (frame.size.width < frame.size.height) {
        frame.size.height = frame.size.width;
    } else {
        frame.size.width = frame.size.height;
    }
    
    [super setFrame:frame];
}


- (void)updateWithPercentCompletion:(NSUInteger)percent {
    if (percent > 0 && percent < 100) {
        if (!isAnimation) {
          [self startAnimation];
        }
    }else {
        if (isAnimation) {
            [self stopAnimation];
        }
    }
    self.completionInPercent = MAX(0, MIN(kDefaultMaximumPercent, percent));
    [self setNeedsDisplay];
}

/**
 * With phase shifts, the animation will prevail.
 */
- (void)update {
    self.phase += self.phaseShift;
    [self setNeedsDisplay];
}

- (void)startAnimation {
    isAnimation = YES;
    self.displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateMeters)];
    [self.displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateMeters
{
    [self update];
}

- (void)stopAnimation
{
    isAnimation = NO;
    [self.displaylink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self.displaylink invalidate];
    self.displaylink = nil;
}

//  Great Thanks to Stefan Ceriu.
//  Ref: https://github.com/stefanceriu/SCSiriWaveformView
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    if (_completionInPercent>=100) { //进度已满 直接填充
        UIColor *color = [UIColor colorWithRed:204/255. green:204/255. blue:204/255. alpha:1];
        [color set];
        CGContextFillRect(context, rect);
        return;
    }
    
    [self.backgroundColor set];
    CGContextFillRect(context, rect);
    
    //如果进度为0就不继续绘制了
    if (_completionInPercent==0) {
        return;
    }
    
    CGContextSetLineWidth(context, self.primaryWaveLineWidth);
    
    CGFloat halfHeight = CGRectGetHeight(self.bounds) / 2.0f;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat mid = width / 2.0f;
    
    //最大振幅
    const CGFloat maxAmplitude = fmax(halfHeight / 10 - 4.0f, 2.f * self.primaryWaveLineWidth); // 4 corresponds to twice the stroke width
    
    [[self.waveColor colorWithAlphaComponent:CGColorGetAlpha(self.waveColor.CGColor)] set];
    
    for (CGFloat x = 0; x<width + self.density; x += self.density) {
        // We use a parable to scale the sinus wave, that has its peak in the middle of the view.
        //pow(x,y) x的y次方
        CGFloat scaling = -pow(1 / mid * (x - mid), 2) + 1;
        //sinf正弦函数
        CGFloat y = scaling * maxAmplitude * self.amplitude * sinf(2 * M_PI *(x / width) * self.frequency + self.phase) + 1.0 * CGRectGetHeight(self.bounds) * (100 - self.completionInPercent) / 100.f;
        
        if (x == 0) {
            CGContextMoveToPoint(context, x, y);
        } else {
            CGContextAddLineToPoint(context, x, y);
        }
    }
    
    CGContextAddLineToPoint(context, width, CGRectGetHeight(self.bounds));
    CGContextAddLineToPoint(context, 0, CGRectGetHeight(self.bounds));
    CGContextClosePath(context);
    CGContextFillPath(context);
    CGContextStrokePath(context);
}

/**
 * Ensure nothing would happen when user touch out of the mask(circle)
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CAShapeLayer *layer = (CAShapeLayer *)self.layer.mask;
    if ([[UIBezierPath bezierPathWithCGPath:layer.path] containsPoint:point]){
        return [super hitTest:point withEvent:event];
    }
    return nil;
}











@end
