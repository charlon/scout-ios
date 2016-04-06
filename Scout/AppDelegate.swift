//
//  AppDelegate.swift
//  Scout
//
//  Created by Charlon Palacay on 4/5/16.
//  Copyright © 2016 Charlon Palacay. All rights reserved.
//

import UIKit
import Turbolinks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    //var navigationController = UINavigationController()
    var session = Session()
    
    // Set up the first View Controller
    var vc1 = UINavigationController()
    // Set up the second View Controller
    var vc2 = UINavigationController()
    
    var tabBarController = UITabBarController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        vc1.view.backgroundColor = UIColor.orangeColor()
        vc1.tabBarItem.title = "Orange"
        vc1.tabBarItem.image = UIImage(named: "heart")
        
        vc2.view.backgroundColor = UIColor.purpleColor()
        vc2.tabBarItem.title = "Purple"
        vc2.tabBarItem.image = UIImage(named: "star")
        
        // Set up the Tab Bar Controller to have two tabs
        
        tabBarController.viewControllers = [vc1, vc2]
        
        // Make the Tab Bar Controller the root view controller
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        // old rootview controller
        //window?.rootViewController = navigationController
        
        startApplication()
        
        return true
    }
    
    func startApplication() {
        session.delegate = self
        visit(NSURL(string: "http://curry.aca.uw.edu:8001/h/")!)
    }
    
    func visit(URL: NSURL) {
        let visitableViewController = VisitableViewController(URL: URL)
        vc1.pushViewController(visitableViewController, animated: true)
        session.visit(visitableViewController)
    }
    
}


extension AppDelegate: SessionDelegate {
    func session(session: Session, didProposeVisitToURL URL: NSURL, withAction action: Action) {
        visit(URL)
    }
    
    func session(session: Session, didFailRequestForVisitable visitable: Visitable, withError error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        vc1.presentViewController(alert, animated: true, completion: nil)
    }
}