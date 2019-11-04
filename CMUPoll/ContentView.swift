//
//  ContentView.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  let googleLogo = UIImage(named: "btn_google_dark_focus_ios")
  let robotoFont = UIFont(name: "Roboto-Medium", size: UIFont.labelFontSize)
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack(alignment: .center) {
        Image("Logo").resizable()
          .frame(width: 360, height: 100)
      }
      
      Button(
        action: {
          print("Hit Login")
      },
        label: {
          HStack {
            Image(uiImage: googleLogo!)
              .resizable()
              .frame(width: 18, height: 18)
            Text("SIGN IN WITH GOOGLE")}
            .font(Font.custom("robotoFont", size: 14))
      })
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .background(Color.white)
        .cornerRadius(8.0)
        .shadow(radius: 4.0)
    }.padding()
  }
  
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
