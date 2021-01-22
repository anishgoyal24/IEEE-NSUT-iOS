//
//  DiaryCell.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 22/01/21.
//

import UIKit

class DiaryCell: UITableViewCell {

    @IBOutlet weak var diaryImage: UIImageView!
    @IBOutlet weak var title: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
