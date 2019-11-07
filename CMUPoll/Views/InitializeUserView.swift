//
//  TagsView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/02.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct InitializeUserView: View {
  @State var first_name_that_should_not_be_used = ""
  @State var last_name_that_should_not_be_used = ""
  
  @State var major = ""
  @State var graduation = ""
  
  @State var email_that_should_not_be_used = ""
  
  var first_name = "First Name"
  var last_name = "Last Name"
  var email = "Email Address"
  @State var yearsIndex = 0
  @State var years = ["2012", "2013", "2014", "2015", "2016",
  "2017", "2018", "2019", "2020", "2021", "2022", "2023",
  "2024", "2025"]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 40) {
      
      HStack(alignment: .center) {
        Image("Logo").resizable()
          .frame(width: 360, height: 100)
      }
      
      
      HStack(alignment: .center, spacing: 7) {
        
        VStack(alignment: .leading, spacing: 20) {
          Text(verbatim: "First Name")
          .font(Font.system(size: 12, design: .default))
          .fontWeight(.bold)
          .foregroundColor(Color(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0))
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
          
          
          TextField(first_name, text: $first_name_that_should_not_be_used)
          .frame(width: nil, height: 20)
          .font(Font.system(size: 15, design: .default))
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
          .disabled(true)
        }
        
        VStack(alignment: .leading, spacing: 20) {
          Text(verbatim: "Last Name")
          .font(Font.system(size: 12, design: .default))
          .fontWeight(.bold)
          .foregroundColor(Color(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0))
          .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
          
          TextField(last_name, text: $last_name_that_should_not_be_used)
          .frame(width: nil, height: 20)
          .font(Font.system(size: 15, design: .default))
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
          .disabled(true)
        }
      }
      
      Divider()
      
      HStack(alignment: .center, spacing: 7) {
           
           VStack(alignment: .leading, spacing: 20) {
             Text(verbatim: "Major")
             .font(Font.system(size: 12, design: .default))
             .fontWeight(.bold)
             .foregroundColor(Color(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0))
             .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
             
             TextField("", text: $major)
             .frame(width: nil, height: 20)
             .font(Font.system(size: 15, design: .default))
             .textFieldStyle(RoundedBorderTextFieldStyle())
             .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
           }
      }
      
      Divider()
      
      HStack(alignment: .center, spacing: 7) {
         
         VStack(alignment: .leading, spacing: 20) {
           Text(verbatim: "Email")
           .font(Font.system(size: 12, design: .default))
           .fontWeight(.bold)
           .foregroundColor(Color(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0))
           .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
           
           TextField(email, text: $email_that_should_not_be_used)
           .frame(width: nil, height: 20)
           .font(Font.system(size: 15, design: .default))
           .textFieldStyle(RoundedBorderTextFieldStyle())
           .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
             .disabled(true)
         }
       }
      
      
      VStack {
        List {
          HStack {
            Text("Year")
          }
            HStack {
              Picker(selection: $yearsIndex, label: Text("")) {
                ForEach(0..<years.count) {                Text(self.years[$0]).foregroundColor(.secondary)
                }
              }
              .padding(EdgeInsets(top: -55, leading: 0, bottom: 0, trailing: 40))
            }
          }
        }
    }
  }
}

struct InitializeUserView_Previews: PreviewProvider {
  static var previews: some View {
    InitializeUserView()
  }
}
