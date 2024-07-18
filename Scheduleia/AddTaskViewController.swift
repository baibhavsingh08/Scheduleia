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

    @IBOutlet weak var dateSelector: UIDatePicker!
    @IBOutlet weak var prioritySlider: UISlider!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var headingLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveTask(_ sender: Any) {
        if let msgHeading = headingLabel?.text, !msgHeading.isEmpty, let msgDescription = descriptionLabel?.text, !msgDescription.isEmpty, let msgDeadline = dateSelector?.date, let priority = prioritySlider?.value, let msgSender = Auth.auth().currentUser?.email{
            
            let msgDate = Date().timeIntervalSince1970
            
            let date = msgDeadline
            let dateFormatter = DateFormatter()
                    
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
            
            let priorityValue = Int(priority.rounded())

            db.collection("todoData").addDocument(data: ["decription": msgDescription,
                                                         "heading": msgHeading,
                                                         "deadline": dateString,
                                                         "priority": priorityValue,
                                                         "email": msgSender,
                                                  "time": msgDate] , completion: nil)
            print("in")
        
        }else{
            print("err")
        }
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
