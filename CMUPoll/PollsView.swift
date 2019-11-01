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
      NavigationView {
          List {
              Text("Hello World")
                .navigationBarTitle(Text("Navigation Title"))
                .navigationBarItems(trailing:
                  Button("Add") {
                    print("Help tapped!")
                  }
            )
        } // Default to large title style
      }
    }
}

struct PollsView_Previews: PreviewProvider {
    static var previews: some View {
        PollsView()
    }
}
