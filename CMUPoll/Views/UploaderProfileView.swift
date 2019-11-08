//
//  UploaderProfileView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/06.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct UploaderProfileView: View {
  let profile = Image("user_pic")
  let uploaderName: String
  let uploaderMajor: String
  let uploaderGraduationYear: String
  
  var body: some View {
    HStack(alignment: .center, spacing: 7) {
      profile
      VStack(alignment: .leading, spacing: 6) {
        HStack(alignment: .firstTextBaseline, spacing: 7) {
          Text(self.uploaderName)
            .bold()
            .font(Font.system(size: 12, design: .default))
        }
        Text("\(self.uploaderMajor) • Class of \(self.uploaderGraduationYear)")
          .font(Font.system(size: 10, design: .default))
          .foregroundColor(Color.gray)
      }
    }
  }
}

struct UploaderProfileView_Previews: PreviewProvider {
  static var previews: some View {
    UploaderProfileView(uploaderName: "Aiden Lee", uploaderMajor: "Information Systems", uploaderGraduationYear: "2020")
  }
}
