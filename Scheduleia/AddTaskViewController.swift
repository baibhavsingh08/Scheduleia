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
        dateFormatter.dateFormat = "dd MMMM yy HH:mm a"
        
        if let deadlineText, let dateInDate = dateFormatter.date(from: deadlineText) {
            dateSelector.setDate(dateInDate, animated: true)
        }
                
        if let priorityText {
            switch priorityText {
            case "Low":
                taskPriority = 0
                imageView.backgroundColor = .blue
                
            case "Medium":
                taskPriority = 1
                imageView.backgroundColor = .yellow
                            
            case "High":
                taskPriority = 2
                imageView.backgroundColor = .red
                                
            default:
                taskPriority = 0
                imageView.backgroundColor = .blue
            }
        }
        
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
    
        let highPriority = UIAction(title: "High") { _ in
            self.taskPriority = 2
            self.imageView.backgroundColor = .red
        }
        
        let mediumPriority = UIAction(title: "Medium") { _ in
            self.taskPriority = 1
            self.imageView.backgroundColor = .yellow
        }
        
        let lowPriority = UIAction(title: "Low") { _ in
            self.taskPriority = 0
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
                    if viewControllerName != "TodayMainViewController" && viewControllerName != "MainTabBarController"{
                        navigationController.popViewController(animated: true)
                    } else {
                        navigationController.popToViewController(targetViewController, animated: true)
                    }
                } else {
                    navigationController.popViewController(animated: true)
                }
            }
        } else {
            if let msgHeading = headingLabel?.text, !msgHeading.isEmpty, let msgDescription = descriptionLabel?.text, let msgDeadline = dateSelector?.date,  let msgSender = Auth.auth().currentUser?.email{
                
                let msgDate = Date().timeIntervalSince(msgDeadline)
                let date = msgDeadline
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "dd MMMM yy HH:mm a"
                let dateString = dateFormatter.string(from: date)
                
                if(msgDate <= 0){
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
                } else {
                    let alert = UIAlertController(title: "Error", message: "Select a date that is not passed", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
                
            } else {
                let alert = UIAlertController(title: "Error", message: "Heading is not optional", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                
                alert.addAction(action)
                self.present(alert, animated: true)
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateData(_ id: String) {
        guard  let htext = headingLabel.text, !htext.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Heading must not be empty", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alert.addAction(action)
            self.present(alert, animated: true)
            return
        }
        
        let msgDate = Date().timeIntervalSince(self.dateSelector.date)
        let date = dateSelector.date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd MMMM yy HH:mm a"
        let dateString = dateFormatter.string(from: date)
        
        if msgDate <= 0{
            db.collection("todoData").document(id).updateData(["id": id,
                                                               "decription": self.descriptionLabel.text!,
                                                               "heading": self.headingLabel.text!,
                                                               "deadline": dateString,
                                                               "priority": self.taskPriority,
                                                               "email": Auth.auth().currentUser?.email ?? "",
                                                               "isDone": isDone!,
                                                               "time": msgDate]) { error in
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Select a date that is not passed", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
}
