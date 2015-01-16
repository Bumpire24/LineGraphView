//
//  LineGraphUsage.h
//  PGPrototype
//
//  Created by macbook on 1/6/15.
//  Copyright (c) 2015 Bumpire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineGraphView.h"

@interface LineGraphUsage : UIViewController

@property (nonatomic, weak) IBOutlet LineGraphView *lineGraphView;

- (IBAction) hitME:(id)sender;

@end
