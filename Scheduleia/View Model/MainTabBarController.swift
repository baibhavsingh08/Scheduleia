import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        let gearImage = UIImage(systemName: "gearshape")
        let gear = UIBarButtonItem(image: gearImage, style: .plain, target: self, action: nil)
        
        let filterImage = UIImage(systemName: "line.3.horizontal.decrease")
        let filter = UIBarButtonItem(image: filterImage, style: .plain, target: self, action: nil)
        
        gear.tintColor = UIColor.black
        filter.tintColor = UIColor.black
        navigationItem.rightBarButtonItems = [gear,filter]
        
        let logout = UIAction(title: "Logout", state: .off) { _ in
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
            confirm.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            self.present(confirm,animated: true)
        }
        let themes = UIAction(title: "Themes (coming soon...)") { _ in
            
        }
        let menu = UIMenu(title: "", children: [logout,themes])
        gear.menu = menu
        
        
        let filterAction = UIAction(title: "Filter (coming soon...)") { _ in
        }
        
        let menu2 = UIMenu(title: "",children: [filterAction])
        filter.menu = menu2
        
        navigationItem.rightBarButtonItems = [gear,filter]
    }
}
