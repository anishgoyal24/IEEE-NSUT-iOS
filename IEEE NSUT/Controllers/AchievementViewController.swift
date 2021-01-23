//
//  AchievementViewController.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 21/01/21.
//

import UIKit
import Firebase

class AchievementViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var achievements: [Achievement] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.achievementNib, bundle: nil), forCellReuseIdentifier: K.acheivementCellIdentifier)
        loadData()
    }
    
    func loadData(){
        db.collection("achievements").addSnapshotListener { (querySnapshot, error) in
            if let e = error{
                print(e)
            }
            else{
                self.parseData(documents: querySnapshot!.documents)
            }
        }
    }
    
    func parseData(documents: [QueryDocumentSnapshot]){
        achievements = []
        for document in documents{
            var achievement = Achievement(title: document.get("title") as? String ?? "", id: document.get("id") as? Int ?? 0, description: document.get("description") as? String ?? "", date: document.get("date") as? String ?? "", imageList: document.get("imageList") as? [String] ?? [])
            achievement.description = achievement.description.replacingOccurrences(of: "\\n", with: "\n")
            achievements.append(achievement)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AchDetailViewController{
            let vc = segue.destination as! AchDetailViewController
            vc.achievement = achievements[sender as! Int]
        }
    }

}


extension AchievementViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.acheivementCellIdentifier, for: indexPath) as! AchievementCell
        cell.title.text = achievements[indexPath.row].title
        cell.date.text = achievements[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: K.achievementSegue, sender: indexPath.row)
    }
    
    
}
