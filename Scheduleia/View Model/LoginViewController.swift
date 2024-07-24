import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
    }
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    @IBAction func forgetButtonPressed(_ sender: Any) {
        activityIndicator.startAnimating()
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text ?? "") { error in
            if let e = error {
                let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Okay", style: .cancel, handler: { _ in
                    self.emailTextField.text = ""
                })
                self.activityIndicator.stopAnimating()
                alert.addAction(action)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Reset password mail sent", message: "", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Okay", style: .cancel, handler: { _ in
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                })
                self.activityIndicator.stopAnimating()
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton){
        activityIndicator.startAnimating()
        
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
                    self?.activityIndicator.stopAnimating()
                    self?.present(alert, animated: true)
                }else{
                    self?.performSegue(withIdentifier: "LoginToMain", sender: self)
                }
            }
        }
    }
}
