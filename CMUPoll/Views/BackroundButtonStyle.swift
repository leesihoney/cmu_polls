//
//  ButtonStyle.swift
//  CMUPoll
//
//  Created by Sung on 11/7/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation

public struct BackroundButtonStyle: BackroundButtonStyle {
    
    public func body(configuration: Button<Self.Label>, isPressed: Bool) -> some View {
        configuration
            .accentColor(.red)
            .padding()
            .background(.yellow)
            .cornerRadius(4)
    }
}
