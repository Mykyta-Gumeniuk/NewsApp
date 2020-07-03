//
//  News.swift
//  NewsApp
//
//  Created by Nik on 27.06.2020.
//  Copyright © 2020 Mykyta Gumeniuk. All rights reserved.
//

import Foundation

struct News: Decodable {
    let articles: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String{
        return url!
    }
    let title: String
    let url: String?
}
