//
//  LineGraphView.m
//  PGPrototype
//
//  Created by macbook on 12/15/14.
//  Copyright (c) 2014 Bumpire. All rights reserved.
//

#import "LineGraphView.h"

#define PI 3.14159265359

@implementation LineGraphView

#pragma mark - UIView

- (void) awakeFromNib {
    [self setDefaultValues];
    [self setGraphView];
}

#pragma mark - Public

- (void) plotGraphPoints: (NSArray *) graphPoints {
    self.graphPoints = graphPoints;
    self.graphViewContainer.layer.sublayers = nil;
    [self arrangeGraphPoints];
}

#pragma mark - Private

- (void) setDefaultValues {
    // Set Instance Values
    xPositonDivisorAllowance = 10.0;
    yPositonDivisorAllowance = 10.0;
}

- (void) setGraphView {
    UIView *topBorder = [[UIView alloc] initWithFrame:CGRectMake(xPositonDivisorAllowance, 0, self.frame.size.width - (xPositonDivisorAllowance * 2.0), 1.0)];
    topBorder.backgroundColor = [UIColor whiteColor];
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(xPositonDivisorAllowance, self.frame.size.height, self.frame.size.width - (xPositonDivisorAllowance * 2.0), 1.0)];
    bottomBorder.backgroundColor = [UIColor whiteColor];
    [self addSubview:topBorder];
    [self addSubview:bottomBorder];
    
    if (self.graphViewLabelA == nil) {
        self.graphViewLabelA = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 100.0 -xPositonDivisorAllowance, 2.0, 100.0, 12.0)];
        self.graphViewLabelA.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        self.graphViewLabelA.textColor = [UIColor whiteColor];
        self.graphViewLabelA.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.graphViewLabelA];
        
        self.graphViewLabelB = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 100.0 -xPositonDivisorAllowance, self.frame.size.height - 12.0, 100.0, 12.0)];
        self.graphViewLabelB.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        self.graphViewLabelB.textColor = [UIColor whiteColor];
        self.graphViewLabelB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.graphViewLabelB];
    }
    
    if (self.graphViewContainer == nil) {
        self.graphViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.graphViewContainer];
    }
}

- (void) arrangeGraphPoints {
    // Get Maximum Point and Min Point
    float max = [[self.graphPoints valueForKeyPath:@"@max.floatValue"] floatValue];
    float min = [[self.graphPoints valueForKeyPath:@"@min.floatValue"] floatValue];
    float meanValue = [[self.graphPoints valueForKeyPath:@"@avg.floatValue"] floatValue];
    float countPoints = [self.graphPoints count];
    
    // Round off to nearest divisible by 10
    float roundMax = round(max / 10.0) * 10.0;
    float roundMin = round(min / 10.0) * 10.0;
    
    // if RoundedMax is greater add 10 to it
    if (roundMax < max) {
        roundMax += 10.0;
    }
    
    // Display round-off Values
    self.graphViewLabelA.text = [NSString stringWithFormat:@"%.0f", roundMax];
    self.graphViewLabelB.text = [NSString stringWithFormat:@"%.0f", roundMin];
    
    float xPositionDivisor = (self.graphViewContainer.frame.size.width - (xPositonDivisorAllowance * 2.0)) / countPoints;
    float yPlotHeight = self.graphViewContainer.frame.size.height - (yPositonDivisorAllowance * 2.0);
    
    UIBezierPath *polygonPath = [UIBezierPath bezierPath];
    
    for (int ctr = 0 ; ctr < countPoints ; ctr++) {
        // reciprocation formula
        float reciprocatedY = (yPlotHeight - ((yPlotHeight * [self.graphPoints[ctr] floatValue]) / roundMax)) + yPositonDivisorAllowance;
        float xPosition = (ctr * xPositionDivisor) + xPositonDivisorAllowance;
        xPosition += (xPositionDivisor / 2);
        
        [self fillCircleCenteredAt:CGPointMake(xPosition, reciprocatedY)];
        if (ctr == 0) {
            [polygonPath moveToPoint:CGPointMake(xPosition, reciprocatedY)];
        }
        else {
            [polygonPath addLineToPoint:CGPointMake(xPosition, reciprocatedY)];
        }
    }
    
    CAShapeLayer *linesLayer = [[CAShapeLayer alloc] init];
    [linesLayer setPath:polygonPath.CGPath];
    [linesLayer setStrokeColor:[UIColor whiteColor].CGColor];
    [linesLayer setFillColor:[UIColor clearColor].CGColor];
    [linesLayer setLineWidth:1.0f];
    
    [self.graphViewContainer.layer addSublayer:linesLayer];
    
    // Find the Mean Y Reciprocation
    float meanReciprocatedY = (yPlotHeight - ((yPlotHeight * meanValue) / roundMax)) + yPositonDivisorAllowance;
    
    UIBezierPath *anotherPath = [UIBezierPath bezierPath];
    [anotherPath moveToPoint:CGPointMake(xPositonDivisorAllowance, meanReciprocatedY)];
    [anotherPath addLineToPoint:CGPointMake(self.frame.size.width - xPositonDivisorAllowance, meanReciprocatedY)];
    
    CAShapeLayer *anotherLayer = [[CAShapeLayer alloc] init];
    [anotherLayer setPath:anotherPath.CGPath];
    [anotherLayer setStrokeColor:[UIColor whiteColor].CGColor];
    [anotherLayer setFillColor:[UIColor clearColor].CGColor];
    [anotherLayer setLineWidth:1.0f];
    [anotherLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2],
                                     [NSNumber numberWithInt:1],nil]];
    [self.graphViewContainer.layer addSublayer:anotherLayer];
}

-(void)fillCircleCenteredAt:(CGPoint)center
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:center radius:2.5 startAngle:0 endAngle:2 * PI clockwise:YES];
    
    CAShapeLayer *circleLAyer = [[CAShapeLayer alloc] init];
    [circleLAyer setPath:bezierPath.CGPath];
    [circleLAyer setStrokeColor:[UIColor whiteColor].CGColor];
    [circleLAyer setFillColor:[UIColor clearColor].CGColor];
    [circleLAyer setLineWidth:2.0f];
    
    [self.graphViewContainer.layer addSublayer:circleLAyer];
}

@end
