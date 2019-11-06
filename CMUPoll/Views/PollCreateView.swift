//
//  PollCreateView.swift
//  CMUPoll
//
//  Created by Aiden on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct PollCreateView: View {
  let profile = Image("user_pic")
  @State var title = ""
  @State var tag = ""
  @State var description = ""
  @State var quantity: Int = 1

  
  var body: some View {
    VStack(alignment: .leading, spacing: 70) {
      HStack(alignment: .center, spacing: 7) {
        profile
        VStack(alignment: .leading, spacing: 6) {
          HStack(alignment: .firstTextBaseline, spacing: 7) {
            Text("Aiden Lee")
              .bold()
              .font(Font.system(size: 12, design: .default))
          }
          Text("Information Systems • Class of 2020")
          .font(Font.system(size: 10, design: .default))
          .foregroundColor(Color.gray)
        }
      }
      
      VStack(alignment: .leading, spacing: 13) {
        TextField("Enter title", text: $title)
          .font(Font.system(size: 30, design: .default))
          .textFieldStyle(PlainTextFieldStyle())
          .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
        Rectangle()
          .fill(Color.gray)
          .frame(width: nil, height: 0.5)
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 10))



        Text(verbatim: "Tags")
          .font(Font.system(size: 15, design: .default))
          .foregroundColor(Color.gray)
        TextField("", text: $tag)
          .frame(width: nil, height: 20)
          .font(Font.system(size: 15, design: .default))
          .textFieldStyle(PlainTextFieldStyle())
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
        Rectangle()
          .fill(Color.gray)
          .frame(width: nil, height: 0.5)
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 10))


        Text(verbatim: "Description")
          .font(Font.system(size: 15, design: .default))
          .foregroundColor(Color.gray)
        TextField("", text: $description)
          .frame(width: nil, height: 20)
          .font(Font.system(size: 15, design: .default))
          .textFieldStyle(PlainTextFieldStyle())
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 10))
        Rectangle()
          .fill(Color.gray)
          .frame(width: nil, height: 0.5)
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 10))
         
        
        Stepper(value: $quantity, in: 1...10, label:
          {
            Text(verbatim: "Number of Questions: \(quantity)")
              .font(Font.system(size: 15, design: .default))
              .foregroundColor(Color.gray)}
          )
        
        VStack(alignment: .leading, spacing: 13) {
          QuestionBoxView().padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
          
          }
        }

    }
    .frame(minWidth: 0, maxWidth: .infinity, idealHeight: 188.0, alignment: .center)
    .padding(.vertical, 25)
    .padding(.horizontal, 15)
    
  }
}

struct PollCreateView_Previews: PreviewProvider {
  static var previews: some View {
    PollCreateView()
  }
}
