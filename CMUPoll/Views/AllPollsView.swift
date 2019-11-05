//
//  AllPollsView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/02.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct AllPollsView: View {
  @State private var searchTerm: String = ""
  
  var body: some View {
    NavigationView {
      List {
        SearchBarView(text: $searchTerm)
          .navigationBarTitle(Text("CMUPoll"), displayMode: .inline)
          .navigationBarItems(trailing:
            // TODO: should connect to a form view
            Button("Add") {
              print("Help tapped!")
            }
        )
        TagsView()
        PollsView()
      }
    }
  }
}

struct AllPollsView_Previews: PreviewProvider {
  static var previews: some View {
    AllPollsView()
  }
}
