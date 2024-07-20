//
//  ShowTaskViewController.swift
//  Scheduleia
//
//  Created by Raramuri on 19/07/24.
//

import UIKit

class ShowTaskViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var priority = 0

    var taskHeading: String?
    var taskDescription: String?
    var taskDeadline: String?
    var taskPriority: Int?
    var docId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = taskHeading
        descriptionLabel.text = taskDescription
        dateLabel.text = taskDeadline
        if let priority = taskPriority {
            switch priority {
            case 2:
                priorityLabel.text = "High"
            case 1:
                priorityLabel.text = "Medium"
            case 0:
                priorityLabel.text = "Low"
            default:
                priorityLabel.text = "Unspecified"
            }
            
           
        }
    }
    

    
    
    @IBAction func editTask(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "edit") as? AddTaskViewController
        
//        vc?.headingLabel.text = titleLabel.text
//        vc?.descriptionLabel.text = descriptionLabel.text
//        vc?.taskPriority = (priorityLabel.text) as? Int  ?? 1
        
        vc?.descriptionText = descriptionLabel.text
//        vc?.dateSelector = dateLabel.
        vc?.deadlineText = dateLabel.text
        vc?.headingText = titleLabel.text
        vc?.priorityText = priorityLabel.text
        vc?.cameFromShow = 1
        vc?.docId = docId
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
