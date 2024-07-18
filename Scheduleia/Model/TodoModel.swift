//
//  TodoModel.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

import Foundation

struct TodoModel{

    var decription: String = "hii"
    var heading: String = "hello"
    var deadline: String = "12:00"
    var priority: Int = 0
    var email: String
    var time: Int
    
    init(decription: String, heading: String, deadline: String, priority: Int, email: String, time: Int) {
        self.decription = decription
        self.heading = heading
        self.deadline = deadline
        self.priority = priority
        self.email = email
        self.time = time
    }
}
