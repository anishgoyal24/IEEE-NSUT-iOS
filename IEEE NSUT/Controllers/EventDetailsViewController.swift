//
//  EventDetailsController.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 20/01/21.
//

import UIKit
import Alamofire

class EventDetailsViewController: UIViewController {
    
    var selectedEvent: Event!

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTitle.text = selectedEvent?.title
        eventDesc.text = selectedEvent?.description
        eventDate.text = selectedEvent?.date
        loadImage()
    }
    
    func loadImage(){
        AF.request(selectedEvent.imageList[0], method: .get).responseData { (response) in
            switch response.result {
                case .success(let responseData):
                    self.eventImage.image = UIImage(data: responseData, scale:1)
                case .failure(let error):
                    print(error)
                }
        }
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
