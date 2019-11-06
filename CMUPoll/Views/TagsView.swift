//
//  TagsView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/02.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct TagsView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 7) {
      Text(verbatim: "POPULAR KEYWORDS")
        .font(Font.system(size: 12, design: .default))
        .fontWeight(.bold)
        .foregroundColor(Color.gray)
      ScrollView(.horizontal, content: {
        HStack(spacing: CGFloat(7.0)) {
          TagFilterView(tagText: "IS")
          TagFilterView(tagText: "CS")
          TagFilterView(tagText: "Life")
          TagFilterView(tagText: "Academic")
          TagFilterView(tagText: "Food")
          
        }
      })
    }
    
  }
}

struct TagsView_Previews: PreviewProvider {
  static var previews: some View {
    TagsView()
  }
}
