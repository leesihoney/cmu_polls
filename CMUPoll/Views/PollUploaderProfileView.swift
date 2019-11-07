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
  let uploaderGraduationYear: String
  let uploadedDaysAgo: String
  
  var body: some View {
    HStack(alignment: .center, spacing: 7) {
      profile
      VStack(alignment: .leading, spacing: 6) {
        HStack(alignment: .firstTextBaseline, spacing: 7) {
          Text(uploaderName)
            .bold()
            .font(Font.system(size: 12, design: .default))
          Text("\(uploaderMajor) • Class of \(uploaderGraduationYear)")
            .font(Font.system(size: 10, design: .default))
            .foregroundColor(Color.gray)
        }
        Text("updated \(self.uploadedDaysAgo) days ago")
          .font(Font.system(size: 10, design: .default))
          .foregroundColor(Color.gray)
      }
    }
    
  }
}

struct PollUploaderProfileView_Previews: PreviewProvider {
  static var previews: some View {
    PollUploaderProfileView(uploaderName: "Aiden Lee", uploaderMajor: "Information Systems", uploaderGraduationYear: "2020", uploadedDaysAgo: "29")
  }
}
