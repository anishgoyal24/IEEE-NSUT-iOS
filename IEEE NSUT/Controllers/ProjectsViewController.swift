//
//  ProjectsViewController.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 21/01/21.
//

import UIKit
import Firebase

class ProjectsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var projectsList: [Project] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.projectNib, bundle: nil), forCellReuseIdentifier: K.projectIdentifier)
        loadData()
    }
    
    func loadData(){
        db.collection("projects").addSnapshotListener{ (querySnapshot, error) in
            if let e = error{
                print(e)
            }
            else{
                self.parseData(documents: querySnapshot!.documents)
            }
        }
    }
    
    func parseData(documents: [QueryDocumentSnapshot]){
        projectsList = []
        for document in documents{
            let project = Project(projectTitle: document.get("title") as? String ?? "", projectCategory: document.get("date") as? String ?? "", projectImage: document.get("imageList") as? [String] ?? [], projectDesc: document.get("description") as? String ?? "", projectId: document.get("id") as? Int ?? 0)
            projectsList.append(project)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ProjectDetailedViewController{
            let vc = segue.destination as! ProjectDetailedViewController
            vc.project = projectsList[sender as! Int]
        }
    }

}

extension ProjectsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.projectIdentifier, for: indexPath) as! ProjectCell
        cell.projectCategory.text = projectsList[indexPath.row].projectCategory
        cell.projectTitle.text = projectsList[indexPath.row].projectTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: K.projectSegue, sender: indexPath.row)
    }
    
    
}
