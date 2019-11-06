//
//  RadioButtonView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import RadioGroup

struct RadioButtonQuestionView: View {
  var options = ["", "", ""]
  @State var description = ""
  @State var choice1 = ""
  @State var choice2 = ""
  @State var choice3 = ""
  
  @State private var selectedAnswer = -1
  var body: some View {
    HStack(alignment: .center, spacing: -10) {
    RadioGroupPicker(
      selectedIndex: $selectedAnswer,
      
      titles: options,
      isVertical: true,
      buttonSize: 18.0,
      spacing: 19,
      itemSpacing: 21,
      isButtonAfterTitle: false,
      titleColor: UIColor(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0, alpha: 0.6),
      titleAlignment: .left,
      titleFont: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
      )
      
      
    
      .fixedSize()
      .accentColor(Color(red: 151 / 255.0, green: 151 / 255.0, blue: 151 / 255.0, opacity: 1.0))
      
      VStack(alignment: .center, spacing: 7) {
        TextField("Choice", text: $choice1)
          .frame(width: nil, height: 20)
          .font(Font.system(size: 15, design: .default))
          .textFieldStyle(PlainTextFieldStyle())
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
        Rectangle()
          .fill(Color.gray)
          .frame(width: nil, height: 0.5)
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 30))
          
        TextField("Choice", text: $choice2)
          .frame(width: nil, height: 20)
          .font(Font.system(size: 15, design: .default))
          .textFieldStyle(PlainTextFieldStyle())
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
        Rectangle()
          .fill(Color.gray)
          .frame(width: nil, height: 0.5)
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 30))
        
        TextField("Choice", text: $choice3)
          .frame(width: nil, height: 20)
          .font(Font.system(size: 15, design: .default))
          .textFieldStyle(PlainTextFieldStyle())
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
        Rectangle()
          .fill(Color.gray)
          .frame(width: nil, height: 0.5)
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 30))
        
      }
      
      
    }
}

}
struct RadioButtonQuestionView_Previews: PreviewProvider {
  static var previews: some View {
    RadioButtonQuestionView()
  }
}
