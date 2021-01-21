//
//  FeaturedViewController.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 21/01/21.
//

import UIKit
import Firebase
import Alamofire

class FeaturedViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    var featuredPosts: [FeaturedPost] = []
    let db = Firestore.firestore()
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.featuredPostNib, bundle: nil), forCellReuseIdentifier: K.featuredPostIdentifier)
        loadFeaturedPosts()
    }
    
    func loadFeaturedPosts(){
        db.collection("feeds").addSnapshotListener { (querySnapshot, error) in
            if let e = error{
                print(e)
            }
            else{
                self.parseData(documents: querySnapshot!.documents)
            }
        }
    }
    
    func parseData(documents: [QueryDocumentSnapshot]){
        featuredPosts = []
        for document in documents{
            let post = FeaturedPost(title: document.get("feedTitle") as? String ?? "", details: document.get("feedDetails") as? String ?? "", imageUrl: document.get("feedImageUrl") as? String ?? "", registerUrl: document.get("registerUrl") as? String ?? "", id: document.get("id") as? Int ?? 0)
            self.featuredPosts.append(post)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is FeaturedDetailViewController{
            let vc = segue.destination as! FeaturedDetailViewController
            vc.featuredPost = featuredPosts[sender as! Int]
        }
    }
    
    @IBAction func menuButtonAction() {
        performSegue(withIdentifier: K.menuSegue, sender: nil)
    }
    

}

extension FeaturedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuredPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.featuredPostIdentifier, for: indexPath) as! FeaturedPostCell
        cell.postTitle.text = featuredPosts[indexPath.row].title
        DispatchQueue.main.async {
            if let image = self.imageCache.object(forKey: self.featuredPosts[indexPath.row].id as AnyObject) as? UIImage{
                cell.postImage.image = image
            }
            else{
                AF.request(self.featuredPosts[indexPath.row].imageUrl, method: .get).responseData { (response) in
                    switch response.result {
                        case .success(let responseData):
                            cell.postImage.image = UIImage(data: responseData, scale:1)
                            self.imageCache.setObject(UIImage(data: responseData)!, forKey: self.featuredPosts[indexPath.row].id as AnyObject)
                        case .failure(let error):
                            print(error)
                        }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: K.featuredPostSegue, sender: indexPath.row)
    }
    
    
}
