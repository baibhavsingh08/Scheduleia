//
//  AllTaskMainViewController.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

import UIKit

class AllTaskMainViewController: UIViewController {
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        print("hii")
    }
    
}



extension AllTaskMainViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let model  = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoItemTableViewCell
//        cell.textLabel?.text = "aa"
        return cell
    }
    
//
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


