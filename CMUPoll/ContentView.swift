//
//  ContentView.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import GoogleSignIn

struct ContentView: View {
  
  @State private var username: String = ""
  @State private var password: String = ""
  
  private let andrewLogin = AndrewLogin()
  
  var body: some View {
    
    
    VStack(alignment: .leading, spacing: 10) {
      
      HStack(alignment: .center) {
        Image("Logo").resizable()
          .frame(width: 360, height: 100)
      }
      
      Text("Username").font(.headline).padding(5)
      TextField("", text: $username)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      
      
      Text("Password").font(.headline).padding(5)
      SecureField("", text: $password)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      Button(action: self.login)
      {
        HStack(alignment: .center, spacing: 10) {
          Spacer()
          Text("Login").shadow(radius: 10)
          Spacer()
        }
      }
      
    }
  }
  
  func login() {
    print("username is \(self.username) \n" + "password is \(self.password)")
    andrewLogin.attemptLogin()
  }
}

struct AndrewLogin: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<AndrewLogin>) -> UIView {
      return UIView()
  }

  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AndrewLogin>) {
  }

  func attemptLogin() {
    GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
//    GIDSignIn.sharedInstance()?.restorePreviousSignIn() // Automatically sign in the user.
    GIDSignIn.sharedInstance()?.signIn()
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
