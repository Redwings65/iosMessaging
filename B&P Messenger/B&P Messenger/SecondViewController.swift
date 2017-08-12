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

var group = String()

class SecondViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var ref: DatabaseReference!
    
    @IBOutlet weak var tableView1: UITableView?
    @IBOutlet weak var createRoom: UITextField?

    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView1?.delegate = self
        tableView1?.dataSource = self
        observeChatRooms()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func createRoomButton(_ sender: AnyObject) {
        Database.database().reference().child((createRoom?.text!)!).setValue(["MyDatabase : 1234"])
        list.append((createRoom?.text)!)
        print(createRoom?.text)
        DispatchQueue.main.async(execute: { () -> Void in
            self.tableView1?.reloadData()
        })
    }
    
    func observeChatRooms(){
        Database.database().reference().observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot{
                    print(snap.key)
                    self.list.append(snap.key)
                }
                
                DispatchQueue.main.async {
                    self.tableView1?.reloadData()
                }
            
            }
        })

    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
                return list.count
        
        }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        cell.textLabel?.text = self.list[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        group = self.list[indexPath.row]
        self.performSegue(withIdentifier: "segue2", sender: self)
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}








