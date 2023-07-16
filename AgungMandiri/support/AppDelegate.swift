

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let home = MovieRouter.createModule()
        let navigationContoller = UINavigationController(rootViewController: home)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationContoller
        window?.makeKeyAndVisible()
        
        return true
    }
}

