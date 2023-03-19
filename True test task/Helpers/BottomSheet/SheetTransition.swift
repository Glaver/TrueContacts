import UIKit

public final class SheetTransition: NSObject {
    // MARK: - Private Property

    private let driver = SheetTransitionDriver()
}

// MARK: - UIViewControllerTransitioningDelegate

extension SheetTransition: UIViewControllerTransitioningDelegate {
    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        driver.link(to: presented)

        return SheetPresentationController(
            presentedViewController: presented,
            presenting: presenting ?? source
        )
    }

    public func animationController(
        forPresented _: UIViewController,
        presenting _: UIViewController,
        source _: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return SheetPresentAnimation()
    }

    public func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SheetDismissAnimation()
    }

    public func interactionControllerForDismissal(using _: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
}
