//
//  PollView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/01.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct PollView: View {
  let profile = Image("user_pic")
  
  var body: some View {
    VStack(alignment: .leading, spacing: 13) {
      HStack(alignment: .center, spacing: 7) {
        profile
        VStack(alignment: .leading, spacing: 6) {
          HStack(alignment: .firstTextBaseline, spacing: 7) {
            Text("Aiden Lee")
              .bold()
              .font(Font.system(size: 12, design: .default))
            Text("Information Systems • Class of 2020")
              //              .color(.secondary)
              .font(Font.system(size: 10, design: .default))
              .foregroundColor(Color.gray)
          }
          Text("updated 29 days ago")
            //            .color(.secondary)
            .font(Font.system(size: 10, design: .default))
            .foregroundColor(Color.gray)
        }
      }
      Text("Who is your favorite Information Systems professor?")
        .fontWeight(.semibold)
        .multilineTextAlignment(.leading)
        .font(Font.system(size: 20, design: .default))
        .frame(width: 345.0)
        .lineSpacing(10)
      HStack(alignment: .firstTextBaseline, spacing: 115) {
        HStack(alignment: .firstTextBaseline, spacing: 5) {
          TagView()
          TagView()
        }
        HStack(alignment: .firstTextBaseline, spacing: 13) {
          Text("300.2k votes")
            .fontWeight(.regular)
            .foregroundColor(Color.gray)
          HStack(alignment: .firstTextBaseline) {
            Image(systemName: "message.fill")
              .foregroundColor(.gray)
              .frame(width: CGFloat(27.0), height: CGFloat(27.0), alignment: .bottomLeading)
            Text("3")
              .fontWeight(.regular)
              .foregroundColor(Color.gray)
          }
        }
      }
    }
    .padding(.bottom, 25)
    .padding(.top, 27)
    .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: 188.0, maxHeight: 188.0)

  }
  
  
}

struct PollView_Previews: PreviewProvider {
  static var previews: some View {
    PollView()
  }
}
