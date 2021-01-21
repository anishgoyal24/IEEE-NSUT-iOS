//
//  ProjectCell.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 21/01/21.
//

import UIKit

class ProjectCell: UITableViewCell {
    
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
