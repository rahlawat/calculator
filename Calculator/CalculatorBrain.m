//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Renu Ahlawat on 3/5/13.
//  Copyright (c) 2013 Renu Ahlawat. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}
-(void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}
-(double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}
-(double)performOperation:(NSString *)operation{
    double result = 0;
    double operand1 = [self popOperand];
    double operand2 = [self popOperand];
    if([operation isEqualToString:@"+"])
    {
        result = operand2 + operand1;
    } else if([@"-" isEqualToString:operation])
    {
        result = operand2 - operand1;
    } else if([@"*" isEqualToString:operation])
    {
        result = operand2 * operand1;
    } else if([@"/" isEqualToString:operation])
    {
        if(operand2 != 0)
            result = operand2 / operand1;
    } else if([@"Sqrt" isEqualToString:operation])
    {
        result = sqrt(operand1);
    }
    [self pushOperand:result];
    return result;
}
-(void)emptyStack{
    [self.operandStack removeAllObjects];
}
@end
