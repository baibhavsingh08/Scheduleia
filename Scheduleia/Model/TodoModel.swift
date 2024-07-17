//
//  TodoModel.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

struct TodoModel{
    var userName: String = "abc"
    var password: String = "123"
    var decription: String = "hii"
    var heading: String = "hello"
    var deadline: String = "12:00"
    
    init(userName: String, password: String, decription: String, heading: String, deadline: String) {
        self.userName = userName
        self.password = password
        self.decription = decription
        self.heading = heading
        self.deadline = deadline
    }
}
