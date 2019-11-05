//
//  TabbarView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/02.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct TabbarView: View {
  var body: some View {
    TabView {
      AllPollsView()
        .tabItem({
          Image(systemName: "list.dash")
          Text("All Polls")
        })
        .tag(0)
      Text("Second View")
        .font(.title)
        .tabItem({
          Image(systemName: "chart.bar.fill")
          Text("My Activity")
        })
        .tag(1)
      Text("Third View")
        .font(.title)
        .tabItem({
          Image(systemName: "person.fill")
          Text("My Profile")
        })
        .tag(2)
    }
  }
}

struct TabbarView_Previews: PreviewProvider {
  static var previews: some View {
    TabbarView()
  }
}
