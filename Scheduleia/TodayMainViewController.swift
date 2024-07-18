//
//  TodayMainViewController.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

import UIKit
import FirebaseAuth



class TodayMainViewController: UIViewController {
    
    var model = [TodoModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
//    let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }()
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...10{
            model.append(TodoModel(userName: "aa", password: "aa", decription: "aa", heading: "aa", deadline: "aa"))
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
        
        button.layer.cornerRadius = button.frame.size.width/2
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
        
//        tableView.backgroundColor = UIColor.lightGray
        

        
        tableView.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    @objc func buttonPressed(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "testVC")
        vc.navigationItem.title = "AAA"
        
        let label = UILabel()
        label.text = "Hii"
        label.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        vc.view.addSubview(label)
        
        navigationController?.pushViewController(vc, animated: true)
//        tableView.reloadData()
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
        
        cell.colorLabel.backgroundColor = .red
//        cell.description = model[indexPath.row].decription
        
        return cell
    }
    
//
}
