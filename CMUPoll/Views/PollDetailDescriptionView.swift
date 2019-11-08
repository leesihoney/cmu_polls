//
//  PollDetailDescriptionView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct PollDetailDescriptionView: View {
  let description: String
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(verbatim: "Description")
        .font(Font.system(size: 12, design: .default))
        .fontWeight(.bold)
        .foregroundColor(Color(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0))
      Text(verbatim: self.description)
        .font(Font.system(size: 12, design: .default))
        .multilineTextAlignment(.leading)
        .lineSpacing(3)
        .frame(maxWidth: 345)
        .foregroundColor(Color(red: 116 / 255.0, green: 116 / 255.0, blue: 116 / 255.0))
    }
  }
}

struct PollDetailDescriptionView_Previews: PreviewProvider {
  static var previews: some View {
    PollDetailDescriptionView(description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
  }
}
