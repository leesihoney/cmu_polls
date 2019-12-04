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
  @State private var showingAddView: Bool = false
  
  
  var body: some View {
    NavigationView {
      
      VStack(alignment: .leading, spacing: 10) {
        //HACK (iOS version hack)
        HiddenNavigationLink(destination: PollCreateView(refresh: self.getUserPolls), isActive: self.$showingAddView)
        
        SearchBarView(text: $searchTerm)        .padding(.vertical, CGFloat(8))
          .padding(.horizontal, 16)
        
        TagsView(tags: tags)
          .padding(.vertical, CGFloat(10))
          .padding(.horizontal, 16)
        
        Text("All Polls")
          .font(Font.system(size: 20, design: .default))
          .fontWeight(.bold)
          .foregroundColor(Color.gray)
          .padding(.horizontal, 16)
        
        ScrollView {
          VStack(alignment: .leading, spacing: 8) {
            ForEach(self.polls.filter {
              self.searchTerm.isEmpty ? true : $0.title.localizedCaseInsensitiveContains(self.searchTerm)
            }) { poll in
              NavigationLink(destination: PollDetailView(poll: poll)) {
                PollView(poll: poll)
              }
              .buttonStyle(PlainButtonStyle())
            }
          }
        }
        .navigationBarTitle(Text("CMUPoll"), displayMode: .inline)
        .navigationBarItems(trailing:
          Button("Add") { self.showingAddView = true }
        )
      }
      .background(Color(red: 248 / 255.0, green: 248 / 255.0, blue: 248 / 255.0))
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

