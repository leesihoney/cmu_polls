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
  
  @State var tags = [Tag]()
  
  @State private var searchTerm: String = ""
  
  var body: some View {
    NavigationView {
      List {
        SearchBarView(text: $searchTerm)
          .padding(.vertical, CGFloat(8))
        TagsView(tags: tags)
          .padding(.vertical, CGFloat(10))

        
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
      self.getAllTags()
    }
  }
  
  func getUserPolls() {
    Poll.allPolls(completion: { polls in
      DispatchQueue.main.async {
        self.polls = polls
      }
    })
  }
  
  func getAllTags() {
    Tag.allTags(completion: { tags in
      DispatchQueue.main.async {
        self.tags = tags
      }
    })
  }
  
  
}

struct AllPollsView_Previews: PreviewProvider {
  static var previews: some View {
    AllPollsView()
  }
}
