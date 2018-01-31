//
//  SPWaterProgressIndicatorView.h
//
//  Created by Antonio081014 on 9/4/15.
//  Copyright (c) 2015 antonio081014.com. All rights reserved.
//
//  Great Thanks to Stefan Ceriu.
//  Ref: https://github.com/stefanceriu/SCSiriWaveformView

@import UIKit;

IB_DESIGNABLE
@interface SPWaterProgressIndicatorView : UIView

/**
 * Update the percent of completion
 */
- (void)updateWithPercentCompletion:(NSUInteger)percent;

/**
 * Start animation
 */
- (void)startAnimation;

/**
 * Stop animation
 */
- (void)stopAnimation;

/*
 * Percent of completion
 * Default: 0
 */
@property (nonatomic, readonly) NSUInteger completionInPercent;

/*
 * Color to use when drawing the waves
 * Default: cyan
 */
@property (nonatomic, strong) UIColor *waveColor;

@end
