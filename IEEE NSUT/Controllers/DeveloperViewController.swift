//
//  DeveloperViewController.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 25/01/21.
//

import UIKit

class DeveloperViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var batch: UILabel!
    @IBOutlet weak var gitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = "Anish Goyal"
        batch.text = "IT, NSIT (2017-2021)"
        avatar.layer.borderWidth = 1
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
    }

    @IBAction func mailAction(_ sender: Any) {
        UIApplication.shared.open(URL(string: "mailto:anishgoyal2406@gmail.com")!)
    }
    
    
    @IBAction func phoneAction(_ sender: Any) {
        UIApplication.shared.open(URL(string: "tel://08587054236")!)
    }
    
    @IBAction func linkedinButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.linkedin.com/in/anish-goyal-b68309173/")!)
    }
    
    
    @IBAction func githubButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://github.com/anishgoyal24")!)
    }
}
