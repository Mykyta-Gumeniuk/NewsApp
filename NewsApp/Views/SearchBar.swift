//
//  SearchBar.swift
//  NewsApp
//
//  Created by Nik on 28.06.2020.
//  Copyright © 2020 Mykyta Gumeniuk. All rights reserved.
//

import Foundation
import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    
    @Binding var text: String
    var placeholder: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
       
        @ObservedObject var networkManager = NetworkManager()
        
        
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            UIApplication.shared.endEditing()
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
