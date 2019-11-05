//
//  AnswerGraphView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct AnswerGraphView: View {
  var question = "Most productive study place?"
  var options = ["Prof. H", "Prof. Z", "Prof. K"]
  @State private var selectedAnswer = 0
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      AnswerBoxTextView(question: question)
      TotalAnswerNumberView(number: 40)
        .padding(.top, -8)
        .padding(.bottom, 7)
      BarGraphView(bars: [
         Bar(id: UUID(), value: 20, label: "Prof.H", legend: Legend(color: Color.accentColor, label: "Prof.H")),
         Bar(id: UUID(), value: 5, label: "Prof.Z", legend: Legend(color: Color(red: 196 / 255.0, green: 196 / 255.0, blue: 196 / 255.0), label: "Prof.Z")),
         Bar(id: UUID(), value: 10, label: "Prof.K", legend: Legend(color: Color(red: 196 / 255.0, green: 196 / 255.0, blue: 196 / 255.0), label: "Prof.K")),
       ])
      ButtonView(text : "Edit Response", outline: Color.accentColor, backgroundColor: Color.white, textColor: Color.accentColor)
        .padding(.top, 56)
    }
    .padding(30)
    .border(Color(red: 235 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, opacity: 0.6))
    .cornerRadius(8)
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
    AnswerGraphView()
  }
}
