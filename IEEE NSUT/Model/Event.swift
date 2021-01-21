//
//  Event.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 19/01/21.
//

import Foundation

struct Event {
    var title : String
    var description: String
    var date : String
    var imageList : [String]
    
    init(title : String, description: String, date: String, imageList: [String]) {
        self.title = title
        self.description = description
        self.date = date
        self.imageList = imageList
    }
}
