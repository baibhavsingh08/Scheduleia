import UIKit
import FirebaseAuth
import FirebaseFirestore

class AllTaskMainViewController: UIViewController {
    
    let db = Firestore.firestore()
    var model = [TodoModel]()
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        tableView.delegate = self
        tableView.dataSource = self
        
        addButton.layer.cornerRadius = addButton.frame.size.width/4
        addButton.clipsToBounds = true
        
        tableView.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        navigationItem.hidesBackButton = true
        loadTodoData()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("Hello")
    }
    
    func loadTodoData() {
        
        db.collection("todoData").order(by: "time").addSnapshotListener({(QuerySnapshot,error) in
            self.model = []
            if((error) != nil) {
                print(error!)
            } else {
                if let docs = QuerySnapshot?.documents {
                    for doc in docs {
                        let data = doc.data()
                        
                        if let heading = data["heading"] as? String, let decription = data["decription"] as? String, let deadline = data["deadline"] as? String, let priority = data["priority"] as? Int, let email = data["email"] as? String {
                            let time = data["time"]  as? Int
                            
                            if(Auth.auth().currentUser?.email == email ){
                                let item = TodoModel(decription: decription, heading: heading, deadline: deadline, priority: priority, email: email, time: time ?? 0, id: data["id"]  as! String, isDone: (data["isDone"] as? Bool)! )
                                
                                self.model.append(item)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        })
    }
}

extension AllTaskMainViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "testVC")
        navigationController?.pushViewController(vc, animated: true)
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
        cell.deadlineLabel.text = (model[indexPath.row].deadline)
        
        return cell
    }
}

