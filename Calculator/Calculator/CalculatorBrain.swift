//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Juan Garcia on 10/18/16.
//  Copyright © 2016 Juan Eduardo Garcia. All rights reserved.
//

// this is the model

// note: make things private if they are not needed by a user
// public if making framework that someone will use
// private -> only accesible by this object

// --==--== --==--== --==--== --==--== --==--== --==--== --==--== Stopped video @ 39:48 ==--==-- ==--==-- ==--==-- ==--==-- ==--==-- ==--==-- ==--==-- //


import Foundation

class CalculatorBrain {
    // data structure
    // op could be an operand or operation
    private enum Op {
        // no inheritance
        // only computed properties
        // good for whend something needs to be one thing one time and another at another time (never both)
        case Operand(Double)
        case UnaryOperation(String, Double -> Double) // takes a string an a function that takes a double and returns a double
        case BinaryOperation(String, (Double, Double) -> Double)
        // swift has the capability to assossiate data with the cases in the enum
        // api: application programming interface -> methods and properties that make up your class
    }
    
    // var opStack = Array<Op>() // simple and clear, not prefered
    private var opStack = [Op]() // prefered notation (also prefered to be private because its type is private and we dont want other obj.s messing with it)
    
    // this is a dictionary
    // var knownOps = Dictionary<String, Op>() // not prefered
    private var knownOps = [String:Op]() // prefered (may want in the future to make it public to allow someone else to teach it new ops -> for now it has to be private)
    
    // my first initializer -> aka constructor
    init() {
//        knownOps["×"] = Op.BinaryOperation("×", { $0 * $1 })
        
        knownOps["×"] = Op.BinaryOperation("×", * ) // just like in square root this is a function that takes parameters and returns double (in this case two doubles)
        // the reason both division and subtraction do not work like multiplication and addition is because the order of the values matters in this cases and it is necesary to specify
        knownOps["÷"] = Op.BinaryOperation("÷", { $1 / $0 })
        knownOps["+"] = Op.BinaryOperation("+", + )
        knownOps["−"] = Op.BinaryOperation("−", { $1 - $0 })
        
//        knownOps["√"] = Op.UnaryOperation("√", { sqrt($0) }) // this line is not the best way to do it
        knownOps["√"] = Op.UnaryOperation("√", sqrt) // because this is a function that takes a value and returns a value (just like we want)
    }
    
    
    // arrays and dictionarys are not classes, and classes are pass by value. Arrays and dictionarys are strucs (structures almost the same as classes)
    // diff between strucs and classes are classes inherit, structs are passed by value.  Note: even doubles and ints are structs.
    
    // unnamed tuple ->(Double!, [Op]) // this still works in the following, but adding names is very helpfull
    func evaluate(ops: [Op]) -> (result: Double!, remainingOps: [Op]) { // tuple with names -> good for readability.
        // tuple, make like a pseudo object -> (kind of a list in here) // can be more than two items
        // tuple can be used for return
        
        if !ops.isEmpty { // check that the stack is not empty
            // let op = ops.removeLast() -> error: can' remove last from an immutable object
            let op = ops.removeLast()
        }
        return (nil, ops) // failure or default -> can't be evaluated
        
    }
    
    func evaluate() -> Op { // return optional -> can't evaluate things like "+" alone... this is important, may need to return a nil in this situation
        // advise -> recursion ahead...
        
        
        // example evaluate the stack (x, 4, +, 5, 6):
        
            // helper that checks a stack -> evaluates the top (may need to look at everything in the stack)
            // 1st -> x              stack: (4, +, 5, 6)   (calls itself again because "x" needs two operands)
            // 2nd -> 4 X            stack: (+, 5, 6)      (four is found and returns it, but it still needs another number, so it makes the call again this time for the next value needed to multiply)
            // 3rd -> 4 x ( + )      stack: (5, 6)         (plus ("+" note: the parentesis are for human help, the program did not make those) is found and we make a recursive call to find the operands needed, this time for addition)
            // 4th -> 4 x ( 5 + )    stack: (6)            (five is found, then the next number is needed for the addition)
            // 5th -> 4 x ( 5 + 6 )  stack: ()             (six is found, the addition can be computed, thus returning the operand needed for mutiplication. Which in turn returns the outcome of that number and four)
        
        
    }
    
    
    func pushOperand(operand: Double){ // public
        // making an enum: Op.Operand(operand)
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol: String) { // public
        // the brackets in the following line are the way that we search things in a dictionary
        if let operation = knownOps[symbol] { // the reason this is an optional op (Op?) is because you may be searching for something that is not there -> thus nil will be returned
            opStack.append(operation) // if it can be found in known operations add it to the opStack
        }
    }
}