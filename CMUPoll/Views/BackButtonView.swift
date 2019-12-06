//
//  BackButtonView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/12/03.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct BackButtonView: View {
  let label: String
    var body: some View {
      Text("\(self.label)")
        .foregroundColor(Color.accentColor)
    }
}

//struct BackButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//      BackButtonView(label: "Back")
//    }
//}
