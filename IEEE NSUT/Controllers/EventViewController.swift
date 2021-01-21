//
//  EventViewController.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 19/01/21.
//

import UIKit
import Firebase

class EventViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var eventsList: [Event] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.eventCellNib, bundle: nil), forCellReuseIdentifier: K.eventCellIdentifier)
        getEvents()
    }
    
    func getEvents(){
        db.collection("events").addSnapshotListener { (querySnapshot, error) in
            if let e = error{
                print(e)
            }
            else{
                self.parseData(documents: querySnapshot!.documents)
            }
        }
    }
    
    func parseData(documents: [QueryDocumentSnapshot]){
        eventsList = []
        for document in documents{
            let event = Event(title: document.get("title") as? String ?? "", description: document.get("description") as? String ?? "", date: document.get("date") as? String ?? "", imageList: document.get("imageList") as? [String] ?? [])
            self.eventsList.append(event)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is EventDetailsViewController{
            let vc = segue.destination as! EventDetailsViewController
            vc.selectedEvent = eventsList[sender as! Int]
        }
    }
    
}

extension EventViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.eventCellIdentifier, for: indexPath) as! EventCell
        cell.eventTitle.text = eventsList[indexPath.row].title
        cell.eventDate.text = eventsList[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: K.eventDetailSegue, sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
