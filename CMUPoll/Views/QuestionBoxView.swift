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
  
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      TextField("Question #"
        , text: $title)
        .font(Font.system(size: 20, design: .default))
        .foregroundColor(Color.gray)
        .textFieldStyle(PlainTextFieldStyle())
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
      Rectangle()
        .fill(Color.gray)
        .frame(width: nil, height: 0.5)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 10))
      
      VStack(alignment: .leading, spacing: 16) {
        Stepper(value: $quantity, in: 1...10, label:
          {
            Text(verbatim: "Number of Questions: \(quantity)")
              .font(Font.system(size: 15, design: .default))
              .foregroundColor(Color.gray)}
        )
      }
      
      //      QuestionBoxTextView(question: question)
      ForEach (0 ..< quantity) { number in
        RadioButtonQuestionView()
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

struct QuestionBoxView_Previews: PreviewProvider {
  static var previews: some View {
    QuestionBoxView()
  }
}
