//
//  TodoItemTableViewCell.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var colorLabel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}