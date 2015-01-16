//
//  LineGraphUsage.m
//  PGPrototype
//
//  Created by macbook on 1/6/15.
//  Copyright (c) 2015 Bumpire. All rights reserved.
//

#import "LineGraphUsage.h"

@interface LineGraphUsage ()

@end

@implementation LineGraphUsage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)hitME:(id)sender {
    // produce randomly sets of numbers
    NSMutableArray *sample = [[NSMutableArray alloc] init];
    for (int ctr = 0 ; ctr < 20; ctr++) {
        float randomNumber = rand() % 1000;
        [sample addObject:[NSNumber numberWithFloat:randomNumber]];
    }
    [self.lineGraphView plotGraphPoints:(NSArray*)sample];
}

@end
