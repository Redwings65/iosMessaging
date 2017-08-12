//
//  constants.swift
//  B&P Messenger
//
//  Created by Brandon Seager on 8/8/17.
//  Copyright © 2017 Brandon Seager. All rights reserved.
//

import Foundation
import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot
        //.child("test")
    }
}
