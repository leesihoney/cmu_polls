//
//  TabbarView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/12/03.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct TabbarView: View {
  @State var selectedView = 0

  var body: some View {
    TabView(selection: $selectedView) {
      AllPollsView()
        .tabItem({
          Image(systemName: "list.dash")
          Text("All Polls")
        })
        .tag(0)
      MyActivityView()
        .tabItem({
          Image(systemName: "chart.bar.fill")
          Text("My Activity")
        })
        .tag(1)
      MyProfileView()
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
