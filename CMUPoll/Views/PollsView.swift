//
//  PollsView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/10/31.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct PollsView: View {
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("All Polls")
        .font(Font.system(size: 20, design: .default))
        .fontWeight(.bold)
        .foregroundColor(Color.gray)
      VStack(alignment: .leading, spacing: 10) {
        PollView()
        PollView()
        PollView()
      }
    }
    
  }
}

struct PollsView_Previews: PreviewProvider {
  static var previews: some View {
    PollsView()
  }
}
