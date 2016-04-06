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
    //var session = Session()
    
    // Set up the first View Controller
    var discoverNavigationController = UINavigationController()
    var discoverSession = Session()
    
    // Set up the second View Controller
    var foodNavigationController = UINavigationController()
    var foodSession = Session()
    
    var tabBarController = UITabBarController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // style the nav and tab bars
        discoverNavigationController.view.backgroundColor = UIColor.orangeColor()
        //discoverNavigationController.navigationBar.barTintColor = UIColor.greenColor()
        discoverNavigationController.tabBarItem.title = "Discover"
        discoverNavigationController.tabBarItem.image = UIImage(named: "heart")
        
        foodNavigationController.view.backgroundColor = UIColor.purpleColor()
        //foodNavigationController.navigationBar.barTintColor = UIColor.orangeColor()
        foodNavigationController.tabBarItem.title = "Places"
        foodNavigationController.tabBarItem.image = UIImage(named: "star")
        
        // Set up the Tab Bar Controller to have two tabs
        tabBarController.viewControllers = [discoverNavigationController, foodNavigationController]
        
        // Make the Tab Bar Controller the root view controller
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        // old rootview controller
        //window?.rootViewController = navigationController
        
        // TODO: figure out how to fire up correct  visitable view controllers based on which tab is clicked
        
        startApplication()
        
        return true
    }
    
    func startApplication() {
        visitFood(NSURL(string: "http://curry.aca.uw.edu:8001/h/food/")!)
        visitDiscover(NSURL(string: "http://curry.aca.uw.edu:8001/h/")!)
    }
    
    func visitFood(URL: NSURL) {
        foodSession.delegate = self
        let visitableViewController = VisitableViewController(URL: URL)
        foodNavigationController.pushViewController(visitableViewController, animated: true)
        foodSession.visit(visitableViewController)
    }
    
    func visitDiscover(URL: NSURL) {
        discoverSession.delegate = self
        let visitableViewController = VisitableViewController(URL: URL)
        discoverNavigationController.pushViewController(visitableViewController, animated: true)
        discoverSession.visit(visitableViewController)
    }
    
}

extension AppDelegate: SessionDelegate {
    
    func session(session: Session, didProposeVisitToURL URL: NSURL, withAction action: Action) {
        
        // TODO: figure out how to call only one function at a time
        
        visitDiscover(URL)
        visitFood(URL)
        
    }
    
    func session(session: Session, didFailRequestForVisitable visitable: Visitable, withError error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        // TODO: figure out how to only return one controller at a time
        
        discoverNavigationController.presentViewController(alert, animated: true, completion: nil)
        foodNavigationController.presentViewController(alert, animated: true, completion: nil)
    }
}
