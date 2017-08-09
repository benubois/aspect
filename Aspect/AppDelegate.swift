import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let tableViewController = CalculatorViewController(style: UITableViewStyle.grouped)
        let navController = UINavigationController(rootViewController: tableViewController)
        navController.navigationBar.prefersLargeTitles = true
        
        self.window!.rootViewController = navController
        self.window!.makeKeyAndVisible()

        return true
    }

}

