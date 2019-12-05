//
//  MyActivityView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/18.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import UIKit

struct MyActivityView: View {
  
  let user = User.current
  @State var polls = [Poll]()
  @State var answeredPolls = [Poll]()
  
  @State private var chosenView = 0
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading, spacing: 10) {
        Picker(selection: $chosenView, label: Text("")) {
          Text("Uploaded Polls").tag(0)
          Text("Answered Polls").tag(1)
        }.pickerStyle(SegmentedPickerStyle())
          .padding(.vertical, 10)
          .padding(.horizontal, 16)
        
        
        
        Text("My Activity")
          .font(Font.system(size: 20, design: .default))
          .fontWeight(.bold)
          .foregroundColor(Color.gray)
          .padding(.horizontal, 16)
        
        if self.chosenView == 0 {
          MyActivityPollsView(keyword: "uploaded", polls: self.polls)
        } else {
          MyActivityPollsView(keyword: "answered", polls: self.answeredPolls)
        }
      }
      .background(Color(red: 248 / 255.0, green: 248 / 255.0, blue: 248 / 255.0))
      
    }
    .onAppear {
      self.getUploadedPolls()
      self.getAnsweredPolls()
    }
  }
  
  // need to get sorted polls (my answered polls)
  func getUploadedPolls() {
    if let user = self.user {
      user.polls(completion: { polls in
        DispatchQueue.main.async {
          self.polls = polls
        }
      })
    }
  }
  
  func getAnsweredPolls() {
    if let user = self.user {
      user.answeredPolls(completion: { polls in
        DispatchQueue.main.async {
          self.answeredPolls = polls
        }
      })
    }
  }
  
}

struct MyActivityPollsView: View {
  let keyword: String
  let polls: [Poll]
  
  var body: some View {
    Group {
      if self.polls.count > 0 {
        ScrollView {
          VStack(alignment: .leading, spacing: 8) {
            ForEach(self.polls) { poll in
              NavigationLink(destination: PollDetailView(poll: poll)) {
                PollView(poll: poll)
              }
              .buttonStyle(PlainButtonStyle())
            }
          }
        }
        .navigationBarTitle(Text("CMUPoll"), displayMode: .inline)
      } else {
        List {
          NoEntryBoxView(keyword: self.keyword)
        }
        .navigationBarTitle(Text("CMUPoll"), displayMode: .inline)
        .listStyle(GroupedListStyle())
      }
    }
  }
  
}
struct NoEntryBoxView: View {
  let keyword: String
  var body: some View {
    HStack(alignment: .center) {
      Spacer()
      Text("You have not \(self.keyword) any polls!")
        .font(Font.system(size: 16, design: .default))
        .fontWeight(.semibold)
        .foregroundColor(Color.gray)
      Spacer()
    }
    .padding(.vertical, 30)
  }
  
}
struct MyActivityView_Previews: PreviewProvider {
  static var previews: some View {
    MyActivityView()
  }
}
