//
//  AllPollsView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/02.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct AllPollsView: View {
  let user = User.current
  @State var polls = [Poll]()
  
  let tags = [
    Tag(id: "1", name: "IS"),
    Tag(id: "3", name: "CS"),
    Tag(id: "4", name: "Life"),
    Tag(id: "5", name: "Academic"),
    Tag(id: "8", name: "Food"),
  ]
  
  @State private var searchTerm: String = ""
  
  var body: some View {
    NavigationView {
      List {
        SearchBarView(text: $searchTerm)
        TagsView(tags: tags)
        ForEach(self.polls) { poll in
          NavigationLink(destination: PollDetailView(poll: poll)) {
            PollView(poll: poll)
          }
        }
        
      }
      .navigationBarTitle(Text("CMUPoll"), displayMode: .inline)
      .navigationBarItems(trailing:
        // TODO: should connect to a form view
        NavigationLink(destination: PollCreateView()) {
          Text("Add")
        }
      )
    }
    .onAppear {
      self.getUserPolls()
    }
  }
  
  func getUserPolls() {
    guard let user = self.user else {
      print("ERROR! Cannot Bring user")
      return
    }
    user.polls(completion: { polls in
      DispatchQueue.main.async {
        self.polls = polls
      }
    })
  }
  
  
}

struct AllPollsView_Previews: PreviewProvider {
  static var previews: some View {
    AllPollsView()
  }
}
