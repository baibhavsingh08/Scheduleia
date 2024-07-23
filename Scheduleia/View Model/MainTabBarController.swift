import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func logoutButtonpressed(_ sender: Any) {
        let confirm = UIAlertController(title: "Are you sure, You want to log out?", message: nil, preferredStyle: .alert)
                confirm.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {
                    _ in
                    do {
                        try Auth.auth().signOut()
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    catch _ as NSError {
                        let alert = UIAlertController(title: "Error", message:  nil , preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
                        self.present(alert, animated: true)
                    }
                }))
        confirm.addAction(UIAlertAction(title: "No", style: .default    , handler: nil))
                self.present(confirm,animated: true)
            }
    }

