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
  @State var passcode = ""
  @State var title = ""
  @State var tag = ""
  @State var description = ""
  @State var quantity: Int = 1
  @State var questions: [QuestionInput] = [QuestionInput()]
  @State var is_private = false
  @State private var showingAlert = false
  
  @Environment(\.presentationMode) var presentation
  
  var body: some View {
    KeyboardHost {
      ScrollView {
        VStack(alignment: .leading) {
          if (self.user != nil) {
            UploaderProfileView(uploaderName: "\(self.user!.first_name) \(self.user!.last_name)", uploaderMajor: self.user!.major, uploaderGraduationYear: self.user!.graduation_year)
              .frame(alignment: .leading)
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
          
          HStack {
            Text(verbatim: "Private")
              .font(Font.system(size: 16, design: .default))
              .foregroundColor(Color.gray)
              .onTapGesture {
                withAnimation {
                  self.is_private.toggle()
                }
            }
            Spacer()
            if (is_private == true) {
              Image(systemName: "checkmark.square")
                .foregroundColor(.gray)
                .font(.system(size: 24))
                .onTapGesture {
                  self.is_private = false
              }
            } else {
              Image(systemName: "square")
                .foregroundColor(.gray)
                .font(.system(size: 24))
                .onTapGesture {
                  self.is_private = true
              }
            }
          }
          .padding(.vertical)
          
          if is_private {
            SecureField("Set Passcode", text: $passcode)
              .transition(.move(edge: .bottom))
              .font(Font.system(size: 15, design: .default))
              .textFieldStyle(PlainTextFieldStyle())
              .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
            .padding(.bottom)
          
          }
          
          VStack(alignment: .leading, spacing: 8) {
            Text(verbatim: "Tags (comma-separated)")
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
          .padding(.vertical)

          
          VStack(alignment: .leading, spacing: 8) {
            Text(verbatim: "Description")
              .font(Font.system(size: 15, design: .default))
              .foregroundColor(Color.gray)
            TextField("", text: $description)
              .frame(width: nil, height: 20)
              .font(Font.system(size: 15, design: .default))
              .textFieldStyle(PlainTextFieldStyle())
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            Rectangle()
              .fill(Color.gray)
              .frame(width: nil, height: 0.5)
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 10))
          }
          .padding(.vertical)

          
          HStack {
            Text(verbatim: "Number of Questions: \(quantity)")
              .font(Font.system(size: 15, design: .default))
              .foregroundColor(Color.gray)
            Spacer()
            Image(systemName: "minus.rectangle")
              .foregroundColor(.gray)
              .font(.system(size: 32))
              .onTapGesture {
                if (self.quantity > 1) {
                  self.quantity -= 1
                  self.questions.removeLast()
                }
            }
            Image(systemName: "plus.rectangle")
              .foregroundColor(.gray)
              .font(.system(size: 32))
              .onTapGesture {
                if (self.quantity < 10) {
                  self.quantity += 1
                  self.questions.append(QuestionInput())
                }
            }
          }
          .padding(.vertical)

          
          VStack(alignment: .leading, spacing: 13) {
            ForEach (0 ..< quantity, id: \.self) { number in
              QuestionBoxView(onQuestion: self.questions[number].changeTitle,
                              onOption: self.questions[number].changeOptionString,
                              addOption: self.questions[number].addOption,
                              removeOption: self.questions[number].removeOption)
            }
          }
          .padding(.vertical)

        }
        .navigationBarTitle(Text("Add Poll"), displayMode: .inline)
        .navigationBarItems(leading: Button (
          action: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              self.presentation.wrappedValue.dismiss()
              self.refresh()
            }
        }, label: { Text("Back") }
          ), trailing:
          // TODO: should connect to a form view
          Button(action: {
            self.savePoll()
          }) {
            Text("Save")
          }
          .alert(isPresented: $showingAlert) {
            Alert(title: Text("Congratualations, you earned 10 points"), message: Text("You can use points to transfer into your bank"), dismissButton: .default(Text("OK")))
          }
        )
      }
      .padding(15)
    }
  }
  
  func savePoll() {
    var getPasscode: String? = self.passcode
    if !self.is_private {
      getPasscode = nil
    }
    Poll.create(title: self.title, description: self.description, link: "", is_private: self.is_private, is_closed: false, passcode: getPasscode, completion: { poll in
      print("the poll has been created!")
      for questionInput in self.questions {
        Question.create(is_multiple_choice: false, title: questionInput.title, poll_id: poll.id, completion: { question in
          for optionInput in questionInput.optionInputs {
            Option.create(text: optionInput, question_id: question.id, completion: { option in
              self.presentation.wrappedValue.dismiss()
            })
          }
        })
      }
      let tagNames: [String] = Tag.parse(self.tag)
      for tagName in tagNames {
        Tag.create(name: tagName) { tag in
          PollTag.create(poll_id: poll.id, tag_id: tag.id, completion: { polltag in })
        }
      }
      self.refresh()
    })
    // To add points for uploading a poll
    if let user = self.user {
      user.addPoints(type: .upload)
      user.update(major: user.major, graduation_year: user.graduation_year, points: user.points, completion: {
        self.refresh()
      })
    }
    self.showingAlert = true
  }
}

//struct PollCreateView_Previews: PreviewProvider {
//  static var previews: some View {
//    PollCreateView()
//  }
//}
