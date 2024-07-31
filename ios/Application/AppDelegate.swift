//
//  Created by Petr Chmelar on 16/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

#if ALPHA || BETA
import Atlantis
#endif

import DependencyInjection
import Factory
import KeychainProvider
import NetworkProvider
import OSLog
import SharedDomain
import UIKit
import UIToolkit
import UserDefaultsProvider
import Utilities
import WidgetKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var flowController: AppFlowController?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        setupEnvironment()
        
        // Clear keychain on first run
        clearKeychain()
        
        // Setup firebase for debug
        firebaseDebugSetup()
        
        // Setup Cache capacity
        setupCacheCapacity()
        
        // Register for remote notifications
        application.registerForRemoteNotifications()
        
        // Init main window with navigation controller
        let nc = BaseNavigationController()
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
        
        WidgetCenter.shared.reloadAllTimelines()
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
        do {
            let _: Bool = try Container.shared.userDefaultsProvider().read(.hasRunBefore)
        } catch UserDefaultsProviderError.valueForKeyNotFound {
            do {
                try Container.shared.keychainProvider().deleteAll()
                try Container.shared.userDefaultsProvider().update(.hasRunBefore, value: true)
            } catch {}
        } catch {}
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
    
    // MARK: Cache setup
    private func setupCacheCapacity() {
        URLCache.shared.memoryCapacity = 10_000_000 // ~10 MB memory space
        URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
    }
}
