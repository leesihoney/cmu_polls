//
//  AnswerBoxView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import UIKit
import RadioGroup

struct AnswerBoxView: View {
  var question: Question
  let onNewAnswer: () -> Void
  @State var options = [Option]()
  @State private var selectedAnswer = 0
  @State var user: User? = User.current
  @State var initialized: Bool = false
  @State private var showingAlert = false

  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      AnswerBoxTextView(question: question.title)
      if (self.initialized) {
        RadioGroupPicker(
          selectedIndex: $selectedAnswer,
          titles: options.map{ $0.text },
          selectedColor: UIColor(red: 57 / 255.0, green: 57 / 255.0, blue: 57 / 255.0, alpha: 0.6),
          isVertical: true,
          buttonSize: 18.0,
          spacing: 6,
          itemSpacing: 21,
          isButtonAfterTitle: false,
          titleColor: UIColor(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0, alpha: 0.6),
          titleAlignment: .left,
          titleFont: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        )
          .fixedSize()
          //      .border(Color(red: 235 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, opacity: 0.6))
          .accentColor(Color(red: 151 / 255.0, green: 151 / 255.0, blue: 151 / 255.0, opacity: 1.0))
      }
      Button(action: {
        let option: Option = self.options[self.selectedAnswer]
        guard let user = User.current else {
          return
        }
        // To add points for answering a poll
        self.question.userHasAnswer(completion: { bool in
          if !bool {
            User.current?.addPoints(type: .answer)
            self.user!.update(major: self.user?.major, graduation_year: self.user?.graduation_year, points: User.current?.points, completion: {
            })
          }
        })
        Answer.withQuestionUser(question_id: self.question.id, user_id: user.id, completion: { answer in
          if var answer = answer {
            answer.update(user_id: user.id, question_id: self.question.id, option_id: option.id, completion: {
              self.onNewAnswer()
            })
          } else {
            Answer.create(question_id: self.question.id, option_id: option.id, completion: { answer in
              self.onNewAnswer()
            })
            self.showingAlert = true
          }
        })
      }
        
      ) {
        Text("Submit")
      }
      .buttonStyle(PollButtonStyle())
      .alert(isPresented: $showingAlert) {
      Alert(title: Text("Congratualations, you earned 5 points"), message: Text("You can use points to transfer into your bank"), dismissButton: .default(Text("OK")))
      }
    }
    .padding(30)
    .border(Color(red: 235 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, opacity: 0.6))
    .cornerRadius(8)
    .onAppear {
      self.initialized = false
      self.getQuestionOptions()
    }
  }
  
  func getQuestionOptions() {
    self.question.options(completion: { options in
      DispatchQueue.main.async {
        self.options = Option.sort(options)
        self.initialized = true
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
      .fixedSize(horizontal: false, vertical: true)
  }
}

//struct AnswerBoxView_Previews: PreviewProvider {
//  static var previews: some View {
//    AnswerBoxView(question: Question(id: "1", is_multiple_choice: true, title: "Sample title", poll_id: "1"), onNewAnswer: {})
//  }
//}
