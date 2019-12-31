//
//  InterfaceController.swift
//  myWatchApp Extension
//
//  Created by Rafael Ferraz on 12/31/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    @IBOutlet var label: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if(WCSession.isSupported()){
         let session = WCSession.default;
         session.delegate = self;
         session.activate();
        }
        
        label.setText("")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        self.label.setText(message["counter"] as! String)
    }

}
