//
//  ContentView.swift
//  Understanding-Binding
//
//  Created by Mohammad Azam on 7/3/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//
import SwiftUI

struct PollCheckView : View {
  
  let poll: Poll
  //    @State var isOn: Bool = false
  @State private var passcode: String = ""
  @State private var verified: Bool = false
  @State private var showingAlert = false
  let callBack: () -> Void
  
  
  @Environment(\.presentationMode) var presentation
  
  var body: some View {
    KeyboardHost {
      Group {
        if verified {
          PollDetailView(poll: self.poll, callBack: self.callBack)
        } else {
          VStack {
            Text(self.passcode.count == 0 ? "🙈" : "🐵")
              .font(Font.system(size: 80, design: .default))
            
            VStack {
              Text("\(self.poll.title)")
                .font(Font.system(size: 20, design: .default))
                .fontWeight(.semibold)
                .lineSpacing(8)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
                                    
            SecureField("Enter Passcode To See This Poll", text: $passcode)
              .frame(width: nil, height: 20)
              .font(Font.system(size: 15, design: .default))
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding().background(Color("flash-white"))
              .cornerRadius(4.0)
              .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
              .multilineTextAlignment(.center)
            
            Button(action: {
              if self.passcode == self.poll.passcode {
                print("You got it!")
                self.verified = true
              }
              else {
                print("You entered wrong passcode for the poll!")
                self.showingAlert = true
                self.passcode = ""
              }
            }) {
              Text("Enter")
            }
            .alert(isPresented: $showingAlert) {
              Alert(title: Text("Wrong Passcode"),  dismissButton: .default(Text("Retry")))
            }
          }
        }
      }
      .navigationBarItems(leading: Button (
        action: {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.presentation.wrappedValue.dismiss()
          }
      }, label: { Text("Back") }
      ))
    }
    
  }
}

//#if DEBUG
//struct PollCheckView_Previews : PreviewProvider {
//    static var previews: some View {
//        PollCheckView()
//    }
//}
//#endif
