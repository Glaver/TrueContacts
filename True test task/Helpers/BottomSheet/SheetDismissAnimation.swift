import UIKit

final class SheetDismissAnimation: NSObject {
    // MARK: - Private Methods

    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating? {
        guard let fromView = transitionContext.view(forKey: .from),
              let fromViewController = transitionContext.viewController(forKey: .from)
        else {
            return nil
        }

        let initialFrame = transitionContext.initialFrame(for: fromViewController)
        let animator = UIViewPropertyAnimator(duration: Constants.animationDuration, dampingRatio: 0.6) {
            fromView.frame = initialFrame.offsetBy(dx: 0, dy: initialFrame.height)
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        return animator
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension SheetDismissAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let animator = animator(using: transitionContext) else {
            return
        }
        animator.startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return animator(using: transitionContext) ?? UIViewPropertyAnimator()
    }
}

// MARK: - Constants

extension SheetDismissAnimation {
    enum Constants {
        static let animationDuration: Double = 0.75
    }
}
