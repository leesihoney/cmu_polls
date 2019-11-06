//
//  ButtonView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import UIKit

struct ButtonView: View {
  var text: String
  var outline: Color
  var backgroundColor: Color
  var textColor: Color
  
  init(text: String, outline: Color, backgroundColor: Color, textColor: Color) {
    self.text = text
    self.outline = outline
    self.backgroundColor = backgroundColor
    self.textColor = textColor
  }
  var body: some View {
    Button(
      action: {
        print("Button Clicked")
    },
      label: { Text(self.text) }
    )
      .frame(width: 290)
      .padding(.vertical, 5)
      .background(self.backgroundColor)
      .foregroundColor(self.textColor)
      .cornerRadius(6)
      .border(self.outline, width: 1)
    
  }
}

struct ButtonView_Previews: PreviewProvider {
  static var previews: some View {
    ButtonView(text: "Edit Button", outline: Color.accentColor, backgroundColor: Color.white, textColor: Color.accentColor)
  }
}
