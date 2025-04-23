import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var maruViewController: MaruViewController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        if let rootVC = window?.rootViewController as? MaruViewController {
            maruViewController = rootVC
        } else if let navController = window?.rootViewController as? UINavigationController,
                  let maruVC = navController.viewControllers.first as? MaruViewController {
            maruViewController = maruVC
        }

        return true
    }
}
