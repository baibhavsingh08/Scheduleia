//
//  AllTaskMainViewController.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

import UIKit

class AllTaskMainViewController: UIViewController {
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
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("Hello")
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
        cell.headingLabel.text = "aaaaaa"
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


