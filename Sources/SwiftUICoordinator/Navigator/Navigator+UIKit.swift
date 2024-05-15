import Foundation
import UIKit

public extension Navigator where Self: RouterUIViewFactory {
    
    // MARK: - Public properties

    var viewControllers: [UIViewController] {
        return navigationController.viewControllers
    }

    var topViewController: UIViewController? {
        return navigationController.topViewController
    }

    var visibleViewController: UIViewController? {
        return navigationController.visibleViewController
    }
    
    // MARK: - Public methods

    func start() throws {
        try show(route: startRoute)
    }

    func show(route: Route) throws {
        let viewController = viewController(for: route)
        navigationController.isNavigationBarHidden = route.title == nil
        
        switch route.action {
        case .push(let animated):
            navigationController.pushViewController(viewController, animated: animated)
        case .present(let animated, let modalPresentationStyle, let delegate, let completion):
            present(
                viewController: viewController,
                animated: animated,
                modalPresentationStyle: modalPresentationStyle,
                delegate: delegate,
                completion: completion
            )
        case .none:
            throw NavigatorError.cannotShow(route)
        }
    }

    func set(routes: [Route], animated: Bool = true) {
        let viewControllers = viewControllers(for: routes)
        navigationController.isNavigationBarHidden = routes.last?.title == nil
        navigationController.setViewControllers(viewControllers, animated: animated)
    }

    func append(routes: [Route], animated: Bool = true) {
        let viewControllers = viewControllers(for: routes)
        navigationController.isNavigationBarHidden = routes.last?.title == nil
        navigationController.setViewControllers(self.viewControllers + viewControllers, animated: animated)
    }

    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool = true) {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: animated)
        }
        navigationController.popToRootViewController(animated: animated)
    }

    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }
    
    // Private methods
    
    private func viewControllers(for routes: [Route]) -> [UIViewController] {
        return routes.map { viewController(for: $0) }
    }
    
    private func present(
        viewController: UIViewController,
        animated: Bool,
        modalPresentationStyle: UIModalPresentationStyle,
        delegate: UIViewControllerTransitioningDelegate?,
        completion: (() -> Void)?
    ) {
        if let delegate {
            viewController.modalPresentationStyle = .custom
            viewController.transitioningDelegate = delegate
        } else {
            viewController.modalPresentationStyle = modalPresentationStyle
        }
        
        navigationController.present(viewController, animated: animated, completion: completion)
    }
}
