//
//  Created by Petr Chmelar on 16/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

#if ALPHA || BETA
import Atlantis
#endif

import KeychainProvider
import NetworkProvider
import OSLog
import Resolver
import SharedDomain
import UIKit
import UIToolkit
import UserNotifications
import Utilities

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var flowController: AppFlowController?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        setupEnvironment()
        
        // Register all dependencies
        Resolver.registerProviders(application: application, appDelegate: self, networkProviderDelegate: self)
        Resolver.registerRepositories()
        Resolver.registerUseCases()
        Resolver.registerKMPUseCases(kmp: KMPKoinDependency())
        
        // Clear keychain on first run
        clearKeychain()
        
        // Setup firebase for debug
        firebaseDebugSetup()
        
        // Register for remote notifications
        application.registerForRemoteNotifications()
        
        // Init main window with navigation controller
        let nc = BaseNavigationController(statusBarStyle: .lightContent)
        nc.navigationBar.isHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        // Init main flow controller and start the flow
        flowController = AppFlowController(navigationController: nc)
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
        Logger.app.info("ALPHA environment")
        #elseif BETA
        Atlantis.start()
        Environment.type = .beta
        Logger.app.info("BETA environment")
        #elseif PRODUCTION
        Environment.type = .production
        Logger.app.info("PRODUCTION environment")
        #endif
        
        #if DEBUG
        Environment.flavor = .debug
        #else
        Environment.flavor = .release
        #endif
    }
    
    // MARK: Clear keychain
    private func clearKeychain() {
        let keychainProvider: KeychainProvider = Resolver.resolve()
        
        try? keychainProvider.deleteAll()
    }
    
    // MARK: Firebase debug setup
    private func firebaseDebugSetup() {
        // Enable Firebase Analytics debug mode for non production environments
        // Idea taken from: https://stackoverflow.com/a/47594030/6947225
        if Environment.type != .production {
            var args = ProcessInfo.processInfo.arguments
            args.append("-FIRAnalyticsDebugEnabled")
            ProcessInfo.processInfo.setValue(args, forKey: "arguments")
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // Show system notification
        completionHandler([.list, .banner, .badge, .sound])
    }
}

extension AppDelegate: NetworkProviderDelegate {
    func didReceiveHttpUnauthorized() {
        self.flowController?.handleLogout()
    }
}
