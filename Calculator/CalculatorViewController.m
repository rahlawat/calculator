//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Renu Ahlawat on 3/5/13.
//  Copyright (c) 2013 Renu Ahlawat. All rights reserved.
// 

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringAText;
@property (nonatomic ,strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
    @synthesize display = _display;
    @synthesize brain = _brain;
    @synthesize userIsInTheMiddleOfEnteringAText = _userIsInTheMiddleOfEnteringAText;
    -(CalculatorBrain *)brain
    {
        if(!_brain) _brain = [[CalculatorBrain alloc] init];
        return _brain;
    }
    - (IBAction)digitPressed:(UIButton *)sender {
        NSString *digit = [sender currentTitle];
        if (self.userIsInTheMiddleOfEnteringAText) {
            self.display.text = [self.display.text stringByAppendingString:digit];
        } else {
            self.display.text = digit;
            self.userIsInTheMiddleOfEnteringAText = YES;
        }
    }
    - (IBAction)operationPressed:(UIButton *)sender {
        if(self.userIsInTheMiddleOfEnteringAText) [self enterPressed];
        double result = [self.brain performOperation:sender.currentTitle];
            self.display.text = [NSString stringWithFormat:@"%g", result];
    }
    - (IBAction)enterPressed {
        [self.brain pushOperand:[self.display.text doubleValue]];
        self.userIsInTheMiddleOfEnteringAText = NO;
    }
- (IBAction)clearPressed:(id)sender {
    [self.brain emptyStack];
    self.userIsInTheMiddleOfEnteringAText = NO;
    self.display.text = @"0";
}
- (IBAction)floatPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringAText) {
        NSRange range = [self.display.text rangeOfString:@"."];
        if(range.location == NSNotFound     ) {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        }
    } else {
        self.display.text = [@"0" stringByAppendingString:@"."];
        self.userIsInTheMiddleOfEnteringAText = YES;
    }

} 
@end
