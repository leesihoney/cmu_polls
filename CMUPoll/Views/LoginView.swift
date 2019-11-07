//
//  LoginView.swift
//  CMUPoll
//
//  Created by Sung on 11/6/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct LoginView: View {
  let googleLogo = UIImage(named: "btn_google_dark_focus_ios")
  let robotoFont = UIFont(name: "Roboto-Medium", size: UIFont.labelFontSize)
  
  let uponExistingUser: AfterSignIn
  let uponNewUser: AfterSignIn
  let uponInvalidInput: AfterSignIn
  
  private let andrewLogin = AndrewLogin()
  
  var body: some View {
    
    VStack(alignment: .leading, spacing: 10) {
      HStack(alignment: .center) {
        Image("Logo").resizable()
          .frame(width: 360, height: 100)
      }
      Button(
        action: {
          self.login()
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
  
  func login() {
    andrewLogin.attemptLogin(uponExistingUser: uponExistingUser, uponNewUser: uponNewUser, uponInvalidInput: uponInvalidInput)
  }
}
