//
//  FeaturedPost.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 21/01/21.
//

import Foundation

struct FeaturedPost {
    var title: String
    var details: String
    var imageUrl: String
    var registerUrl: String
    var id: Int
    
    init(title: String, details: String, imageUrl: String, registerUrl: String, id: Int) {
        self.title = title
        self.details = details
        self.imageUrl = imageUrl
        self.registerUrl = registerUrl
        self.id = id
    }
}
