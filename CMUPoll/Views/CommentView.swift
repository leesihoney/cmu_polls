//
//  CommentView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/12/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct CommentView: View {
    var body: some View {
      HStack(alignment: .firstTextBaseline, spacing: 52) {
        Image(systemName: "person.fill")
                 .font(.system(size: 50))
                 .foregroundColor(.gray)
        HStack {
          VStack(alignment: .leading) {
            Text("Anna Yuan")
            Text("Information Systems • Class of 2020")
          }
          Text("3d")
        }
        
      }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
