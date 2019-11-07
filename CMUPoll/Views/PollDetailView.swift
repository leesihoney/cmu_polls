//
//  PollDetailView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct PollDetailView: View {
  let profile = Image("user_pic")
  let uploaderName = "Aiden Lee"
  let uploaderMajor = "Information Systems"
  let uploaderGraduationYear = "2020"
  let uploadedDaysAgo = "29"
  let poll: Poll
  
  var body: some View {
    VStack(alignment: .leading, spacing: 13) {
      PollUploaderProfileView(uploaderName: uploaderName, uploaderMajor: uploaderMajor, uploaderGraduationYear: uploaderGraduationYear, uploadedDaysAgo: uploadedDaysAgo)
      Text(poll.title)
        .fontWeight(.semibold)
        .multilineTextAlignment(.leading)
        .font(Font.system(size: 20, design: .default))
        .lineSpacing(10)
      HStack(alignment: .firstTextBaseline, spacing: 5) {
        TagView(tagText: "IS")
        TagView(tagText: "Academic")
      }
      PollDetailDescriptionView(description: poll.description)
      Text(verbatim: "You will get 2 point per questions that you answered")
        .font(Font.system(size: 12, design: .default))
        .fontWeight(.semibold)
        .foregroundColor(Color(red: 236 / 255.0, green: 0 / 255.0, blue: 0 / 255.0))
      List {
        AnswerBoxView()
        AnswerBoxView()
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, idealHeight: 188.0, alignment: .center)
    .padding(.vertical, 25)
    .padding(.horizontal, 15)
  }
}

struct PollDetailView_Previews: PreviewProvider {
  static var previews: some View {
    PollDetailView(poll: Poll(id: "1", user_id: "1", title: "Who is your favorite IS Professor?", description: "Nyo", link: "", is_private: false))
  }
}
