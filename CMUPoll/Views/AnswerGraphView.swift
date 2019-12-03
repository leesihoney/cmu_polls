//
//  AnswerGraphView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct AnswerGraphView: View {
  var question: Question
  @State var options = [Option]()
  @State var bars = [Bar]()
  @State private var selectedAnswer = 0
  let onEditedAnswer: () -> Void
  
  @State var numViews: Int?
  @State var user: User? = User.current
  @State var accumulatedBars: [Bar]?
  @State var numBars: Int?
  @State var initialized: Bool = false
  @State var userAnswer: String = ""
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      AnswerBoxTextView(question: question.title)
      if numViews != nil {
        TotalAnswerNumberView(number: numViews!)
          .padding(.top, -8)
          .padding(.bottom, 7)
      }
      if (self.initialized) {
        BarGraphView(bars: self.bars, userAnswer: self.userAnswer)
      } else {
        Text("Loading data for chart display...")
      }
      
      Button(action: {
        self.onEditedAnswer()
      }) {
        Text("Edit Response")
      }.buttonStyle(OutlineButtonStyle())
      
    }
    .padding(30)
    .border(Color(red: 235 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, opacity: 0.6))
    .cornerRadius(8)
    .onAppear {
      self.initialized = false
      self.getNumViews()
    }
  }
  
  func getNumViews() {
    self.question.answers(completion: { answers in
      DispatchQueue.main.async {
        self.numViews = answers.count
        self.getUserAnswer()
      }
    })
  }
  
  func getUserAnswer() {
    self.question.userAnswer(completion: { answer in
      if (answer != nil) {
        self.userAnswer = answer!.option_id
      }
      self.getOptions()
    })
  }
  
  func getOptions() {
    self.question.options(completion: { options in
      DispatchQueue.main.async {
        self.options = options
        self.getBars()
      }
    })
  }
  
  func accumulateBars(bar: Bar) {
    accumulatedBars!.append(bar)
    if (accumulatedBars!.count >= numBars!) {
      self.bars = accumulatedBars!
      self.initialized = true
    }
  }
  
  func getBars() {
    self.accumulatedBars = []
    self.numBars = self.options.count
    
    for option in self.options {
      option.answers(completion: { answers in
        DispatchQueue.main.async {
          let bar = Bar(id: option.id, value: answers.count, label: option.text)
          self.accumulateBars(bar: bar)
        }
      })
    }
  }
}

struct TotalAnswerNumberView: View {
  let number: Int
  var body: some View {
    Text("Total number of answers: \(number)")
      .font(Font.system(size: 12, design: .default))
      .foregroundColor(Color(red: 196 / 255.0, green: 196 / 255.0, blue: 196 / 255.0, opacity: 0.6))
  }
}

struct AnswerGraphView_Previews: PreviewProvider {
  static var previews: some View {
    AnswerGraphView(question: Question(id: "1", is_multiple_choice: true, title: "Sample title", poll_id: "1"), onEditedAnswer: {})
  }
}
