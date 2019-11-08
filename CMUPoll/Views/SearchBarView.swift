//
//  SearchBarView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/10/31.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct SearchBarView: UIViewRepresentable {
  
  @Binding var text: String
  
  class Coordinator: NSObject, UISearchBarDelegate {
    @Binding var text: String
    
    init(text: Binding<String>) {
      _text = text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      text = searchText
    }
  }
  
  func makeCoordinator() -> SearchBarView.Coordinator {
    return Coordinator(text: $text)
  }
  
  func makeUIView(context: UIViewRepresentableContext<SearchBarView>) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = context.coordinator
    return searchBar
  }
  
  func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBarView>) {
    uiView.text = text
  }
}

//struct SearchBarView_Previews: PreviewProvider {
//  static var previews: some View {
//    SearchBarView(text: Binding("nyo")
//  }
//}
