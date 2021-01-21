//
//  FeaturedPostCellTableViewCell.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 21/01/21.
//

import UIKit

class FeaturedPostCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
