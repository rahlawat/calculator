//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Renu Ahlawat on 3/5/13.
//  Copyright (c) 2013 Renu Ahlawat. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain
@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

-(void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}


-(double)performOperation:(NSString *)operation{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

-(void)emptyStack{
    [self.programStack removeAllObjects];
}

- (id)program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"assignment";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    id topOfStack = [stack lastObject];
    if(topOfStack) [stack removeLastObject];
    
    if([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }
    else if([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        if([operation isEqualToString:@"+"])
        {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if([@"-" isEqualToString:operation])
        {   double subtrand = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtrand;
        } else if([@"*" isEqualToString:operation])
        {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if([@"/" isEqualToString:operation])
        {
            double divisor = [self popOperandOffStack:stack];
            if(divisor != 0)
                result = [self popOperandOffStack:stack] / divisor;
        } else if([@"Sqrt" isEqualToString:operation])
        {
            result = sqrt([self popOperandOffStack:stack]);
        }
        else if([@"Sin" isEqualToString:operation])
        {
            result =  sin([self popOperandOffStack:stack] *M_PI/180);
        }
        else if([@"Cos" isEqualToString:operation])
        {
            result =  cos([self popOperandOffStack:stack] *M_PI/180);
        }
 
    }
    return result;
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
    }
    
    return [self popOperandOffStack:stack];
}
@end
