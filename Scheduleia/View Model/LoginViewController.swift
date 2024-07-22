import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        loginButton.layer.cornerRadius = loginButton.frame.size.height/3
        loginButton.clipsToBounds = true
        
        emailLabel.layer.cornerRadius = emailLabel.frame.size.height/2
        emailLabel.clipsToBounds = true
        
        passwordLabel.layer.cornerRadius = passwordLabel.frame.size.height/2
        passwordLabel.clipsToBounds = true
    }
    
    @IBAction func forgetButtonPressed(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text ?? "") { error in
                    if let e = error {
                        let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Okay", style: .cancel, handler: { _ in
                            self.emailTextField.text = ""
                            })
                        
                        alert.addAction(action)
                        self.present(alert, animated: true)
                    } else {
                        let alert = UIAlertController(title: "Reset password mail sent", message: "", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Okay", style: .cancel, handler: { _ in
                            self.emailTextField.text = ""
                            self.passwordTextField.text = ""
                            })

                        alert.addAction(action)
                        self.present(alert, animated: true)
                    }
                }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton){
        
        if let email = emailTextField.text , let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let _ = self else { return }
                
                if let e = error {
                    let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Okay", style: .cancel, handler: { _ in
                        self?.emailTextField.text = ""
                        self?.passwordTextField.text = ""
                        })

                    alert.addAction(action)
                    self?.present(alert, animated: true)
                }else{
                    self?.performSegue(withIdentifier: "LoginToMain", sender: self)
                }
            }
        }
    }
}
