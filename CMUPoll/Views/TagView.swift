//
//  TagView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/01.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct TagView: View {
  let tagText: String
  var body: some View {
    Group {
      Text(self.tagText)
        .font(Font.system(size: 8, design: .default))
        .fontWeight(.bold)
        .foregroundColor(Color(red: 0.0, green: 0.47843137254, blue: 1.0))
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
    }.background(Color(red: 0 / 255.0, green: 0.47843137254, blue: 1.0, opacity: 0.3))
      .cornerRadius(250.0)
  }
}

struct ClosedTagView: View {
  var body: some View {
    Text("Closed")
      .font(Font.system(size: 12, design: .default))
      .fontWeight(.bold)
      .foregroundColor(Color(red: 32 / 255.0, green: 32 / 255.0, blue: 32 / 255.0))
      .padding(.horizontal, 15)
      .padding(.vertical, 6)
      .background(Color(red: 192 / 255.0, green: 192 / 255.0, blue: 192 / 255.0))
      .cornerRadius(250.0)
  }
}
//struct TagView_Previews: PreviewProvider {
//  static var previews: some View {
//    TagView(tagText: "IS")
//  }
//}
