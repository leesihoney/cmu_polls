//
//  HiddenNavigationLink.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/12/03.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct HiddenNavigationLink<Destination : View>: View {
    public var destination: Destination
    public var isActive: Binding<Bool>

    var body: some View {

        NavigationLink(destination: self.destination, isActive: self.isActive)
        { EmptyView() }
            .frame(width: 0, height: 0)
            .disabled(true)
            .hidden()
    }
}

struct ActivateButton<Label> : View where Label : View {

    public var activates: Binding<Bool>
    public var label: Label

    public init(activates: Binding<Bool>, @ViewBuilder label: () -> Label) {
        self.activates = activates
        self.label = label()
    }

    var body: some View {
        Button(action: { self.activates.wrappedValue = true }, label: { self.label } )
    }
}
