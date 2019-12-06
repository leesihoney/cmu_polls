//
//  PollUploaderProfileView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/06.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct PollUploaderProfileView: View {
  let profile = Image("user_pic")
  let uploaderName: String
  let uploaderMajor: String
  let uploaderGraduationYear: Int?
  let uploadedDaysAgo: String
  @State private var majorGraduationYearText = ""
  
  var body: some View {
    HStack(alignment: .center, spacing: 7) {
      profile
      VStack(alignment: .leading, spacing: 6) {
        HStack(alignment: .firstTextBaseline, spacing: 7) {
          Text(uploaderName)
            .bold()
            .font(Font.system(size: 12, design: .default))
          Text(self.majorGraduationYearText)
            .font(Font.system(size: 10, design: .default))
            .foregroundColor(Color.gray)
            .fixedSize(horizontal: false, vertical: true)
        }
        Text("updated \(self.uploadedDaysAgo)")
          .font(Font.system(size: 10, design: .default))
          .foregroundColor(Color.gray)
      }
    }
    .onAppear {
      self.formatMajorGraduationYearText()
    }
    
  }
  
  func formatMajorGraduationYearText() {
    var inputMajor = self.uploaderMajor
    if inputMajor.count > 30 {
      inputMajor = inputMajor[inputMajor.startIndex..<inputMajor.index(inputMajor.endIndex, offsetBy: -15)] + "..."
    }
    if let uploaderGraduationYear = self.uploaderGraduationYear {
      self.majorGraduationYearText = "\(inputMajor) • Class of \(String(uploaderGraduationYear))"
    } else {
      self.majorGraduationYearText = "\(self.uploaderMajor)"
    }
  }
  
}

struct PollUploaderProfileView_Previews: PreviewProvider {
  static var previews: some View {
    PollUploaderProfileView(uploaderName: "Aiden Lee", uploaderMajor: "Information Systems", uploaderGraduationYear: 2020, uploadedDaysAgo: "29")
  }
}
