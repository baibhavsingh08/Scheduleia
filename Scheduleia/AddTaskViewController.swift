//
//  AddTaskViewController.swift
//  Scheduleia
//
//  Created by Raramuri on 18/07/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddTaskViewController: UIViewController {
    
    let db = Firestore.firestore()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateSelector: UIDatePicker!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var headingLabel: UITextField!
    
    @IBOutlet weak var priorityButton: UIButton!
    var taskPriority = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(db)
        
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        
        
        
        let highPriority = UIAction(title: "High") { _ in
            self.taskPriority = 2
            self.priorityButton.backgroundColor = .red
            self.imageView.backgroundColor = .red
        }
        
        let mediumPriority = UIAction(title: "Medium") { _ in
            self.taskPriority = 1
            self.priorityButton.backgroundColor = .yellow
            
            self.imageView.backgroundColor = .yellow

        }
        
        let lowPriority = UIAction(title: "Low") { _ in
            self.taskPriority = 0
            self.priorityButton.backgroundColor = .blue
            self.imageView.backgroundColor = .blue

        }
        
        let menu = UIMenu(title: "", children: [lowPriority,mediumPriority,highPriority])
        
        priorityButton.menu = menu
        priorityButton.showsMenuAsPrimaryAction = true

    }
    
    @IBAction func saveTask(_ sender: Any) {
        if let msgHeading = headingLabel?.text, !msgHeading.isEmpty, let msgDescription = descriptionLabel?.text, let msgDeadline = dateSelector?.date,  let msgSender = Auth.auth().currentUser?.email{
            
            let msgDate = Date().timeIntervalSince1970
            
            let date = msgDeadline
            let dateFormatter = DateFormatter()
                    
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
            

            db.collection("todoData").addDocument(data: ["decription": msgDescription,
                                                         "heading": msgHeading,
                                                         "deadline": dateString,
                                                         "priority": taskPriority,
                                                         "email": msgSender,
                                                         "isDone": false,
                                                  "time": msgDate] , completion: nil)
            print("in")
        
        }else{
            print("err")
        }
        navigationController?.popViewController(animated: true)
    }
}
