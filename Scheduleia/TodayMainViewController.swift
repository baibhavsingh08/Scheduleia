//
//  TodayMainViewController.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

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
    
    @IBOutlet weak var tableView: UITableView!
    
//    let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }()
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...10{
            model.append(TodoModel(decription: "aa", heading: "aa", deadline: "aa", priority: 1, email: "Asasaa"))
        }

        title = "Today's Tasks"
        navigationItem.hidesBackButton = true
        
//        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.frame = view.bounds
        
        let button = UIButton()
        button.setTitle("Add Task", for: .normal)
        button.backgroundColor = .systemBlue
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
                
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        if let tabBarHeight = tabBarController?.tabBar.frame.size.height {
                    button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(50 + tabBarHeight)).isActive = true
                }
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
        
//        tableView.backgroundColor = UIColor.lightGray
        

        
        tableView.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    @objc func buttonPressed(){
         let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         vc = storyBoard.instantiateViewController(identifier: "testVC")
        vc.navigationItem.title = "AAA"
        
//        let label = UILabel()
//        label.text = "Hii"
//        label.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
//        vc.view.addSubview(label)
        
         textField1 = UITextField()
        textField1.placeholder = "Enter text here"
        textField1.textColor = .black
        textField1.backgroundColor = .white
        textField1.frame = CGRect(x: 100, y: 100, width: 300, height: 60)

        vc.view.addSubview(textField1)

         textField2 = UITextField()
        textField2.placeholder = "Enter text here"
        textField2.textColor = .black
        textField2.backgroundColor = .white
        textField2.frame = CGRect(x: 100, y: 200, width: 300, height: 60)

        vc.view.addSubview(textField2)
        
         textField3 = UITextField()
        textField3.placeholder = "Enter text here"
        textField3.textColor = .black
        textField3.backgroundColor = .white
        textField3.frame = CGRect(x: 100, y: 400, width: 300, height: 60)

        vc.view.addSubview(textField3)
        
        
        let button = UIButton()
        button.setTitle("Add Task", for: .normal)
        button.backgroundColor = .systemBlue
        
        button.frame = CGRect(x: 100, y: 600, width: 300, height: 60)

        vc.view.addSubview(button)
        button.addTarget(self, action: #selector(saveDataToFirebase), for: .touchUpInside)

        
        navigationController?.pushViewController(vc, animated: true)
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
        
        
        if let msgHeading = textField1?.text, let msgDescription = textField2?.text, let msgDeadline = textField3?.text, let msgSender = Auth.auth().currentUser?.email{
            
            let msg = TodoModel(decription: msgHeading, heading: msgDescription, deadline: msgDeadline, priority: 1, email: msgSender)
            let msgData = msg.toDictionary()

            db.collection("todoData").addDocument(data: ["sender": msgSender, "data": msgData], completion: nil)
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
        vc.navigationItem.title = "AAA"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let model  = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoItemTableViewCell
        if(indexPath.row % 3 == 0){
            cell.leftImage.image = UIImage(named: "leastPriority")
        }else if indexPath.row % 3 == 1 {
            cell.leftImage.image = UIImage(named: "mediumPriority")
        }else {
            cell.leftImage.image = UIImage(named: "highestPriority")

        }
        
        cell.deadlineLabel.text = model[indexPath.row].decription
        cell.headingLabel.text = model[indexPath.row].heading
        cell.deadlineLabel.text = model[indexPath.row].deadline
        
//        cell.colorLabel.backgroundColor = .red
//        cell.description = model[indexPath.row].decription
        
        return cell
    }
    
//
}
