import UIKit

final class SheetTransitionDriver: UIPercentDrivenInteractiveTransition {
    // MARK: - Private Property

    private var presentedController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer?

    private var maxTranslation: CGFloat {
        return presentedController?.view.frame.height ?? 0
    }

    private var isRunning: Bool {
        return percentComplete != 0
    }

    // MARK: - Override

    override var wantsInteractiveStart: Bool {
        get {
            return panRecognizer?.state == .began
        }
        set {
            super.wantsInteractiveStart = newValue
        }
    }

    // MARK: - Public Methods

    func link(to controller: UIViewController) {
        presentedController = controller
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panRecognizer = gestureRecognizer
        panRecognizer?.delegate = self
        presentedController?.view.addGestureRecognizer(gestureRecognizer)
    }

    // MARK: - Private Methods

    @objc
    private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            pause()
            guard !isRunning else {
                return
            }
            presentedController?.dismiss(animated: true)
        case .changed:
            update(percentComplete + sender.incrementToBottom(maxTranslation: maxTranslation))
        case .ended, .cancelled:
            if sender.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                finish()
            } else {
                cancel()
            }
        case .failed:
            cancel()
        default:
            break
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension SheetTransitionDriver: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let scrollView = otherGestureRecognizer.view as? UIScrollView else {
            return true
        }

        let point = gestureRecognizer.location(in: gestureRecognizer.view)
        return point.y < 50 || (!scrollView.isDragging && scrollView.contentOffset == .zero)
    }
}

// MARK: - Helpers

private extension UIPanGestureRecognizer {
    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translationY = translation(in: view).y
        setTranslation(.zero, in: nil)
        return translationY / maxTranslation
    }

    func isProjectedToDownHalf(maxTranslation: CGFloat) -> Bool {
        let endLocation = projectedLocation()
        let isPresentationCompleted = endLocation.y > maxTranslation / 2
        return isPresentationCompleted
    }

    func projectedLocation() -> CGPoint {
        let velocityOffset = velocity(in: view).projectedOffset(decelerationRate: .normal)
        let projectedLocation = location(in: view) + velocityOffset
        return projectedLocation
    }
}

private extension CGPoint {
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        return CGPoint(
            x: x.projectedOffset(decelerationRate: decelerationRate),
            y: y.projectedOffset(decelerationRate: decelerationRate)
        )
    }

    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
}

private extension CGFloat { // Velocity value
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGFloat {
        // Formula from WWDC
        let multiplier = 1 / (1 - decelerationRate.rawValue) / 1000
        return self * multiplier
    }
}
