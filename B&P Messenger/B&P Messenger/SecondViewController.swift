//
//  SecondViewController.swift
//  
//
//  Created by Brandon Seager on 8/8/17.
//
//

import UIKit
import Firebase
import FirebaseDatabase

class SecondViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var tableView1: UITableView?
    @IBOutlet weak var createRoom: UITextField?
    
    //var list = [String]()
    var list = ["BMW","Audi", "Volkswagen"]
    
    override func viewDidLoad() {//this is fine
        super.viewDidLoad()
        ref = Database.database().reference()
        tableView1?.delegate = self
        tableView1?.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {//this is only for closing keyboard
        //label?.text = userName
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createRoomButton(_ sender: AnyObject) {//UIButton
        //list.append(createRoom.text!)
        //self.tableView.reloadData()
        //list.insert(createRoom.text!, at: 0)
        //add your data into tables array from textField
        list.append((createRoom?.text)!)
        print(createRoom?.text)
        DispatchQueue.main.async(execute: { () -> Void in
            //reload your tableView
            self.tableView1?.reloadData()
        })
        
        //    createRoom?.resignFirstResponder()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return list.count
        //0 or list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        //cell.textLabel?.text = self.list[indexPath.row]
        
        //let cell = tableView1?.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.list[indexPath.row]
        return cell
    }
    
    
    
    
    
    
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
