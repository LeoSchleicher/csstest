//
//  AppDelegate.swift
//  csstest
//
//  Created by Leonid Schleicher on 10.10.17.
//  Copyright © 2017 Monks. All rights reserved.
//

import UIKit
import CSSParser

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("ok. let's begin")
        if let filepath = Bundle.main.path(forResource: "test", ofType: "css") {
            do {
                let contents = try String(contentsOfFile: filepath)
                print(contents)
                let sheet = StyleSheet(string: contents)!
                let elt = ThemeElement()
                elt.tagName = "view"
                let styles = sheet.stylesForElement(elt)
                for e in styles {
                    print("got style \(e.key) : \(e.value.value)")
                }
            } catch {
                // contents could not be loaded
                print("e #1")
            }
        } else {
            print("e #2")
        }
        
        
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


}

@objc public class ThemeElement: NSObject, StyleElement {
    public func equals(_ other: StyleElement) -> Bool {
        return true
    }
    
    public weak var view:UIView?
    
    public var id: String?
    public var classNames: [String]?
    public var tagName: String?
    public var parentElement: StyleElement?
    public var childElements: [StyleElement]?
    public var attributes: [String: String]?
    public var styles: [String: Any]?
    
    public var stylesDeclaration:String?
    
    public var isEnabled: Bool
    public var isFocused: Bool
    public var isSelected: Bool
    public var isActive: Bool
    
    public init(id: String? = nil, classNames: [String]? = nil, tagName: String? = nil, parent: StyleElement? = nil, children: [StyleElement]? = nil, attributes: [String: String]? = nil) {
        self.id = id
        self.classNames = classNames
        self.tagName = tagName
        self.parentElement = parent
        self.childElements = children
        self.attributes = attributes
        isEnabled = true
        isFocused = false
        isSelected = false
        isActive = false
    }
    

    
    public func has(attribute: String, with value: String) -> Bool {
        return attributes?[attribute] == value
    }
    
    
    public func apply(styles: [String : Any]) {
        self.styles = styles
    }
}

