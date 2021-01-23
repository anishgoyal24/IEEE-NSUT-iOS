//
//  DiariesViewController.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 22/01/21.
//

import UIKit
import Firebase
import Alamofire

class DiariesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var diaries: [Diaries] = []
    let db = Firestore.firestore()
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.diaryNib, bundle: nil), forCellReuseIdentifier: K.diaryCellIdentifier)
        loadData()
    }
    
    func loadData(){
        db.collection("diaries").addSnapshotListener { (querySnapshot, error) in
            if let e = error{
                print(e)
            }
            else {
                self.parseData(documents: querySnapshot!.documents)
            }
        }
    }
    
    func parseData(documents: [QueryDocumentSnapshot]){
        for document in documents{
            var diary = Diaries(title: document.get("title") as? String ?? "", branch: document.get("date") as? String ?? "", desc: document.get("description") as? String ?? "", imageList: document.get("imageList") as? [String] ?? [], id: document.get("id") as? Int ?? 0)
            diary.desc = diary.desc.replacingOccurrences(of: "\\n", with: "\n")
            diaries.append(diary)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}


extension DiariesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.diaryCellIdentifier, for: indexPath) as! DiaryCell
        cell.title.text = diaries[indexPath.row].title
        if let image = self.imageCache.object(forKey: self.diaries[indexPath.row].id as AnyObject) as? UIImage{
            cell.diaryImage.image = image
        }
        else{
            AF.request(self.diaries[indexPath.row].imageList[0], method: .get).responseData { (response) in
                switch response.result {
                    case .success(let responseData):
                        cell.diaryImage.image = UIImage(data: responseData, scale:1)
                        self.imageCache.setObject(UIImage(data: responseData)!, forKey: self.diaries[indexPath.row].id as AnyObject)
                    case .failure(let error):
                        print(error)
                    }
            }
        }
        return cell
    }
    
    
}
