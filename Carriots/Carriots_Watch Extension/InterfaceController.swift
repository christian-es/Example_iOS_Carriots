//
//  InterfaceController.swift
//  Carriots_Watch Extension
//
//  Created by Christian on 26/2/16.
//  Copyright © 2016 None. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var lblStatus: WKInterfaceLabel!
    
    let apikey = "YOUR APIKEY HERE"
    let device = "YOUR DEVICE's ID_DEVELOPER HERE"
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func btnON() {
        send_stream("ON")
    }
    
    @IBAction func btnOFF() {
        send_stream("OFF")
    }
    
    @IBAction func btnBLINK() {
        send_stream("BLINK")
    }
    
    
    func send_stream(action: String){
        var data: Dictionary<String, AnyObject>
        
        data = ["value": action]
        
        let carriots = Carriots(api_key: apikey, device: device)
        
        carriots.send_stream(data)
        lblStatus.setText("Status: \(action)")
        
    }
}
