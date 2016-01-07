//
//  SegmentViewController.swift
//  Beeline
//
//  Created by Karl Bowden on 5/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

public class StackViewController: UINavigationController {

    public enum TransitionAction {
        case Pop(Segment)
        case Push(Segment)
        case Change(Segment)
    }

    public var currentStack: [Segment] = []

    public func setStack(newStack: [Segment]) {

        let transitionStack = ZippedStack(currentStack, newStack)
        let stackActions = transitionActions(transitionStack)
        performActions(stackActions)
        currentStack = newStack
    }

    public func transitionActions(stack: ZippedStack<Segment>) -> [TransitionAction] {

        let fromActions: [TransitionAction] = stack.from.reverse().map { .Pop($0) }
        let toActions: [TransitionAction] = stack.to.map { .Push($0) }
        return fromActions + toActions
    }

    public func performActions(actionStack: [TransitionAction]) {
        for action in actionStack {
            switch action {

            case .Push(let segment):
                pushViewController(segment.create(), animated: true)

            case .Pop:
                popViewControllerAnimated(true)

            case .Change:
                fatalError("No change event yet")
            }
        }
    }
}
