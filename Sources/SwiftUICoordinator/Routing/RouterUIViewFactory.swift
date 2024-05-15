import Foundation
import UIKit

@MainActor
public protocol RouterUIViewFactory {
    associatedtype Route: NavigationRoute
    
    func viewController(for route: Route) -> UIViewController
}
