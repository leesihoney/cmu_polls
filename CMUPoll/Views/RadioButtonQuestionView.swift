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
  @State var choice = ""
  
  @State private var selectedAnswer = -1
  
  @State var onOption: (String) -> Void
  var body: some View {
    
    VStack(alignment: .center, spacing: 7) {
      TextField("Choice", text: $choice, onEditingChanged: { changed in
        self.onOption(self.choice)
      })
        .frame(width: nil, height: 20)
        .font(Font.system(size: 15, design: .default))
        .textFieldStyle(PlainTextFieldStyle())
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
      Rectangle()
        .fill(Color.gray)
        .frame(width: nil, height: 0.5)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 30))
    }
    
  }
  
}
//struct RadioButtonQuestionView_Previews: PreviewProvider {
//  static var previews: some View {
//    RadioButtonQuestionView()
//  }
//}
