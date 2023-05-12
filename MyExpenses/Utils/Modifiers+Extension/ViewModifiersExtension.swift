//
//  ViewModifiersExtension.swift
//  MyExpenses
//
//  Created by Nathan Batista on 22/02/23.
//

import SwiftUI

//View modifier to add background
struct ViewBackgroundModifier: ViewModifier {
    let backgroundColor: Color
    func body(content: Content) -> some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            content
        }
    }
}

extension View {
    //Extension to add border to view to make it less verbose and not have to rewrite the code every time
    @ViewBuilder func addBorder<S>(_ content: S, lineWidth: CGFloat = 1, cornerRadius: CGFloat = 8) -> some View where S: ShapeStyle {
        self.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(content, lineWidth: lineWidth)
        )
        .cornerRadius(cornerRadius)
    }
    
    //Extension to add a gradient, could have used a modifier instead and the use of some instead of where like the example above
    @ViewBuilder func addGradient(_ content: some ShapeStyle) -> some View {
        self.background(content, ignoresSafeAreaEdges: .all)
    }
}
