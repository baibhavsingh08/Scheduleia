//
//  TodoModel.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

struct TodoModel{

    var decription: String = "hii"
    var heading: String = "hello"
    var deadline: String = "12:00"
    var priority: Int = 0
    var email: String
    
    init(decription: String, heading: String, deadline: String, priority: Int, email: String) {
        self.decription = decription
        self.heading = heading
        self.deadline = deadline
        self.priority = priority
        self.email = email
    }
    func toDictionary() -> [String: Any] {
            return [
                "decription": decription,
                "heading": heading,
                "deadline": deadline,
                "priority": priority,
                "email": email
            ]
    }
}
