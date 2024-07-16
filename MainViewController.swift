//
//  MainViewController.swift
//  Scheduleia
//
//  Created by Raramuri on 16/07/24.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Today's Tasks"
        navigationItem.hidesBackButton = true

    }
    

    @IBAction func logoutButtonpressed(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}
