//
//  MainTabBarController.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutButtonpressed(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            let alert = UIAlertController(title: "Error", message: signOutError.localizedDescription, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)

            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }

}
