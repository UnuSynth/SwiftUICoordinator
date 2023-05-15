//
//  NavigationController.swift
//  
//
//  Created by Erik Drobne on 12/05/2023.
//

import Foundation
import SwiftUI

public class NavigationController: UINavigationController, UINavigationControllerDelegate {
    
    public private(set) var transitions = [Transition]()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        for transition in transitions {
            if let fromRoute = (fromVC as? NavigationRouteHostingController)?.route,
               let toRoute = (toVC as? NavigationRouteHostingController)?.route {
                if transition.isEligible(from: fromRoute,to: toRoute) {
                    return transition
                }
            }
        }
        
        return nil
    }
    
    public func register(_ transition: Transition) {
        transitions.append(transition)
    }
}

public protocol Transition: UIViewControllerAnimatedTransitioning {
    func isEligible(from fromRoute: NavigationRoute, to toRoute: NavigationRoute) -> Bool
}
