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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    @IBAction func editTask(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "edit") as? AddTaskViewController
        
//        vc?.headingLabel.text = titleLabel.text
//        vc?.descriptionLabel.text = descriptionLabel.text
//        vc?.taskPriority = (priorityLabel.text) as? Int  ?? 1
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
