//
//  DiaryDetailsViewController.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 24/01/21.
//

import UIKit

class DiaryDetailsViewController: UIViewController {

    @IBOutlet weak var desc: UILabel!
    var diary: Diary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desc.text = diary.desc

        // Do any additional setup after loading the view.
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
