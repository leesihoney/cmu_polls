//
//  AnswerBoxView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import UIKit

struct QuestionBoxView: View {
  var question = "Question #"
  @State var title = ""
  @State var quantity: Int = 3
  
  @State var onQuestion: (String) -> Void
  @State var onOption: (Int, String) -> Void
  @State var addOption: () -> Void
  @State var removeOption: () -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      TextField("Question", text: $title, onEditingChanged: { changed in
        self.onQuestion(self.title)
      })
        .font(Font.system(size: 20, design: .default))
        .foregroundColor(Color.gray)
        .textFieldStyle(PlainTextFieldStyle())
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
      Rectangle()
        .fill(Color.gray)
        .frame(width: nil, height: 0.5)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 10))
      
      VStack(alignment: .leading, spacing: 16) {
        Stepper(onIncrement: {
          if (self.quantity < 10) {
            self.quantity += 1
            self.addOption()
          }
        }, onDecrement: {
          if (self.quantity > 1) {
            self.quantity -= 1
            self.removeOption()
          }
        }, label:
          {
            Text(verbatim: "Number of Choices: \(quantity)")
              .font(Font.system(size: 15, design: .default))
              .foregroundColor(Color.gray)}
        )
      }
      
      ForEach (0 ..< quantity, id: \.self) { number in
        RadioButtonQuestionView(onOption: { optionString in
          self.onOption(number, optionString)
        })
      }
      
    }
    .padding(30)
    .border(Color(red: 235 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, opacity: 0.6))
    .cornerRadius(8)
  }
}

struct QuestionBoxTextView: View {
  var question: String
  
  var body: some View {
    Text(self.question)
      .font(Font.system(size: 20, design: .default))
      .fontWeight(.semibold)
      .foregroundColor(Color.gray)
  }
}

//struct QuestionBoxView_Previews: PreviewProvider {
//  static var previews: some View {
//    QuestionBoxView()
//  }
//}
