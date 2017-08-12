//
//  ThirdViewController.swift
//  B&P Messenger
//
//  Created by Brandon Seager on 8/10/17.
//  Copyright © 2017 Brandon Seager. All rights reserved.
//

import UIKit
import Firebase

class ThirdViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var messages = [Message]()
    
    lazy var inputContainer: ChatInputContainerView = {
        
        let chatInputContainer = ChatInputContainerView(frame: CGRect(x: 0, y: self.view.frame.height - 50, width: self.view.frame.width, height: 50))
        chatInputContainer.chatLogController = self
        return chatInputContainer
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(group)
        
        collectionView.register(ChatMessageCell.self, forCellWithReuseIdentifier: "cell")
        
        observeMessages()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func observeMessages(){
        Database.database().reference().child(group).observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                self.messages.removeAll()
                for snap in snapshot{
                    if let dictionary = snap.value as? [String:AnyObject]{
                        let message = Message()
                        message.message = dictionary["message"] as! String
                        message.name = dictionary["name"] as! String
                        print(message.message)
                        self.messages.append(message)
                    }
                }
                
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
            
        })
        
        
    }
    
    func postMessage(){
        Database.database().reference().child(group).childByAutoId()
            .setValue(["name" : userName, "message" : inputContainer.inputTextField.text!])
    }
    func setupUI(){
        view.addSubview(inputContainer)
    }
    
    
    private func setupCell(cell: ChatMessageCell, message: Message){
        
        
        if message.name == userName{
            //outgoing blue
            cell.bubbleView.backgroundColor = UIColor.blue
            cell.textView.textColor = .white
            
            cell.bubbleViewLeftAnchor?.isActive = false
            cell.bubbleViewRightAnchor?.isActive = true
            
            cell.nameLbl.isHidden = true
        }else{
            //incoming gray
            cell.bubbleView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
            cell.textView.textColor = .black
            cell.bubbleViewLeftAnchor?.isActive = true
            cell.bubbleViewRightAnchor?.isActive = false
            cell.nameLbl.isHidden = false

        }
        
    }
    
    
    
    func handleSend(gesture: UITapGestureRecognizer){
        postMessage()
        inputContainer.inputTextField.text = ""
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChatMessageCell
        
        
        
        cell.chatLogController = self
        let message = messages[indexPath.row]
        
        cell.message = message
        
        
        setupCell(cell: cell, message: message)
        
        cell.textView.text = message.message
        cell.nameLbl.text = message.name
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 80
        
        //get estimated height
        let message = messages[indexPath.item]
        if let text = messages[indexPath.item].message{
            height = estimateFrameForText(text: text).height + 20
        }
        
        
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: height)
    }
    
    private func estimateFrameForText(text: String)->CGRect{
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    
}

class ChatMessageCell: UICollectionViewCell {
    
    var message: Message?
    var chatLogController = ThirdViewController()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "sample text for now"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.backgroundColor = UIColor.clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = .white
        tv.isEditable = false
        return tv
    }()
    
    
    let nameLbl: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir Next", size: 10)
        lbl.backgroundColor = .clear
        lbl.textColor = .lightGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    static let blueColor = UIColor(red: 0.12, green: 0.54, blue: 0.96, alpha: 1.0)
    
    //set background
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = blueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleViewRightAnchor: NSLayoutConstraint?
    var bubbleViewLeftAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(bubbleView)
        addSubview(textView)
        addSubview(nameLbl)
        
        
        
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        bubbleViewRightAnchor?.isActive = true
        
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        //   bubbleViewLeftAnchor?.isActive = false
        
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        //x,y,w,h
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        nameLbl.bottomAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        nameLbl.leftAnchor.constraint(equalTo: bubbleView.leftAnchor).isActive = true
        nameLbl.widthAnchor.constraint(equalToConstant: 50)
        nameLbl.heightAnchor.constraint(equalToConstant: 12)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



