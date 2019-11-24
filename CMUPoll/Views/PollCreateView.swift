//
//  PollCreateView.swift
//  CMUPoll
//
//  Created by Aiden on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

class QuestionInput {
  var title: String = ""
  var optionInputs: [String] = ["", "", ""]
  
  func changeTitle(title: String) {
    self.title = title
  }
  
  func changeOptionString(idx: Int, optionString: String) {
    self.optionInputs[idx] = optionString
  }
  
  func addOption() {
    self.optionInputs.append("")
  }
  
  func removeOption() {
    self.optionInputs.removeLast()
  }
}

struct PollCreateView: View {
  let profile = Image("user_pic")
  
  let refresh: () -> Void
  
//  @State var user_input = User.current?
  
  @State var user: User? = User.current
  @State var title = ""
  @State var tag = ""
  @State var description = ""
  @State var quantity: Int = 1
  @State var questions: [QuestionInput] = [QuestionInput()]
    
  @Environment(\.presentationMode) var presentationMode
  

  
  var body: some View {
    List {
      
      if (user != nil) {
        UploaderProfileView(uploaderName: "\(user!.first_name) \(user!.last_name)", uploaderMajor: user!.major, uploaderGraduationYear: String(user!.graduation_year ?? 2020))
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
      }
      
      VStack(alignment: .leading, spacing: 13) {
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
      }
      
      VStack(alignment: .leading, spacing: 13) {
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
      }
      
      Stepper(onIncrement: {
        if (self.quantity < 10) {
          self.quantity += 1
          self.questions.append(QuestionInput())
        }
      }, onDecrement: {
        if (self.quantity > 1) {
          self.quantity -= 1
          self.questions.removeLast()
        }
      }, label: {
          Text(verbatim: "Number of Questions: \(quantity)")
            .font(Font.system(size: 15, design: .default))
            .foregroundColor(Color.gray)
      }
      )
      
      VStack(alignment: .leading, spacing: 13) {
        ForEach (0 ..< quantity, id: \.self) { number in
          
          QuestionBoxView(onQuestion: self.questions[number].changeTitle,
                          onOption: self.questions[number].changeOptionString,
                          addOption: self.questions[number].addOption,
                          removeOption: self.questions[number].removeOption)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
      }
    }
      
    .navigationBarTitle(Text("Add Poll"), displayMode: .inline)
    .navigationBarItems(trailing:
      // TODO: should connect to a form view
      Button("Save") {
        Poll.create(title: self.title, description: self.description, link: "", is_private: false, is_closed: false, completion: { poll in
          print("the poll has been created!")
          for questionInput in self.questions {
            Question.create(is_multiple_choice: false, title: questionInput.title, poll_id: poll.id, completion: { question in
              for optionInput in questionInput.optionInputs {
                Option.create(text: optionInput, question_id: question.id, completion: { option in
                  self.presentationMode.wrappedValue.dismiss()
                })
              }
            })
          }
          self.refresh()
        })
        self.user?.addPoints(type: .upload)
        print("\(self.user!.first_name) just earned 10 points!")
        self.user!.update(major: self.user?.major, graduation_year: self.user?.graduation_year, points: self.user?.points, completion: {
          print("the points has been updated into Firebase!")
          self.refresh()
        })
      }
    )
  }
}

//struct PollCreateView_Previews: PreviewProvider {
//  static var previews: some View {
//    PollCreateView()
//  }
//}
