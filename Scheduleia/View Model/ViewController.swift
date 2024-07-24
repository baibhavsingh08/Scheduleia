import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.layer.cornerRadius = signInButton.frame.size.height/3
        signInButton.clipsToBounds = true
        
        registerButton.layer.cornerRadius = registerButton.frame.size.height/3
        registerButton.clipsToBounds = true
        
        animateTitle()
    }
    
    func animateTitle(){
        titleLabel.text = ""
        let titleName = "Scheduleia"
        var index = 1.0;
        
        for x in titleName {
            Timer.scheduledTimer(withTimeInterval: 0.1*index, repeats: false, block: {_ in
                self.titleLabel.text?.append(x)
            })
            index += 1
        }
    }
}

