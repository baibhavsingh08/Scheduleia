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
    
    
    var descriptionText: String?
    var headingText: String?
    var priorityText: String?
    var deadlineText: String?
    var cameFromShow: Int?
    var docId: String?
    var isDone: Bool?
    
    var taskPriority = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let descriptionText  {
            descriptionLabel.text = descriptionText
        }
        if let headingText  {
            headingLabel.text = headingText
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yy hh-mm a"
        
        if let deadlineText, let dateInDate = dateFormatter.date(from: deadlineText) {
            dateSelector.date = dateInDate
        }
        
//        print(priorityText!)

        if let priorityText {
            switch priorityText {
            case "Low":
                taskPriority = 0
                imageView.backgroundColor = .blue
                priorityButton.backgroundColor = .blue
                print(0)
            case "Medium":
                taskPriority = 1
                imageView.backgroundColor = .yellow
                priorityButton.backgroundColor = .yellow
                print(0)


            case "High":
                taskPriority = 2
                imageView.backgroundColor = .red
                priorityButton.backgroundColor = .red
                print(0)


            default:
                taskPriority = 0
                imageView.backgroundColor = .blue
                priorityButton.backgroundColor = .blue
                print(0)
            }
        }

        
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
        if let id = docId {
            updateData(id)
            if let navigationController = self.navigationController {
                        let viewControllers = navigationController.viewControllers
                        let numberOfViewControllers = viewControllers.count
                        
                        if numberOfViewControllers >= 3 {
                            let targetViewController = viewControllers[numberOfViewControllers - 3]
                            let viewControllerName = String(describing: type(of: targetViewController))
                            print(viewControllerName)
                            if viewControllerName != "TodayMainViewController" && viewControllerName != "MainTabBarController"{
                                navigationController.popViewController(animated: true)

                            } else {
                                navigationController.popToViewController(targetViewController, animated: true)
                            }
                        } else {
                            // If less than three view controllers, just pop the current one
                            navigationController.popViewController(animated: true)
                        }
                    }
            
        } else {
            if let msgHeading = headingLabel?.text, !msgHeading.isEmpty, let msgDescription = descriptionLabel?.text, let msgDeadline = dateSelector?.date,  let msgSender = Auth.auth().currentUser?.email{
                
                let msgDate = Date().timeIntervalSince1970
                
                let date = msgDeadline
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                let dateString = dateFormatter.string(from: date)
                
                let newDoc = db.collection("todoData").document()
                newDoc.setData(["id": newDoc.documentID,
                                "decription": msgDescription,
                                "heading": msgHeading,
                                "deadline": dateString,
                                "priority": taskPriority,
                                "email": msgSender,
                                "isDone": false,
                                "time": msgDate,
                                "date": msgDeadline] , completion: nil)
                print("in")
                
            }else{
                print("err")
            }
            
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateData(_ id: String) {
        guard  let _ = headingLabel.text else {
                print("Missing fields for update")
                return
            }
            
        let documentRef = db.collection("todoData").document(id)

        let date = dateSelector.date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        documentRef.updateData(["id": id, 
                                "decription": self.descriptionLabel.text!,
                                "heading": self.headingLabel.text!,
                                "deadline": dateString,
                                "priority": self.taskPriority,
                                "email": Auth.auth().currentUser?.email ?? "",
                                "isDone": isDone!,
                                "time": Date().timeIntervalSince1970]) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                print("Document successfully updated")
            }
        }
        
                    
    }
    
    
    
}


