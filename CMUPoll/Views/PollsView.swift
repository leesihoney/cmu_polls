//
//  PollsView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/10/31.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct PollsView: View {
  let polls: [Poll]
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("All Polls")
        .font(Font.system(size: 20, design: .default))
        .fontWeight(.bold)
        .foregroundColor(Color.gray)
      VStack(alignment: .leading, spacing: 10) {
        ForEach(self.polls) { poll in
          PollView(poll: poll)
        }
      }
    }
    
  }
}

struct PollsView_Previews: PreviewProvider {
  static var previews: some View {
    PollsView(polls: [
      Poll(id: "1", user_id: "1", title: "Who is your favorite IS Professr?", description: "Nyo", posted_at: "2019-10-24", link: "", is_private: false, is_closed: false),
      Poll(id: "2", user_id: "1", title: "What is your favorite sports?", description: "Nyo", posted_at: "2019-10-24", link: "", is_private: false, is_closed: false),
      Poll(id: "3", user_id: "1", title: "Where is your favorite study place?", description: "Nyo", posted_at: "2019-10-24", link: "", is_private: false, is_closed: false),
      Poll(id: "4", user_id: "1", title: "Sample Title", description: "Nyo", posted_at: "2019-10-24", link: "", is_private: false, is_closed: false),
      Poll(id: "5", user_id: "1", title: "Sleepy Sleepy Night", description: "Nyo", posted_at: "2019-10-24", link: "", is_private: false, is_closed: false),
    ])
  }
}
