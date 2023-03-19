import UIKit

final class SheetPresentAnimation: NSObject {
    // MARK: - Private Methods

    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating? {
        guard let toView = transitionContext.view(forKey: .to),
              let toViewController = transitionContext.viewController(forKey: .to)
        else {
            return nil
        }

        let finalFrame = transitionContext.finalFrame(for: toViewController)
        toView.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
        let animator = UIViewPropertyAnimator(duration: Constants.animationDuration, dampingRatio: 0.6) {
            toView.frame = finalFrame
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension SheetPresentAnimation: UIViewControllerAnimatedTransitioning {
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

extension SheetPresentAnimation {
    enum Constants {
        static let animationDuration: Double = 0.75
    }
}
