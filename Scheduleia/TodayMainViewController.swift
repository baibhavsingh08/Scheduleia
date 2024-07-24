import UIKit
import FirebaseAuth
import FirebaseFirestore

class TodayMainViewController: UIViewController {
    var model = [TodoModel]()
    let db = Firestore.firestore()
    
    var vc: UIViewController! = nil
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Today's Tasks"
        navigationItem.hidesBackButton = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        addButton.layer.cornerRadius = addButton.frame.size.width/4
        addButton.clipsToBounds = true
        
        tableView.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        loadTodoData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTodoData()
    }
    
    func loadTodoData(){
        db.collection("todoData").order(by: "time", descending: true).addSnapshotListener({(QuerySnapshot,error) in
            self.model = []
            
            if(error != nil) {
                print(error!)
            }else {
                if let docs = QuerySnapshot?.documents {
                    for doc in docs{
                        let data = doc.data()
                        
                        if let heading = data["heading"] as? String, let decription = data["decription"] as? String, let deadline = data["deadline"] as? String, let priority = data["priority"] as? Int, let email = data["email"] as? String {
                            let time = data["time"]  as? Int
                            
                            if(Auth.auth().currentUser?.email == email ){
                                let item = TodoModel(decription: decription, heading: heading, deadline: deadline, priority: priority, email: email, time: time ?? 0, id: (data["id"] as? String) ?? "" , isDone: (data["isDone"] as? Bool) ?? false)
                                
                                self.model.append(item)
                            }
                            self.model.sort { (item1, item2) -> Bool in
                                if item1.isDone == item2.isDone{
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd MMMM yy | HH:mm a"
                                    let date1 = dateFormatter.date(from: item1.deadline) ?? Date()
                                    let date2 = dateFormatter.date(from: item2.deadline) ?? Date()
                                    return date1 < date2
                                }
                                return !item1.isDone && item2.isDone
                            }
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        })
        let x = model.sorted{$0.deadline < $1.deadline}
        model = x
    }
}

extension TodayMainViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "testVC") as? ShowTaskViewController
        let task = model[indexPath.row]
        
        vc?.taskHeading = task.heading
        vc?.taskDescription = task.decription
        vc?.taskDeadline = task.deadline
        vc?.taskPriority = task.priority
        vc?.docId = task.id
        vc?.isDone = task.isDone
        
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoItemTableViewCell
        
        switch model[indexPath.row].priority {
        case 0 :
            cell.colorLabel.backgroundColor = .blue
            
        case 1:
            cell.colorLabel.backgroundColor = .yellow
            
        case 2:
            cell.colorLabel.backgroundColor = .red
            
        default:
            cell.colorLabel.backgroundColor = .blue
        }
        
        cell.descriptionLabel.text = model[indexPath.row].decription
        cell.headingLabel.text = model[indexPath.row].heading
        cell.deadlineLabel.text = model[indexPath.row].deadline
        
        cell.button.setImage(UIImage(systemName: "square"), for: .normal)
        cell.button.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        
        if(model[indexPath.row].isDone == true) {
            cell.button.isSelected = true
        } else {
            cell.button.isSelected = false
        }
        
        cell.docId = model[indexPath.row].id
        cell.isDone = model[indexPath.row].isDone
        cell.priority = model[indexPath.row].priority
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = model[indexPath.row]
            let docId = task.id
            
            let confirm = UIAlertController(title: "Are you sure, You want to Delete?", message: nil, preferredStyle: .alert)
            confirm.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {
                _ in
                self.db.collection("todoData").document(docId).delete { error in
                    if let error = error {
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                        
                        alert.addAction(action)
                        self.present(alert, animated: true)
                    } else {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }))
            confirm.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            self.present(confirm,animated: true)
            
        }
    }
}

extension TodayMainViewController: DeleteTodoItemFromTable {
    
    func taskCompleted(_ cell: TodoItemTableViewCell) {
        guard let docId = cell.docId , let isDone = cell.isDone else { return }
        
        db.collection("todoData").document(docId).updateData([
            "isDone": !isDone ]
        ) { error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                
                alert.addAction(action)
                self.present(alert, animated: true)
            } else {
                DispatchQueue.main.async {
                    self.loadTodoData()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func editCell(_ cell: TodoItemTableViewCell) {
        var stringPriority: String
        
        switch cell.priority{
        case 2:
            stringPriority = "High"
        case 1:
            stringPriority = "Medium"
        case 0:
            stringPriority = "Low"
        default:
            stringPriority = "Unspecified"
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "edit") as? AddTaskViewController
        
        vc?.descriptionText = cell.descriptionLabel.text
        vc?.deadlineText = cell.deadlineLabel.text
        vc?.headingText = cell.headingLabel.text
        vc?.priorityText = stringPriority
        vc?.cameFromShow = 1
        vc?.docId = cell.docId
        vc?.isDone = cell.isDone
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
