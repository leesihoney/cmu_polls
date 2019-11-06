//
//  TagFilterView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/02.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct TagFilterView: View {
  let tagText: String
  var body: some View {
    Group {
      Text(self.tagText)
        .font(Font.system(size: 14, design: .default))
        .fontWeight(.bold)
        .foregroundColor(Color(red: 191 / 255.0, green: 191 / 255.0, blue: 191 / 255.0))
        .padding(.horizontal, 21)
        .padding(.vertical, 9)
    }.background(Color(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0))
      .cornerRadius(250.0)
  }
  
}
struct TagFilterView_Previews: PreviewProvider {
  static var previews: some View {
    TagFilterView(tagText: "IS")
    
  }
}
