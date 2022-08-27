//  Buttons.swift
//  ArchieHome
//
//  Created by Mark Parker on 02.08.2022.
//

import SwiftUI

struct PrimaryButton: View {

    public let text: String
    public let style: PrimaryButtonStyle
    public var filled: Bool = true
    public let action: () -> Void

    enum PrimaryButtonStyle {
        case primary
        case secondary
        case danger
    }

    var body: some View {
        Button(action: action) {
            if filled {
                base
                    .background(color.opacity(0.75))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 3)
                            .foregroundColor(.black)
                            .opacity(0.3)
                        
                    )
                    .cornerRadius(10)
                    .clipped()
            } else {
                base
            }
        }
    }

    @ViewBuilder
    var base: some View {
        Text(text)
            .font(.title2)
            .fontWeight(filled ? .semibold : .regular)
            //.minimumScaleFactor(0.5)
            .lineLimit(1)
            .foregroundColor(filled ? .white : color)
            .padding()
            .frame(maxWidth:.infinity)
            //.textCenter()
    }
}

extension PrimaryButton {
    var color: Color {
        switch style {
        case .primary:
            return Color.blue
        case .secondary:
            return Color.gray
        case .danger:
            return Color.red
        }
    }
}

// MARK: - Previews

struct PrimaryButton_Previews: PreviewProvider {
    static private var preview: some View {
        VStack {
            PrimaryButton(text: "Primary Filled", style: .primary, action: {})
            PrimaryButton(text: "Secondary Filled", style: .secondary, action: {})
            PrimaryButton(text: "Danger Filled", style: .danger, action: {})
                .padding(.bottom, 50)
            PrimaryButton(text: "Primary Light", style: .primary, filled: false, action: {})
            PrimaryButton(text: "Secondary Light", style: .secondary, filled: false, action: {})
            PrimaryButton(text: "Danger Light", style: .danger, filled: false, action: {})
        }
        .padding()
    }

    static var previews: some View {
        preview
            .preferredColorScheme(.light)
        preview
            .preferredColorScheme(.dark)
    }
}

