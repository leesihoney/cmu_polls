//
//  MyProfileView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/23.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import UIKit

struct MyProfileView: View {
  let user = User.current
  var body: some View {
    
    NavigationView {
      if self.user != nil {
        VStack(alignment: .leading) {
          MyProfileComponentView(user: self.user!)
            .padding(.vertical, 16)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color(red: 248 / 255.0, green: 248 / 255.0, blue: 248 / 255.0))
          
          List {
            HStack {
              Spacer()
              VStack(alignment: .center, spacing: 12) {
                Text("Your Points".uppercased())
                  .fontWeight(.regular)
                  .font(Font.system(size: 10, design: .default))
                  .foregroundColor(.gray)
                if (self.user != nil) {
                  Text(String(self.user?.points ?? 0))
                    .fontWeight(.bold)
                    .font(Font.system(size: 47, design: .default))
                }
              }
              .padding(.vertical, 18)
              Spacer()
            }
            Text("Report a bug")
              .font(Font.system(size: 17, design: .default))
              .foregroundColor(Color.accentColor)
            Text("Help")
              .font(Font.system(size: 17, design: .default))
              .foregroundColor(Color.accentColor)
            NavigationLink(destination: ContentView()) {
              SignOutButtonView()
            }
          }
          .navigationBarTitle(Text("CMUPoll"), displayMode: .inline)
        }
      }
    }
    
  }
}


struct MyProfileComponentView: View {
  let user: User
  var body: some View {
    HStack(alignment: .center, spacing: 21) {
      HStack {
        Image(systemName: "person.fill")
          .font(.system(size: 50))
          .foregroundColor(.gray)
      }
      .frame(width: 84.0, height: 80.0)
      .background(Color.white)
      .cornerRadius(20)
      
      VStack(alignment: .leading, spacing: 7) {
        Text("\(self.user.first_name) \(self.user.last_name)")
          .fontWeight(.semibold)
          .multilineTextAlignment(.leading)
          .font(Font.system(size: 20, design: .default))
        Text("\(self.user.major)")
          .font(Font.system(size: 10, design: .default))
          .foregroundColor(.gray)
        Text("Class of \(self.user.graduation_year ?? 2109)")
          .font(Font.system(size: 10, design: .default))
          .foregroundColor(.gray)
      }
    }
  }
}

struct SignOutButtonView: View {
  var body: some View {
    Button(action: {
      print("Logout")
    }, label: {
      Text("Sign Out")
        .font(Font.system(size: 17, design: .default))
        .foregroundColor(Color.accentColor)
    })
  }
}

struct MyProfileView_Previews: PreviewProvider {
  static var previews: some View {
    MyProfileView()
  }
}
