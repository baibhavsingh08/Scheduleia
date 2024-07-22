import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
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
