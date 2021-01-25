//
//  ExecommViewController.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 24/01/21.
//

import UIKit
import Firebase
import Alamofire

class ExecommViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var execomm: [Execomm] = []
    let db = Firestore.firestore()
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.execommNib, bundle: nil), forCellReuseIdentifier: K.execommCellIdentifier)
        loadData()
    }
    
    func loadData(){
        db.collection("execomm").addSnapshotListener { (querySnapshot, error) in
            if let e = error{
                print(e)
            }
            else{
                self.parseData(documents: querySnapshot!.documents)
            }
        }
    }
    
    func parseData(documents: [QueryDocumentSnapshot]){
        for document in documents{
            let member = Execomm(name: document.get("name") as? String ?? "", designation: document.get("designation") as? String ?? "", id: document.get("id") as? Int ?? 0, imageUrl: document.get("photoUrl") as? String ?? "", phone: document.get("phoneNo") as? String ?? "", email: document.get("emailId") as? String ?? "")
            execomm.append(member)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
   
}

extension ExecommViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return execomm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.execommCellIdentifier, for: indexPath) as! ExecommCell
        cell.name.text = execomm[indexPath.row].name
        cell.designation.text = execomm[indexPath.row].designation
        cell.execomm = execomm[indexPath.row]
        if let image = self.imageCache.object(forKey: self.execomm[indexPath.row].id as AnyObject) as? UIImage{
            cell.avatar.image = image
        }
        else{
            AF.request(self.execomm[indexPath.row].imageUrl, method: .get).responseData { (response) in
                switch response.result {
                    case .success(let responseData):
                        cell.avatar.image = UIImage(data: responseData, scale:1)
                        self.imageCache.setObject(UIImage(data: responseData)!, forKey: self.execomm[indexPath.row].id as AnyObject)
                    case .failure(let error):
                        print(error)
                    }
            }
        }
        return cell
    }
}
