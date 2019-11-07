//
//  ContentView.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import GoogleSignIn
import CoreData

struct ContentView: View {
  @State var loggedIn: Bool?
  
  init() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
    request.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(request)
      for login in result as! [Login] {
        User.withId(id: login.user_id!, completion: { user in
          User.current = user
        })
        self.loggedIn = true
      }
    } catch {
      print("CoreData Access failed")
    }
  }
  
  var body: some View {
    Group {
      if loggedIn == nil {
        LoginView(
          uponExistingUser: {
          self.loggedIn = true
        }, uponNewUser: {
          self.loggedIn = false
        })
      } else if loggedIn! {
        TabbarView()
      } else {
        // View where users put their major and graduation year
        
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
