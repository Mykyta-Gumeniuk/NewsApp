//
//  ContentView.swift
//  NewsApp
//
//  Created by Nik on 26.06.2020.
//  Copyright © 2020 Mykyta Gumeniuk. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView{
            VStack {
                SearchBar(text: $networkManager.searchText, placeholder: "Enter a keyword")
                List(networkManager.posts) { post in
                    NavigationLink(destination: DetailView(url: post.url)) {
                        HStack {
                            Text(post.title)
                        }
                    }
                    
                }.gesture(DragGesture().onChanged { _ in UIApplication.shared.endEditing() })
                
            }.navigationBarTitle("News")
            
        }
        .onAppear {
            self.networkManager.fetchData()
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
