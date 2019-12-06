//
//  BarGraphView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct BarGraphView: View {
  @State var bars: [Bar]
  @State var userAnswer: String
  @State var toggleColorChanged = false
  
  var body: some View {
    Group {
      HStack(alignment: .center, spacing: 17) {
        if self.toggleColorChanged {
          BarsView(bars: bars)
        }
      }
    }.onAppear {
      self.toggleColorChanged = true
      self.resetBarWithHighestValue()
    }
  }
  
  func resetBarWithHighestValue() {
    if bars.count == 0 {
      return
    }
    
    for bar in bars {
      if bar.id == self.userAnswer {
        bar.color = Color.accentColor
      }
    }
    
    self.toggleColorChanged = true
  }
}

struct BarsView: View {
  @State var bars: [Bar]
  var body: some View {
    Group {
      VStack(alignment: .leading, spacing: 26) {
        ForEach(bars) { bar in
          Text(bar.label)
            .foregroundColor(bar.color)
            .font(Font.system(size: 12, design: .default))
        }
      }
      
      GeometryReader { geometry in
        VStack(alignment: .leading, spacing: 21) {
          ForEach(self.bars) { bar in
            HStack(spacing: 12) {
              Rectangle()
                .fill(bar.color)
                .frame(width: CGFloat(bar.value) / CGFloat(self.bars.map { Double($0.value) }.max() ?? 0) * (geometry.size.width-32), height: 20)
                .overlay(Rectangle().stroke(Color.white))
              Text(verbatim: "\(bar.value)")
                .font(Font.system(size: 12, design: .default))
                .foregroundColor(bar.color)
            }
          }
        }
      }
    }
  }
}

class Bar: Identifiable {
  let id: String
  let value: Int
  let label: String
  
  let blue = Color.accentColor
  let gray = Color(red: 196 / 255.0, green: 196 / 255.0, blue: 196 / 255.0)
  var color: Color
  
  init(id: String, value: Int, label: String) {
    self.id = id
    self.value = value
    self.label = label
    self.color = gray
  }
  
  func toBlue() { self.color = blue }
}

//struct BarGraphView_Previews: PreviewProvider {
//  static var previews: some View {
//    BarGraphView(bars: [
//      Bar(id: "1", value: 20, label: "Prof.H"),
//      Bar(id: "2", value: 5, label: "Prof.Z"),
//      Bar(id: "3", value: 10, label: "Prof.K"),
//    ], userAnswer: "1")
//  }
//}

