//
//  ProjectDetailedViewController.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 21/01/21.
//

import UIKit
import Alamofire

class ProjectDetailedViewController: UIViewController {

    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectCategory: UILabel!
    @IBOutlet weak var projectDesc: UILabel!
    var project: Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectTitle.text = project.projectTitle
        projectCategory.text = project.projectCategory
        projectDesc.text = project.projectDesc
        loadImage()
    }
    
    func loadImage(){
        AF.request(project.projectImage[0], method: .get).responseData { (response) in
            switch response.result {
                case .success(let responseData):
                    self.projectImage.image = UIImage(data: responseData, scale:1)
                case .failure(let error):
                    print(error)
                }
        }
    }

}
