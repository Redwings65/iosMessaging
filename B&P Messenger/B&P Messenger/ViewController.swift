//
//  ViewController.swift
//  B&P Messenger
//
//  Created by Brandon Seager on 8/8/17.
//  Copyright © 2017 Brandon Seager. All rights reserved.
//

import UIKit
import Toast_Swift

var userName = ""
class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldUsername: UITextField!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func Button(_ sender: UIButton) {
        if(textField.text != ""){
            userName = textField.text!
            performSegue(withIdentifier: "segue1", sender: self)
        }
        else{
            //do something
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

