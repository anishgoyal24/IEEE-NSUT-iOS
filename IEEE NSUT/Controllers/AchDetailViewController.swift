//
//  AchDetailViewController.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 22/01/21.
//

import UIKit
import Alamofire

class AchDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var achTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var achDescription: UILabel!
    var achievement: Achievement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        achTitle.text = achievement.title
        date.text = achievement.date
        achDescription.text = achievement.description
        AF.request(achievement.imageList[0], method: .get).responseData { (response) in
            switch response.result {
                case .success(let responseData):
                    self.imageView.image = UIImage(data: responseData, scale:1)
                case .failure(let error):
                    print(error)
                }
        }
    }

}
