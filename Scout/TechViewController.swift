//
//  TechViewController.swift
//  Scout
//
//  Created by Charlon Palacay on 7/14/16.
//  Copyright © 2016 Charlon Palacay. All rights reserved.
//

import UIKit
import WebKit
import Turbolinks

class TechViewController: UINavigationController {
    
    private let URL = NSURL(string: "https://scout-test.s.uw.edu/h/tech/")!    
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
        // Do any additional setup after loading the view, typically from a nib.
        
        presentVisitableForSession(session, URL: URL)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func presentVisitableForSession(session: Session, URL: NSURL, action: Action = .Advance) {
        let visitable = VisitableViewController(URL: URL)
        pushViewController(visitable, animated: true)
        session.visit(visitable)
    }
    
    
}

extension TechViewController: SessionDelegate {
    func session(session: Session, didProposeVisitToURL URL: NSURL, withAction action: Action) {
        if URL.path == "/numbers" {
            //presentNumbersViewController()
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