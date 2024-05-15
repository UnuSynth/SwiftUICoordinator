import Foundation
import UIKit
import SwiftUICoordinator

@MainActor
public protocol RouterUIViewFactory {
    associatedtype Route: NavigationRoute
    
    func viewController(for route: Route) -> UIViewController
}
