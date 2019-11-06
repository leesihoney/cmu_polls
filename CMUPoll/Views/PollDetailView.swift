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
  var body: some View {
    VStack(alignment: .leading, spacing: 13) {
      HStack(alignment: .center, spacing: 7) {
        profile
        VStack(alignment: .leading, spacing: 6) {
          HStack(alignment: .firstTextBaseline, spacing: 7) {
            Text("Aiden Lee")
              .bold()
              .font(Font.system(size: 12, design: .default))
            Text("Information Systems • Class of 2020")
              //              .color(.secondary)
              .font(Font.system(size: 10, design: .default))
              .foregroundColor(Color.gray)
          }
          Text("updated 29 days ago")
            //            .color(.secondary)
            .font(Font.system(size: 10, design: .default))
            .foregroundColor(Color.gray)
        }
      }
      Text("Who is your favorite Information Systems professor?")
        .fontWeight(.semibold)
        .multilineTextAlignment(.leading)
        .font(Font.system(size: 20, design: .default))
        .lineSpacing(10)
      HStack(alignment: .firstTextBaseline, spacing: 5) {
        TagView(tagText: "IS")
        TagView(tagText: "Academic")
      }
      PollDetailDescriptionView()
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
    PollDetailView()
  }
}
