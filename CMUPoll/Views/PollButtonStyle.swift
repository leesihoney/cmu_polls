//
//  PollButtonStyle.swift
//  CMUPoll
//
//  Created by Sung on 11/7/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

public struct PollButtonStyle: ButtonStyle {
  
  public func makeBody(configuration: Configuration) -> some View{
    configuration.label
      .frame(width: 290)
      .padding(.vertical, 5)
      .background(Color.accentColor)
      .foregroundColor(Color.white)
      .cornerRadius(6)
      .border(Color.accentColor, width: 1)
  }
  
}

public struct OutlineButtonStyle: ButtonStyle {
  
  public func makeBody(configuration: Configuration) -> some View{
    configuration.label
      .frame(width: 290)
      .padding(.vertical, 5)
      .background(Color.white)
      .foregroundColor(Color.accentColor)
      .cornerRadius(6)
      .border(Color.accentColor, width: 1)
  }
  
}
