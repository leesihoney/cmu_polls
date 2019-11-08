//
//  RadioButtonView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import RadioGroup

struct RadioButtonView: View {
  var options: [Option]
  @State private var selectedAnswer = 0
  var body: some View {
    RadioGroupPicker(
      selectedIndex: $selectedAnswer,
      titles: options.map{ $0.text },
      selectedColor: UIColor(red: 57 / 255.0, green: 57 / 255.0, blue: 57 / 255.0, alpha: 0.6),
      isVertical: true,
      buttonSize: 18.0,
      spacing: 17,
      itemSpacing: 21,
      isButtonAfterTitle: false,
      titleColor: UIColor(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0, alpha: 0.6),
      titleAlignment: .left,
      titleFont: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
    )
      .fixedSize()
      //      .border(Color(red: 235 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, opacity: 0.6))
      .accentColor(Color(red: 151 / 255.0, green: 151 / 255.0, blue: 151 / 255.0, opacity: 1.0))    }
}

struct RadioButtonView_Previews: PreviewProvider {
  static var previews: some View {
    RadioButtonView(options: [
      Option(id: "1", text: "Hunt Library", question_id: "1"),
      Option(id: "2", text: "Sorrells Library", question_id: "1"),
      Option(id: "3", text: "Au Bon Pain", question_id: "1"),
    ])
  }
}
