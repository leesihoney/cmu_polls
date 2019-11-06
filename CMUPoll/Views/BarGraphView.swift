//
//  BarGraphView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct BarGraphView: View {
  let bars: [Bar]
  
  var body: some View {
    Group {
      if bars.isEmpty {
        Text("There is no data to display chart...")
      } else {
        HStack(alignment: .center, spacing: 17) {
          LegendsView(bars: bars)
          BarsView(bars: bars)
        }
      }
    }
  }
}

struct Bar: Identifiable {
  let id: UUID
  let value: Int
  let label: String
  let legend: Legend
}

struct Legend: Hashable {
  let color: Color
  let label: String
}

struct LegendsView: View {
  let bars: [Bar]
  var body: some View {
    VStack(alignment: .leading, spacing: 26) {
      ForEach(bars) { bar in
        Text(bar.legend.label)
          .foregroundColor(bar.legend.color)
          .font(Font.system(size: 12, design: .default))
      }
    }
  }
}


struct BarsView: View {
  let bars: [Bar]
  let max: Double
  
  init(bars: [Bar]) {
    self.bars = bars
    self.max = bars.map { Double($0.value) }.max() ?? 0
  }
  var body: some View {
    GeometryReader { geometry in
      
      VStack(alignment: .leading, spacing: 21) {
        ForEach(self.bars) { bar in
          HStack(spacing: 12) {
            Rectangle()
              .fill(bar.legend.color)
              .frame(width: CGFloat(bar.value) / CGFloat(self.max) * (geometry.size.width-32), height: 20)
              .overlay(Rectangle().stroke(Color.white))
            Text(verbatim: "\(bar.value)")
              .font(Font.system(size: 12, design: .default))
              .foregroundColor(bar.legend.color)
          }
        }
      }
    }
  }
}


struct BarGraphView_Previews: PreviewProvider {
  static var previews: some View {
    BarGraphView(bars: [
      Bar(id: UUID(), value: 20, label: "Prof.H", legend: Legend(color: Color.accentColor, label: "Prof.H")),
      Bar(id: UUID(), value: 5, label: "Prof.Z", legend: Legend(color: Color(red: 196 / 255.0, green: 196 / 255.0, blue: 196 / 255.0), label: "Prof.Z")),
      Bar(id: UUID(), value: 10, label: "Prof.K", legend: Legend(color: Color(red: 196 / 255.0, green: 196 / 255.0, blue: 196 / 255.0), label: "Prof.K")),
    ])
  }
}

