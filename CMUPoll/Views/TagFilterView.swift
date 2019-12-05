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
  @State var userClickedTag: Bool = false
  @State var uponTagTap: ([Poll]) -> ()
  
  
  var body: some View {
    Button(action: {
      if self.userClickedTag == false {
        self.userClickedTag = true
      }
      else {
        self.userClickedTag = false
      }
      Poll.withTag(name: self.tagText, completion: { tag_polls in
        self.uponTagTap(tag_polls)
      })
    })
    {
      Group {
        if !self.userClickedTag {
          Text(self.tagText)
            .font(Font.system(size: 14, design: .default))
            .fontWeight(.bold)
            .foregroundColor(Color(red: 191 / 255.0, green: 191 / 255.0, blue: 191 / 255.0))
            
            .padding(.horizontal, 21)
            .padding(.vertical, 9)
            .background(Color(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0))
            .cornerRadius(250.0)
        }
        else {
          Text(self.tagText)
            .font(Font.system(size: 14, design: .default))
            .fontWeight(.bold)
            .foregroundColor(Color(red: 51 / 255.0, green: 153 / 255.0, blue: 255 / 255.0))
            
            .padding(.horizontal, 21)
            .padding(.vertical, 9)
            .background(Color(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0))
            .cornerRadius(250.0)
        }
      }
    }
  }
}

//struct TagFilterView_Previews: PreviewProvider {
//  static var previews: some View {
//    TagFilterView(tagText: "IS", userClickedTag: false, uponTagTap: {})
//  }
//}
