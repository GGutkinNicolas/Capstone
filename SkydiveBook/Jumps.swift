//
//  Jumps.swift
//  SkydiveBook
//
//  Created by Guillaume Gutkin-Nicolas on 4/9/18.
//  Copyright © 2018 Guillaume Gutkin-Nicolas. All rights reserved.
//
/*
import Foundation

class Jumps {
    
    var jumpNum: String
    var jumpType: String
    var date: String
    var location: String
    var aircraft: String
    var rig: String
    var canopy: String
    var exitAlt: String
    var depAlt: String
    var sWind: String
    var dTarget: String
    var wingsuit: String
    var cutaway: String
    
    //Initialize
    init(json: [String:Any] ) {
        self.jumpNum = json["jumpNum"] as! String
        self.jumpType = json["jumpType"] as! String
        self.date = json["date"] as! String
        self.location = json["location"] as! String
        self.aircraft = json["aircraft"] as! String
        self.rig = json["rig"] as! String
        self.canopy = json["canopy"] as! String
        self.exitAlt = json["exitAlt"] as! String
        self.depAlt = json["depAlt"] as! String
        self.sWind = json["sWind"] as! String
        self.dTarget = json["dTarget"] as! String
        self.wingsuit = json["wingsuit"] as! String
        self.cutaway = json["cutaway"] as! String
    }
    
    init(jumpNum: String, jumpType: String, date: String, location: String ,aircraft: String, rig: String, canopy: String, exitAlt: String, depAlt: String, sWind: String, dTarget: String, wingsuit: String, cutaway: String) {
        self.jumpNum = jumpNum
        self.jumpType = jumpType
        self.date = date
        self.location = location
        self.aircraft = aircraft
        self.rig = rig
        self.canopy = canopy
        self.exitAlt = exitAlt
        self.depAlt = depAlt
        self.sWind = sWind
        self.dTarget = dTarget
        self.wingsuit = wingsuit
        self.cutaway = cutaway
    }
    
    static func loadJumps(username: String) {
        //Store the value into MAMP
        let myUrl = URL(string: "http://localhost:8888/registration/logbookCell.php")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        
        //a String of what will be sent to the 'user' table
        let serverString = "username=\(username)"
        
        request.httpBody = serverString.data(using: String.Encoding.utf8)
        var jumps: [Jumps] = []
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            //if there's an error print it out
            if(error != nil) {
                print("error: \(String(describing: error))")
                return
            }
            //grab the json messages from the php file
            if let json =  try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
            //print out the message
                for case let result in json! {
                    jumps.append(Jumps(json: result))
                }
            }
        }
        task.resume()
    
    }
}
*/
