import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

        let tableViewController = CalculatorViewController(style: UITableViewStyle.Grouped)
        let navController = UINavigationController(rootViewController: tableViewController)
        
        self.window!.rootViewController = navController
        self.window!.makeKeyAndVisible()

        return true
    }

}

