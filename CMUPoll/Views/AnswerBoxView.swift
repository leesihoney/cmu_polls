//
//  AnswerBoxView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import UIKit

struct AnswerBoxView: View {
  var question: Question
  @State var options = [Option]()
  @State private var selectedAnswer = 0
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      AnswerBoxTextView(question: question.title)
      RadioButtonView(options: options)
      ButtonView(text : "Click Me", outline: Color.accentColor, backgroundColor: Color.accentColor, textColor: Color.white)
    }
    .padding(30)
    .border(Color(red: 235 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, opacity: 0.6))
    .cornerRadius(8)
    .onAppear {
      self.getQuestionOptions()
    }
  }
  
  func getQuestionOptions() {
    self.question.options(completion: { options in
      DispatchQueue.main.async {
        self.options = options
      }
    })
  }
}

struct AnswerBoxTextView: View {
  var question: String
  
  var body: some View {
    Text(self.question)
      .font(Font.system(size: 20, design: .default))
      .fontWeight(.semibold)
      .foregroundColor(Color(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0, opacity: 1.0))
  }
}

struct AnswerBoxView_Previews: PreviewProvider {
  static var previews: some View {
    AnswerBoxView(question: Question(id: "1", is_multiple_choice: true, title: "Sample title", poll_id: "1"))
  }
}
