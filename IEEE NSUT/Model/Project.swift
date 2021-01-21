//
//  Project.swift
//  IEEE NSUT
//
//  Created by Anish Goyal on 21/01/21.
//

import Foundation

struct Project {
    var projectTitle: String
    var projectCategory: String
    var projectImage: [String]
    var projectDesc: String
    var projectId: Int
    
    init(projectTitle: String, projectCategory: String, projectImage: [String], projectDesc: String, projectId: Int) {
        self.projectTitle = projectTitle
        self.projectId = projectId
        self.projectDesc = projectDesc
        self.projectImage = projectImage
        self.projectCategory = projectCategory
    }
}
