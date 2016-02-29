//
//  Carriots.swift
//  Carriots
//
//  Created by Christian on 18/2/16.
//  Copyright © 2016 None. All rights reserved.
//

import Foundation

class Carriots {
    let api_url = "http://api.carriots.com/streams"
    var api_key: String = ""
    var device: String = ""
    
    init(api_key: String, device: String){
        self.api_key = api_key
        self.device = device
    }
    
    func send_stream(payload: Dictionary<String, AnyObject>){
        let url = NSURL(string: api_url)
        let request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        
        request.addValue(self.api_key, forHTTPHeaderField: "carriots.apikey")
        
        do {
            let data = ["protocol":"v2", "device":self.device, "at":"now", "data":payload]
            let jsondata = try NSJSONSerialization.dataWithJSONObject(data, options: [])
            request.HTTPBody = jsondata
        } catch {
            print(error)
            request.HTTPBody = nil
        }
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            // handle error
            guard error == nil
                else
            {
                return
            }
            
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
            let json: NSDictionary?
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            } catch let dataError {
                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                print(dataError)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                // return or throw?
                return
            }
            
            // The JSONObjectWithData constructor didn't return an error. But, we should still
            // check and make sure that json has a value using optional binding.
            if let parseJSON = json {
                // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                let success = parseJSON["success"] as? Int
                print("Success: \(success)")
            }
            else {
                // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: \(jsonStr)")
            }
            
        })
        task.resume()
    }
}