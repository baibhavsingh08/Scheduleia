//
//  RegisterViewController.swift
//  Scheduleia
//
//  Created by Raramuri on 16/07/24.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        if let email = emailTextField.text , let password = passwordTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              
                if let e = error {
                    print("error");
                    let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Okay", style: .cancel, handler: { _ in
                        self.emailTextField.text = ""
                        self.passwordTextField.text = ""
                        })

                        
                    
                    
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }else{
                    print("registered")
                    self.performSegue(withIdentifier: "RegisterToMain", sender: self)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
