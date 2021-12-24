//
//  ConditionalWrapper.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI

// Wrap view with some content given a condition
extension View {
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}
