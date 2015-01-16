//
//  LineGraphView.h
//  PGPrototype
//
//  Created by macbook on 12/15/14.
//  Copyright (c) 2014 Bumpire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface LineGraphView : UIView {
    CABasicAnimation *graphViewAnimation;
    float xPositonDivisorAllowance;
    float yPositonDivisorAllowance;
}

@property (nonatomic, strong) UIView *graphViewContainer;
@property (nonatomic, strong) NSArray *graphPoints;
@property (nonatomic, strong) UILabel *graphViewLabelA;
@property (nonatomic, strong) UILabel *graphViewLabelB;
@property (nonatomic) float graphViewMeanValue;

- (void) plotGraphPoints : (NSArray*) graphPoints;

@end
