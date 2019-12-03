//
//  PollView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/01.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct PollView: View {
  let poll: Poll
  let profile = Image("user_pic")
  let uploaderName = "Aiden Lee"
  let uploaderMajor = "Information Systems"
  let uploaderGraduationYear = 2020
  let uploadedDaysAgo = "29"
  @State var tags = [Tag]()
  @State var pollUser: User?

  var body: some View {
    VStack(alignment: .leading, spacing: 13) {
      if (pollUser != nil) {
        PollUploaderProfileView(uploaderName: "\(pollUser!.first_name) \(pollUser!.last_name)", uploaderMajor: pollUser!.major, uploaderGraduationYear: String(pollUser!.graduation_year ?? 2020), uploadedDaysAgo: uploadedDaysAgo)
      }
      
      Text(self.poll.title)
        .fontWeight(.semibold)
        .multilineTextAlignment(.leading)
        .font(Font.system(size: 20, design: .default))
        .lineSpacing(10)
        .lineLimit(2)
      HStack(alignment: .firstTextBaseline) {
        HStack(alignment: .firstTextBaseline, spacing: 5) {
          ForEach(tags) { tag in
            TagView(tagText: tag.name)
          }
        }
        Spacer()
        HStack(alignment: .firstTextBaseline, spacing: 13) {
          Text("300.2k votes")
            .fontWeight(.regular)
            .foregroundColor(Color.gray)
          HStack(alignment: .firstTextBaseline) {
            Image(systemName: "message.fill")
              .foregroundColor(.gray)
              .frame(width: CGFloat(27.0), height: CGFloat(27.0), alignment: .bottomLeading)
            Text("3")
              .fontWeight(.regular)
              .foregroundColor(Color.gray)
          }
        }
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 188.0, alignment: .center)
    .padding(.vertical, 25)
    .padding(.horizontal, 15)
    .background(Color.white)
    .onAppear { 
      self.getPollTags()
      self.getPollUser()
    }
    
  }
  
  
  func getPollTags() {
    self.poll.tags(completion: { tags in
      DispatchQueue.main.async {
        self.tags = tags
      }
    })
  }
  
  func getPollUser() {
    self.poll.user(completion: { user in
      DispatchQueue.main.async {
        self.pollUser = user
      }
    })
  }
  
  
}

struct PollView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 8) {
          PollView(poll: Poll(id: "1", user_id: "1", title: "Who is your favorite IS Professor?", description: "Nyo", posted_at: "2019-10-24", link: "", is_private: false, is_closed: false))
          PollView(poll: Poll(id: "2", user_id: "1", title: "Who is your favorite IS Professor?", description: "Nyo", posted_at: "2019-10-24", link: "", is_private: false, is_closed: false))
        }
      }
      .navigationBarTitle(Text("CMUPoll"), displayMode: .inline)
    }
    .background(Color.gray)
  }
}
