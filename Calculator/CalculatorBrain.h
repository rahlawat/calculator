//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Renu Ahlawat on 3/5/13.
//  Copyright (c) 2013 Renu Ahlawat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;
-(void)emptyStack;
@property (readonly) id program;
+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;
@end
