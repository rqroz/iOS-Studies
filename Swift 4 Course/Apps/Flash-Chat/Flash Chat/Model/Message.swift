//
//  Message.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-01.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

class Message {
    //TODO: Messages need a messageBody and a sender variable
    let sender: String
    let body: String
    
    init(sender: String, body: String) {
        self.sender = sender
        self.body = body
    }
    
}
