import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.cornerRadius = registerButton.frame.size.height/3
        registerButton.clipsToBounds = true
        
        emailLabel.layer.cornerRadius = emailLabel.frame.size.height/2
        emailLabel.clipsToBounds = true
        
        passwordLabel.layer.cornerRadius = passwordLabel.frame.size.height/2
        passwordLabel.clipsToBounds = true
        
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
                    
                    self.performSegue(withIdentifier: "RegisterToMain", sender: self)
                }
            }
        }
    }
}
