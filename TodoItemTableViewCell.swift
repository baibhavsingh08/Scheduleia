//
//  TodoItemTableViewCell.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var colorLabel: UIView!
    
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func alterButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
}
