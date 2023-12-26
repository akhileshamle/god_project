//
//  NewsStory.swift
//  god_project
//
//  Created by Akhilesh Amle on 26/12/23.
//

import Foundation

struct NewsStory: Identifiable, Decodable {
    let id: Int
    let title: String
    let strap: String
    let url: URL
}
