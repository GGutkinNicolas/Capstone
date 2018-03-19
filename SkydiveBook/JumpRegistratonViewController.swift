
import UIKit

class JumpRegistratonViewController: UIViewController {
    @IBOutlet weak var jumpNumTxtField: UITextField!
    @IBOutlet weak var jumpTypeTxtField: UITextField!
    @IBOutlet weak var dateTxtField: UITextField!
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var aircraftTxtField: UITextField!
    @IBOutlet weak var rigTxtField: UITextField!
    @IBOutlet weak var canopyTxtField: UITextField!
    @IBOutlet weak var exitAltTxtField: UITextField!
    @IBOutlet weak var depAltTxtField: UITextField!
    @IBOutlet weak var sWindTxtField: UITextField!
    @IBOutlet weak var dTargetTxtField: UITextField!
    @IBOutlet weak var wingsuitSwitch: UISwitch!
    @IBOutlet weak var cutawaySwitch: UISwitch!
    
  
    let datePicker = UIDatePicker()
    func createDatePicker() {
        //Allows you to pick only month/day/year
        datePicker.datePickerMode = .date;
        
        //Creates a toolbar
        let toolbar = UIToolbar();
        toolbar.sizeToFit();
        
        //Done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed));
        toolbar.setItems([doneButton], animated: false);
        dateTxtField.inputAccessoryView = toolbar;
        dateTxtField.inputView = datePicker;
    }
    @objc func donePressed() {
        //format
        let df = DateFormatter();
        df.dateStyle = .short;
        df.timeStyle = .none;
        
        dateTxtField.text = df.string(from: datePicker.date);
        self.view.endEditing(true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func submitButton(_ sender: Any) {
        let jumpNum = jumpNumTxtField.text;
        let jumpType = jumpTypeTxtField.text;
        let date = dateTxtField.text;
        let location = locationTxtField.text;
        let aircraft = aircraftTxtField.text;
        let rig = rigTxtField.text;
        let canopy = canopyTxtField.text;
        let exitAlt = exitAltTxtField.text;
        let depAlt = depAltTxtField.text;
        let sWind = sWindTxtField.text;
        let dTarget = dTargetTxtField.text;
        let wingsuit = wingsuitSwitch.isOn;
        let cutaway = cutawaySwitch.isOn;
        
        //Store the value into MAMP
        let myUrl = URL(string: "http://localhost:8888/registration/jumpRegister.php");
        var request = URLRequest(url: myUrl!);
        request.httpMethod = "POST";
        
        //a String of what will be sent to the 'jumpLog' table
        let serverString = "jumpNum=\(jumpNum!)&jumpType=\(jumpType!)&date=\(date!)&location=\(location!)&aircraft=\(aircraft!)&rig=\(rig!)&canopy=\(canopy!)&exitAlt=\(exitAlt!)&depAlt=\(depAlt!)&sWind=\(sWind!)&dTarget=\(dTarget!)&wingsuit=\(wingsuit)&cutaway=\(cutaway)";
        
        request.httpBody = serverString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            //if there's an error print it out
            if(error != nil) {
                print("error: \(String(describing: error))");
                return;
            }
            //grab the json messages from the php file
            let json =  try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject];
            //print out the message
            if let parseJSON = json {
                
                let message = parseJSON["message"] as? String;
                print("result: \(message!)");
                
                if (message! != "Success") {
                    DispatchQueue.main.async {
                        let myMessage = UIAlertController(title: "Warning:", message: message, preferredStyle: UIAlertControllerStyle.alert);
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                        {
                            action in self.dismiss(animated: true, completion: nil);
                        }
                        myMessage.addAction(okAction);
                        self.present(myMessage, animated:true, completion: nil);
                    }
                }
                
                if let result = message, result == "Success"
                {
                    DispatchQueue.main.async {
                        let myMessage = UIAlertController(title: "Congratulations:", message: message, preferredStyle: UIAlertControllerStyle.alert);
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                        {
                            action in self.dismiss(animated: true, completion: nil);
                        }
                        myMessage.addAction(okAction);
                        self.present(myMessage, animated:true, completion: nil);
                    }
                }
            }
        }
        task.resume();
    }
}


 


