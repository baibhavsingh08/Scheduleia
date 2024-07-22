import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    } ()
    
    let addButton: UIButton = {
        let button = UIButton()
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Today's Tasks"
        navigationItem.hidesBackButton = true
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        tableView.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    @IBAction func logoutButtonpressed(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let e as NSError {
            let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)

            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let model  = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoItemTableViewCell
//        cell.textLabel?.text = "aa"
        return cell
    }
    
//
}
