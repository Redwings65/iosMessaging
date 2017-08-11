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

    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        tableView1?.delegate = self
        tableView1?.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func createRoomButton(_ sender: AnyObject) {
        chatroom = createRoom?.text
        list.append((createRoom?.text)!)
        print(createRoom?.text)
        DispatchQueue.main.async(execute: { () -> Void in
            self.tableView1?.reloadData()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segue2", sender: self)
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}














