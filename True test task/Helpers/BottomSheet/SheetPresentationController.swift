import UIKit

public protocol SheetPresentable {
    var presentationHeight: CGFloat { get }
}

public final class SheetPresentationController: UIPresentationController {
    // MARK: - Private Property

    private let verticalSizePolicy: VerticalSizePolicy

    private lazy var bottomInsetView = UIView()
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.7

        let tapToDismissGesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        tapToDismissGesture.delegate = self
        view.addGestureRecognizer(tapToDismissGesture)

        return view
    }()

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let height = (presentedViewController as? SheetPresentable)?.presentationHeight ?? 300
        verticalSizePolicy = .constant(height)

        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    // MARK: - Override

    public override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return .zero
        }

        let bounds = containerView.bounds

        var height: CGFloat = containerView.safeAreaInsets.bottom
        switch verticalSizePolicy {
        case let .constant(value):
            height += value
        }

        let origin = CGPoint(x: 0, y: bounds.maxY - height)
        let size = CGSize(width: bounds.width, height: height)

        return CGRect(origin: origin, size: size)
    }

    public override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()

        backgroundView.frame = containerView?.frame ?? .zero
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    public override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let presentedView = presentedView else {
            return
        }
        containerView?.addSubview(backgroundView)
        performAlongsideTransitionIfPossible { [weak self] in
            self?.backgroundView.alpha = 0.7
        }

        addBottomInsetView(to: presentedView)
        containerView?.addSubview(presentedView)
    }

    public override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)

        guard !completed else {
            return
        }
        backgroundView.removeFromSuperview()
    }

    public override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()

        performAlongsideTransitionIfPossible { [weak self] in
            self?.backgroundView.alpha = 0
        }
    }

    public override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)

        guard completed else {
            return
        }
        backgroundView.removeFromSuperview()
    }

    // MARK: - Private Methods

    private func addBottomInsetView(to presentedView: UIView) {
        presentedView.addSubview(bottomInsetView)
        bottomInsetView.translatesAutoresizingMaskIntoConstraints = false
        bottomInsetView.backgroundColor = presentedView.backgroundColor

        NSLayoutConstraint.activate([
            bottomInsetView.topAnchor.constraint(equalTo: presentedView.bottomAnchor,
                                                 constant: 0),
            bottomInsetView.leadingAnchor.constraint(equalTo: presentedView.leadingAnchor,
                                                     constant: 0),
            bottomInsetView.trailingAnchor.constraint(equalTo: presentedView.trailingAnchor,
                                                      constant: 0),
            bottomInsetView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func performAlongsideTransitionIfPossible(_ animation: @escaping () -> Void) {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            animation()
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            animation()
        })
    }

    @objc
    private func hide() {
        presentedViewController.dismiss(animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension SheetPresentationController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(
        _: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        return touch.view === backgroundView
    }
}

// MARK: - VerticalSizePolicy

private extension SheetPresentationController {
    enum VerticalSizePolicy {
        case constant(CGFloat)
    }
}
