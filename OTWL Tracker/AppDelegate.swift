//
//  AppDelegate.swift
//  OTWL Tracker
//
//  Created by Sanjay Mali on 13/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import UserNotifications
import FirebaseMessaging
import FirebaseInstanceID
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
//    let realmService = RealmService()
    
    var userDefaultDetails = UserDefaultDetails()
    var navigationControllers = NavigationControllers()
    var notifications = Notifications()
    let kUserDefault = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navStyles = UINavigationBar.appearance()
        // This will set the color of the text for the back buttons.
        navStyles.tintColor = .white
        // This will set the background color for navBar
        //        navStyles.barTintColor = .black
        UIApplication.shared.statusBarStyle = .lightContent
        //        let app = AppColor()
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        //        Messaging.messaging().delegate = self
        registerForPushNotifications()
        NotificationCenter.default.addObserver(self, selector:#selector(self.refreshToken(notification:)), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        UITabBar.appearance().barTintColor = UIColor.white
        let attributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 20)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        if userDefaultDetails.isloggedIn() == true{
            self.navigationControllers.navigateTabbar()
        }else{
            self.navigationControllers.navigateSignIn()
        }
        return true
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                
            }
        }
        
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        let userDefaultDetails = UserDefaultDetails()
        userDefaultDetails.saveDeviceToken(deviceToken:token)
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        //        print(userInfo)
        let aps = userInfo["aps"]!
        let jsonResult = aps as! Dictionary<String, AnyObject>
        print("jsonResult:\(jsonResult)")
        let alert = jsonResult["alert"]
        print(alert!)
        let title = alert!["title"]
        let body = alert!["body"]
        print(title!!,body!!)
        
    
//        notifications.body = body! as! String
//        notifications.title = title! as! String
//        appDelrealm.beginWrite()

//        var notificationData = NSMutableDictionary()
//        kUserDefault.setValue(alert, forKey: "kNOTIFICATION_LIST")
//        kUserDefault.synchronize()
        let tab = UITabBarController()
        tab.selectedIndex = 0
//        notifications.writeNotifications()
        completionHandler(UIBackgroundFetchResult.newData)
        
    }
    //Firebase
    
    
    @objc  func refreshToken(notification:NSNotification){
        let refreshToken = InstanceID.instanceID().token()
        print("refreshToken: \(refreshToken!)")
        let userDefaultDetails = UserDefaultDetails()
        userDefaultDetails.saveFirebaseDeToken(deviceToken:refreshToken!)
        FirebaseHandler()
    }
    func FirebaseHandler(){
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Messaging.messaging().shouldEstablishDirectChannel = false
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FirebaseHandler()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "OTWL_Tracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

