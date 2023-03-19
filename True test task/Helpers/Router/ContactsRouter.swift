//import UIKit
//
//enum ContactSegue {
//    case permissionBottomSheet
//    case contactList
//}
//
//protocol ConatctsRouter {
//    func perform(_ segue: ContactSegue, from source: MainViewController)
//}
//
//class ContatcsRouter: ConatctsRouter {
//    static func launch(with window: UIWindow?) {
//        if let navigationController = window?.rootViewController as? UINavigationController,
//            let mainViewController = navigationController.viewControllers.first as? MainViewController {
//            let viewModel = MainViewModel()
//            mainViewController.viewModel = viewModel
//            mainViewController.router = ContatcsRouter()
//        }
//    }
//
//    func perform(_ segue: ContactSegue, from source: MainViewController) {
//        switch segue {
////        case .login:
////            if source.viewModel.state.shouldChangePassword {
////                let vc = DefaultLoginRouter.makeDummyViewController(withTitle: "Change Password")
////                source.navigationController?.pushViewController(vc, animated: true)
////            } else {
////                let nc = DefaultLoginRouter.makeMoviesViewController()
////                weak var weakSource = source
////                source.present(nc, animated: true) {
////                    _ = weakSource?.navigationController?.popToRootViewController(animated: false)
////                }
////            }
////
////        case .forgotPassword:
////            let vc = DefaultLoginRouter.makeDummyViewController(withTitle: "Forgot Password")
////            source.navigationController?.pushViewController(vc, animated: true)
////        case .signUp:
////            let vc = DefaultLoginRouter.makeDummyViewController(withTitle: "Sign Up")
////            source.navigationController?.pushViewController(vc, animated: true)
//
//
//        case .permissionBottomSheet:
//            let nc = ContatcsRouter.makePermissionRequest()
//            weak var weakSource = source
//            source.present(nc, animated: true) {
//                _ = weakSource?.navigationController?.popToRootViewController(animated: false)
//            }
//        case .contactList:
//            let viewModel = ContactsListViewModel()
//            let vc = ContactsListViewController(viewModel: viewModel)
//    //        self.present(vc, animated: true)
//
//
//            let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
//            DispatchQueue.main.async {
//                window?.rootViewController = vc
//                window?.makeKeyAndVisible()
//            }
//        }
//    }
//}
//
//// MARK: Helpers
//private extension ContatcsRouter {
//
//    
////    class DestinationMoviesRouter: DummyRouter {
////        func perform(_ segue: DummySegue, from source: DummyViewController) {
////            switch segue {
////            case .next:
////                let nc = DefaultLoginRouter.makeMoviesViewController()
////                weak var weakSource = source
////                source.present(nc, animated: true) {
////                    _ = weakSource?.navigationController?.popToRootViewController(animated: false)
////                }
////            }
////        }
////    }
//
////    static func makeMoviesViewController() -> UINavigationController {
////        let vc = MoviesViewController.instantiate()
////        vc.viewModel = MoviesViewModel()
////        let nc = UINavigationController(rootViewController: vc)
////        return nc
////    }
////
////    static func makeDummyViewController(withTitle title: String) -> DummyViewController {
////        let vc = DummyViewController()
////        vc.title = title
////        vc.router = DestinationMoviesRouter()
////        return vc
////    }
//
//    static func makePermissionRequest() -> UINavigationController {
//        let viewModel = ContactsBottomSheetViewModel()
//        let vc = ContactsBottomSheetViewController(viewModel: viewModel)
//        let nc = UINavigationController(rootViewController: vc)
//        return nc
//    }
//}
//
//
////import UIKit
////
////protocol Router {
////   func route(
////      to routeID: String,
////      from context: UIViewController,
////      parameters: Any?
////   )
////}
////
////enum Route: String {
////   case getContactsPermission
////   case contacts
////   case goToSettings
////}
////
////class ContactsRouter: Router {
//////    unowned var viewModel: LoginViewModel
//////    init(viewModel: LoginViewModel) {
//////        self.viewModel = viewModel
//////    }
////
////    func route(
////        to routeID: String,
////        from context: UIViewController,
////        parameters: Any?)
////    {
////        guard let route = Route(rawValue: routeID) else {
////            return
////        }
////
////        switch route {
////        case .getContactsPermission:
////            let vc = ContactsBottomSheetViewController()
////
////        case .contacts:
////            // Push sign-up-screen:
////            let vc = SignUpViewController()
////            let vm = SignUpViewModel()
////            vc.viewModel = vm
////            vc.router = SignUpRouter(viewModel: vm)
////            context.navigationController.push(vc, animated: true)
////        case . goToSettings:
////            // Push forgot-password-screen.
////        }
////    }
////}
