//
//  TagsView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/02.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct TagsView: View {
  let tags: [Tag]
  @State var uponTagTap: ([Poll]) -> ()
  
  var body: some View {
    VStack(alignment: .leading, spacing: 7) {
      Text(verbatim: "POPULAR KEYWORDS")
        .font(Font.system(size: 12, design: .default))
        .fontWeight(.bold)
        .foregroundColor(Color.gray)
      ScrollView(.horizontal, content: {
        HStack(spacing: CGFloat(7.0)) {
          ForEach(tags) { tag in
            TagFilterView(tagText: tag.name, uponTagTap: { tag_polls in
              // Function body
              self.uponTagTap(tag_polls)}
            )
          }
        }
      })
    }
  }
}

//struct TagsView_Previews: PreviewProvider {
//  static var previews: some View {
//    TagsView(tags: [
//      Tag(id: "1", name: "IS"),
//      Tag(id: "3", name: "CS"),
//      Tag(id: "4", name: "Life"),
//      Tag(id: "5", name: "Academic"),
//      Tag(id: "8", name: "Food"),
//    ], uponTagTap: {})
//  }
//}
