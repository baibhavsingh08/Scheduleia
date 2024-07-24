import UIKit
import FirebaseFirestore
import Firebase

protocol DeleteTodoItemFromTable{
    func editCell(_ cell: TodoItemTableViewCell)
    func taskCompleted(_ cell: TodoItemTableViewCell)
}

class TodoItemTableViewCell: UITableViewCell {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var colorLabel: UIView!
    
    var docId: String?
    var isDone: Bool?
    var priority: Int?
    
    let db = Firestore.firestore()
    var delegate: DeleteTodoItemFromTable?
    
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        delegate?.editCell(self)
    }
    
    @IBAction func alterButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        delegate?.taskCompleted(self)
    }
}
