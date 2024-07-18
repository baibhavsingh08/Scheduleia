import UIKit
import FirebaseAuth
import FirebaseFirestore


class TodayMainViewController: UIViewController {
    
    let db = Firestore.firestore()
    var model = [TodoModel]()
    
    var textField1: UITextField!
       var textField2: UITextField!
       var textField3: UITextField!
    
    var vc: UIViewController! = nil
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Today's Tasks"
        navigationItem.hidesBackButton = true
        
//        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.frame = view.bounds
        addButton.layer.cornerRadius = addButton.frame.size.width/4
        addButton.clipsToBounds = true
        
//        tableView.backgroundColor = UIColor.lightGray
        

        
        tableView.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        loadTodoData()
    }
    
    func loadTodoData(){
        
        db.collection("todoData").order(by: "time").addSnapshotListener({(QuerySnapshot,error) in
            self.model = []
            if((error) != nil){
                print(error!)
                print("no")
            }else{
                if let docs = QuerySnapshot?.documents {
                    for doc in docs{
                        let data = doc.data()
                        
                        
                       if let heading = data["heading"] as? String, let decription = data["decription"] as? String, let deadline = data["deadline"] as? String, let priority = data["priority"] as? Int, let email = data["email"] as? String {
                           let time = data["time"]  as? Int
                           
                           
                           let item = TodoModel(decription: decription, heading: heading, deadline: deadline, priority: priority, email: email, time: time ?? 0  )
                           
                           self.model.append(item)
                           
                           DispatchQueue.main.async {
                               self.tableView.reloadData()
                           }
                        }
                    }
                }
            }
        })
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
   
         let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         vc = storyBoard.instantiateViewController(identifier: "testVC")

        
         textField1 = createTextField()
        
        textField1.frame = CGRect(x: 100, y: 100, width: 300, height: 60)

        vc.view.addSubview(textField1)

         textField2 = createTextField()
        
        textField2.frame = CGRect(x: 100, y: 200, width: 300, height: 60)

        vc.view.addSubview(textField2)
        
        textField3 = createTextField()
        
        textField3.frame = CGRect(x: 100, y: 300, width: 300, height: 60)

        vc.view.addSubview(textField3)
        
        
        let button = UIButton()
        button.setTitle("Add Task", for: .normal)
        button.backgroundColor = .systemBlue
        
        button.frame = CGRect(x: 100, y: 600, width: 300, height: 60)

        vc.view.addSubview(button)
        button.addTarget(self, action: #selector(saveDataToFirebase), for: .touchUpInside)

        
//        navigationController?.pushViewController(vc, animated: true)
//        tableView.reloadData()
    }
    
    func createTextField()->UITextField{
        let textField = UITextField()
        textField.placeholder = "Enter text here"
        textField.textColor = .black
        textField.backgroundColor = .white
        return textField
    }
    
    @objc func saveDataToFirebase(){
        print("hello")
        
        
        if let msgHeading = textField1?.text, !msgHeading.isEmpty, let msgDescription = textField2?.text, !msgDescription.isEmpty, let msgDeadline = textField3?.text, !msgDeadline.isEmpty, let msgSender = Auth.auth().currentUser?.email{
            
            let msgDate = Date().timeIntervalSince1970

            db.collection("todoData").addDocument(data: ["decription": msgDescription,
                                                         "heading": msgHeading,
                                                         "deadline": msgDeadline,
                                                         "priority": 1,
                                                         "email": msgSender,
                                                  "time": msgDate] , completion: nil)
            print("in")
        
        }else{
            print("err")
        }
        navigationController?.popViewController(animated: true)
    }
}



extension TodayMainViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "testVC")
        navigationController?.pushViewController(vc, animated: true)
        
//        model.remove(at: indexPath.row)
//        
//        DispatchQueue.main.async {
//            tableView.reloadData()
//        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let model  = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoItemTableViewCell
    
        switch model[indexPath.row].priority {
            
        case 0 :
            cell.leftImage.image = UIImage(named: "leastPriority")
            cell.colorLabel.backgroundColor = .blue
            
        case 1:
            cell.leftImage.image = UIImage(named: "mediumPriority")
            cell.colorLabel.backgroundColor = .yellow

        case 2:
            cell.leftImage.image = UIImage(named: "highestPriority")
            cell.colorLabel.backgroundColor = .red

        default:
            cell.leftImage.image = UIImage(named: "leastPriority")
            cell.colorLabel.backgroundColor = .blue

        }

        cell.descriptionLabel.text = model[indexPath.row].decription
        cell.headingLabel.text = model[indexPath.row].heading
        cell.deadlineLabel.text = (model[indexPath.row].deadline)
        
//        cell.colorLabel.backgroundColor = .red
//        cell.description = model[indexPath.row].decription
        
        return cell
    }
    
//
}
