//
//  FoodViewController.swift
//  Scout
//
//  Created by Charlon Palacay on 4/6/16.
//  Copyright © 2016 Charlon Palacay. All rights reserved.
//

import UIKit
import WebKit
import Turbolinks

class FoodViewController: UINavigationController {
    
    private let URL = NSURL(string: "http://curry.aca.uw.edu:8001/h/food/")!    
    private let webViewProcessPool = WKProcessPool()
    
    private var application: UIApplication {
        return UIApplication.sharedApplication()
    }
    
    private lazy var webViewConfiguration: WKWebViewConfiguration = {
        let configuration = WKWebViewConfiguration()
        //configuration.userContentController.addScriptMessageHandler(self, name: "turbolinksDemo")
        configuration.processPool = self.webViewProcessPool
        configuration.applicationNameForUserAgent = "TurbolinksDemo"
        return configuration
    }()
    
    private lazy var session: Session = {
        let session = Session(webViewConfiguration: self.webViewConfiguration)
        session.delegate = self
        return session
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentVisitableForSession(session, URL: URL)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func presentVisitableForSession(session: Session, URL: NSURL, action: Action = .Advance) {
        let visitable = VisitableViewController(URL: URL)
        
        if action == .Advance {
            pushViewController(visitable, animated: true)
        } else if action == .Replace {
            popViewControllerAnimated(true)
            pushViewController(visitable, animated: false)
            //TODO: try doing a slide up instead...
            //presentViewController(authNavigationController, animated: true, completion: nil)
        }
        
        session.visit(visitable)
    }
    
    private func presentFoodFilterViewController() {
        //TODO 1: slide this new controller from the bottom (present.. not push)
        //let viewController = FoodFilterViewController()
        //presentViewController(viewController, animated: true, completion: nil)
        
        // TODO 2: trying similar to auth controller example
        let authenticationController = FoodFilterViewController()
        //authenticationController.delegate = self
        authenticationController.webViewConfiguration = webViewConfiguration
        authenticationController.URL = URL.URLByAppendingPathComponent("filter")
        authenticationController.title = "Filter Food"
        
        let authNavigationController = UINavigationController(rootViewController: authenticationController)
        presentViewController(authNavigationController, animated: true, completion: nil)
        
    }


}

extension FoodViewController: SessionDelegate {
    func session(session: Session, didProposeVisitToURL URL: NSURL, withAction action: Action) {
        if URL.path == "/h/food/filterxxxx" {
            presentFoodFilterViewController()
        } else {
            presentVisitableForSession(session, URL: URL, action: action)
        }
    }
    
    func session(session: Session, didFailRequestForVisitable visitable: Visitable, withError error: NSError) {
  
    }
    
    func sessionDidStartRequest(session: Session) {
        //application.networkActivityIndicatorVisible = true
    }
    
    func sessionDidFinishRequest(session: Session) {
        //application.networkActivityIndicatorVisible = false
    }
}