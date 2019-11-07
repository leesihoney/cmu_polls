//
//  AndrewLogin.swift
//  CMUPoll
//
//  Created by Sung on 11/6/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI
import GoogleSignIn

struct AndrewLogin: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<AndrewLogin>) -> UIView {
    let button = GIDSignInButton()
    return button
  }
  
  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AndrewLogin>) {
    
  }
  
  func attemptLogin(completion: @escaping () -> Void, fail: @escaping () -> Void) {
    GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
    GIDSignIn.sharedInstance()?.signIn()
    DispatchQueue(label: "SignIn Check", qos: DispatchQoS.background).async(execute: { () -> Void in
      while true {
        if (GIDSignIn.sharedInstance()?.currentUser != nil) {
          if (User.current != nil) {
            completion()
          } else {
            fail()
          }
          break
        }
      }
    })
  }
}
