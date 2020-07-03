//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Nik on 27.06.2020.
//  Copyright © 2020 Mykyta Gumeniuk. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var searchText: String = "" {
           didSet {
               fetchData()
           }
       }
    
    @Published var posts = [Post](){
        didSet {
            objectWillChange.send()
        }
    }
    
    func fetchData(){
       
        
        if let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=5dcef32f4c69413e8fe128cc5c7ba4cf&q=\(searchText)"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do{
                            let results = try decoder.decode(News.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.articles
                            }
                        } catch{
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
}

