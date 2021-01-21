//
//  FeaturedDetailViewController.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 21/01/21.
//

import UIKit

class FeaturedDetailViewController: UIViewController {
    
    var featuredPost: FeaturedPost!
    @IBOutlet weak var featuredPostDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featuredPostDesc.text = featuredPost.details
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
