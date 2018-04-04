//
//  LogInViewController.swift
//  SkydiveBook
//
//  Created by Guillaume Gutkin-Nicolas on 3/5/18.
//  Copyright © 2018 Guillaume Gutkin-Nicolas. All rights reserved.
//
//creates a keychain item
 //KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil]
//saves keychain item
//[keychainItem setObject:@"username you are saving" forKey:kSecAttrAccount];
//gets keychain item
//NSString *username = [keychainItem objectForKey:kSecAttrAccount];
//deletes keychain item for log off button
//[keychainItem resetKeychainItem];
import UIKit;


class LogInViewController: UIViewController {
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func registerButton(_ sender: UIButton) {
         self.performSegue(withIdentifier: "registerView", sender: nil)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let username = usernameTxtField.text
        let password = passwordTxtField.text

        //Grab storred values from MAMP
        let myUrl = URL(string: "http://localhost:8888/registration/userLogin.php")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        
        //a String of what will be sent to the 'user' table
        let serverString = "username=\(username!)&password=\(password!)"
        
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
                print("result: \(status!)");
                
                if (status! != "Success") {
                    DispatchQueue.main.async {
                        let myMessage = UIAlertController(title: status, message: message, preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                        myMessage.addAction(okAction)
                        self.present(myMessage, animated:true, completion: nil)
                    }
                }
                    
                else
                {
                    DispatchQueue.main.async {
                        let myMessage = UIAlertController(title: status, message: message, preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                        {
                            //action in self.dismiss(animated: true, completion: nil)
                            action in self.performSegue(withIdentifier: "loginView", sender: nil)
                        }
                        myMessage.addAction(okAction)
                        self.present(myMessage, animated:true, completion: nil)
                    }
                }
            }
        }
        task.resume()
    }
}