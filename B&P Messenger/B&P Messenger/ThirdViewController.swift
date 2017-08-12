//
//  ThirdViewController.swift
//  B&P Messenger
//
//  Created by Brandon Seager on 8/10/17.
//  Copyright © 2017 Brandon Seager. All rights reserved.
//

import UIKit
import Atlas
import Firebase


class ThirdViewController: UIViewController {

    var messageTextView: UITextField = {
        let tf = UITextField(frame: CGRect(x: UIScreen.main.bounds.midX - UIScreen.main.bounds.width / 6.4 , y: UIScreen.main.bounds.height - UIScreen.main.bounds.width / 10.667 - UIScreen.main.bounds.width/20, width: UIScreen.main.bounds.width / 3.2, height: UIScreen.main.bounds.width / 10.667))
        
        tf.layer.cornerRadius = UIScreen.main.bounds.width / 50
        tf.backgroundColor = .red
        tf.layer.masksToBounds = true
        
        return tf
    }()
    
    
    var messages = [Message]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(group)

        
        setupUI()

        
    }

    
    func observeMessages(){
        Database.database().reference().child(group).observe(.childAdded, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot{
                    if let dictionary = snap.value as? [String:AnyObject]{
                    let message = Message()
                    message.message = dictionary["message"] as! String
                    message.name = dictionary["name"] as! String
                    self.messages.append(message)
                    }
                }

            }
        })

    }
    
    func postMessage(){
        print("Click")
        print("username")
        print(messageTextView.text)
        Database.database().reference().child(group).childByAutoId()
            .setValue(["name" : userName, "message" : (messageTextView.text)!])
    }
    func setupUI(){
        view.addSubview(messageTextView)
        
    }
    
    @IBAction func postBtnClick(_ sender: Any) {
        if messageTextView.text == ""{
            print("Enter text")
        }else{
            self.postMessage()
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


