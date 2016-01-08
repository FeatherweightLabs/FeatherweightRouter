//
//  SegmentViewController.swift
//  Beeline
//
//  Created by Karl Bowden on 5/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//


public enum TransitionAction {
    case Pop(Segment)
    case Push(Segment)
    case Change(Segment)
}

/**
 StackViewController. 
 This is basic protocol for the basic stack controller.
*/
public protocol StackViewController {
    
    var dismissViewController : (Path) -> () {get set}
    func setStack(currentStack: [Segment], newStack: [Segment]) -> [Segment]
    func popFromStack(currentStack: [Segment]) -> [Segment];
    func transitionActions(stack: ZippedStack<Segment>) -> [TransitionAction]
    func performActions(actionStack: [TransitionAction]) throws
}


/**
 Contains default implementations of basic navigation related methods
*/
// MARK: - StackViewController
extension StackViewController {
    public func transitionActions(stack: ZippedStack<Segment>) -> [TransitionAction] {
        
        let fromActions: [TransitionAction] = stack.from.reverse().map { .Pop($0) }
        let toActions: [TransitionAction] = stack.to.map { .Push($0) }
        return fromActions + toActions
    }
    public func setStack(currentStack: [Segment], newStack: [Segment]) -> [Segment]{
        let transitionStack = ZippedStack(currentStack, newStack)
        let stackActions = transitionActions(transitionStack)
        
        do {
            try performActions(stackActions)
        } catch {
            
        }
        return newStack
    }
    
    /**
     Used for going back in the stack. As an alternative to the native go back function
    */
    public func popFromStack(currentStack: [Segment]) -> [Segment] {
        var newStack = currentStack;
        newStack.popLast();
        
        let transitionStack = ZippedStack(currentStack, newStack);
        let stackActions = transitionActions(transitionStack)

        do {
            try performActions(stackActions)
        } catch {
            
        }
        return newStack
    }
}


/**
 UIKit implementation of the StackViewController
*/
public class UIStackViewController: UINavigationController, StackViewController {
    public var dismissViewController: (Path) -> () = { path in};
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(){
        super.init(nibName: nil, bundle: nil);
    }
  
    public func performActions(actionStack: [TransitionAction]) throws {
        for action in actionStack {
            switch action {
                
            case .Push(let segment):
                guard let uiViewController = segment.create(dismissViewController) as? UIViewController else {
                    throw RouterError.InvalidViewControllerType
                }
                pushViewController(uiViewController, animated: true)
                
            case .Pop:
                popViewControllerAnimated(true)
                
            case .Change:
                fatalError("No change event yet")
            }
        }
    }
}


enum RouterError: ErrorType {
    case InvalidViewControllerType
}

