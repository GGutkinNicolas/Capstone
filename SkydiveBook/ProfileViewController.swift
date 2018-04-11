//
//  ProfileViewController.swift
//  SkydiveBook
//
//  Created by Guillaume Gutkin-Nicolas on 4/11/18.
//  Copyright © 2018 Guillaume Gutkin-Nicolas. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var name: UILabel!
    @IBOutlet var tJumps: UILabel!
    @IBOutlet var tSport: UILabel!
    @IBOutlet var tBase: UILabel!
    @IBOutlet var tTandem: UILabel!
    @IBOutlet var tStudent: UILabel!
    @IBOutlet var tCutaway: UILabel!
    @IBOutlet var tWingsuit: UILabel!
    @IBOutlet var tDistance: UILabel!
    @IBOutlet var tTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "userNameKey")
        
        let myUrl = URL(string: "http://localhost:8888/registration/profilePage.php")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        
        let serverString = "username=\(username!)"
        request.httpBody = serverString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            //if there's an error print it out
            if(error != nil) {
                print("error: \(String(describing: error))")
                return
            }
            //grab the json messages from the php file
            let json =  try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
            //print out the message
            if let parseJSON = json {
                
                let message = parseJSON["message"] as? String
                let status = parseJSON["status"] as? String
                
                print("result: \(message!)")
                
                if (status! != "Success:") {
                    DispatchQueue.main.async {
                        let myMessage = UIAlertController(title: status, message: message, preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                        myMessage.addAction(okAction)
                        self.present(myMessage, animated:true, completion: nil)
                    }
                }
                    
                else
                {
                    self.name.text = parseJSON["name"] as? String
                    self.tJumps.text = parseJSON["tJumps"] as? String
                    self.tSport.text = parseJSON["tSport"] as? String
                    self.tBase.text = parseJSON["tBase"] as? String
                    self.tTandem.text = parseJSON["tTandem"] as? String
                    self.tStudent.text = parseJSON["tStudent"] as? String
                    self.tCutaway.text = parseJSON["tCutaway"] as? String
                    self.tWingsuit.text = parseJSON["tWingsuit"] as? String
                    self.tDistance.text = parseJSON["tFFD"] as? String
                    self.tTime.text = parseJSON["tFFT"] as? String
                }
            }
        }
        task.resume();
    }
    
    @IBAction func LogOutButton(_ sender: Any) {
        UserDefaults.standard.removePersistentDomain(forName: "userNameKey")
        self.performSegue(withIdentifier: "Logout", sender: nil)
    }
    

}
