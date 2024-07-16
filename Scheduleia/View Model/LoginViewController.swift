//
//  LoginViewController.swift
//  Scheduleia
//
//  Created by Raramuri on 16/07/24.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton){
        
        if let email = emailTextField.text , let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let _ = self else { return }
                
                if let e = error {
                    print("error");
                    let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Okay", style: .cancel, handler: { _ in
                        self?.emailTextField.text = ""
                        self?.passwordTextField.text = ""
                        })

                        
                    
                    
                    alert.addAction(action)
                    self?.present(alert, animated: true)
                }else{
                    print("login")
                    self?.performSegue(withIdentifier: "LoginToMain", sender: self)
                }
            }
        }
        
    }
  

}
