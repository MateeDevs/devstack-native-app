//
//  Created by Petr Chmelar on 16/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

#if ALPHA || BETA
import Atlantis
#endif

import DataLayer
import DomainLayer
import PresentationLayer
import Resolver
import UIKit
import UserNotifications
import WidgetKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var flowController: AppFlowController?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        setupEnvironment()
        
        Resolver.registerProviders(application: application, appDelegate: self, networkProviderDelegate: self)
        
        // Init main window with navigation controller
        let nc = BaseNavigationController(statusBarStyle: .lightContent)
        nc.navigationBar.isHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        // Init main flow controller and start the flow
        flowController = AppFlowController(
            navigationController: nc,
            dependencies: UseCaseDependencyImpl(
                dependencies: RepositoryDependencyImpl(),
                kmpDependencies: KMPKoinDependency()
            )
        )
        flowController?.start()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: Setup environment
    private func setupEnvironment() {
        #if ALPHA
        Atlantis.start()
        Environment.type = .alpha
        Logger.info("ALPHA environment", category: .app)
        #elseif BETA
        Atlantis.start()
        Environment.type = .beta
        Logger.info("BETA environment", category: .app)
        #elseif PRODUCTION
        Environment.type = .production
        Logger.info("PRODUCTION environment", category: .app)
        #endif
        
        #if DEBUG
        Environment.flavor = .debug
        #else
        Environment.flavor = .release
        #endif
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // Show system notification
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let notification = response.notification.request.content.userInfo
        DispatchQueue.main.async {
            self.flowController?.handlePushNotification(notification)
        }
    }
}

extension AppDelegate: NetworkProviderDelegate {
    func didReceiveHttpUnauthorized() {
        self.flowController?.handleLogout()
    }
}
