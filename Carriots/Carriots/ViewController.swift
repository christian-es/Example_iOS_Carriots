//
//  ViewController.swift
//  Carriots
//
//  Created by Christian on 18/2/16.
//  Copyright © 2016 None. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet var UILabelStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func UIButtonAction(sender: UIButton) {
        var action : String
        
        switch sender.tag {
        case 1:
            action = "ON"
        case 2:
            action = "OFF"
        case 3:
            action = "BLINK"
        default:
            action = "ERROR"
        }
        
        UILabelStatus.text = action
        
        let apikey = "YOUR APIKEY HERE"
        let device = "YOUR DEVICE's ID_DEVELOPER HERE"
        
        var data: Dictionary<String, AnyObject>
        
        data = ["value": action]
        
        let carriots = Carriots(api_key: apikey, device: device)
        
        carriots.send_stream(data)
    }
    
}

