//
//  ExecommCell.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 24/01/21.
//

import UIKit

class ExecommCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var designation: UILabel!
    var execomm: Execomm!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.borderWidth = 1
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func emailAction(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:"mailto:\(execomm.email)")!)
    }
    
    @IBAction func phoneAction(_ sender: Any) {
        UIApplication.shared.open(URL(string:"tel://\(execomm.phone)")!)
    }
    
    
}
