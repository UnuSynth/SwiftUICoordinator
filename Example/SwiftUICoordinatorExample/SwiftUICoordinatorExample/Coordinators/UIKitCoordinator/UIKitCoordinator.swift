import Foundation
import UIKit
import SwiftUICoordinator

enum UIKitRoute: NavigationRoute {
    case vc

    var title: String? {
        switch self {
        case .vc:
            return "ViewController!"
        }
    }

    var action: TransitionAction? {
        switch self {
        case .vc:
            return .push(animated: true)
        }
    }
}

enum UIKitAction: CoordinatorAction {
    case openVC
}

class UIKitCoordinator: Routing {
    var parent: Coordinator?
    
    var childCoordinators: [WeakCoordinator] = []
    
    var navigationController: NavigationController
    
    var startRoute: UIKitRoute
    
    init(
        parent: Coordinator?,
        navigationController: NavigationController,
        startRoute: UIKitRoute = .vc
    ) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
    }
    
    func handle(_ action: CoordinatorAction) {
        switch action {
        case UIKitAction.openVC:
            try? show(route: .vc)
        default:
            parent?.handle(action)
        }
    }
}

extension UIKitCoordinator: RouterUIViewFactory {
    func viewController(for route: UIKitRoute) -> UIViewController {
        switch route {
        case .vc:
            return TestViewController()
        }
    }
}
