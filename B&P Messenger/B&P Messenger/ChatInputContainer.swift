//
//  ChatInputContainer.swift
//  B&P Messenger
//
//  Created by Brandon Seager on 8/12/17.
//  Copyright © 2017 Brandon Seager. All rights reserved.
//

import Foundation
import UIKit

class ChatInputContainerView: UIView, UITextFieldDelegate{
    
 var chatLogController: ThirdViewController? {
        didSet{
            sendBtn.addTarget(chatLogController, action: #selector(ThirdViewController.handleSend), for: .touchUpInside)
        }
    }
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder  = "Enter Message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        
        return textField
    }()
    
    
    let sendBtn: UIButton = {
        let sendBtn = UIButton(type: .system)
        sendBtn.setTitle("Send", for: .normal)
        sendBtn.translatesAutoresizingMaskIntoConstraints = false
        return sendBtn
    }()
    
    let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor =  UIColor.lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(sendBtn)
        
        sendBtn.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        sendBtn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sendBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendBtn.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        addSubview(self.inputTextField)
        
        self.inputTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
            self.inputTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            self.inputTextField.rightAnchor.constraint(equalTo: sendBtn.leftAnchor).isActive = true
            self.inputTextField.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
            
            addSubview(separator)
            
            separator.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            separator.topAnchor.constraint(equalTo: topAnchor).isActive = true
            separator.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
