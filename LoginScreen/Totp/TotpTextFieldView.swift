//
//  TotpTextFieldView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 12.12.2022.
//

import SwiftUI
public struct TotpTextFieldView: View {
    
    var label = "Enter The One Time Password"
    
    @StateObject var model: TotpViewModel

    @State var showPin = true
    public var body: some View {
        VStack(spacing: 16) {
            Text(label).font(.title)
            ZStack {
                pinDots
                backgroundField
            }
        }
        
    }
    
    private var pinDots: some View {
        HStack {
            Spacer()
            ForEach(0..<6) { index in
                Image(systemName: self.getImageName(at: index))
                    .font(.system(size: 25, weight: .thin, design: .default))
                Spacer()
            }
        }
    }
    
    private var backgroundField: some View {
        TextField("", text: $model.code)
           .accentColor(.clear)
           .foregroundColor(.clear)
           .keyboardType(.numberPad)
    }
    
    private func getImageName(at index: Int) -> String {
        if index >= self.model.code.count {
            return "circle"
        }
        
        if self.showPin {
            return self.model.code.digits[index].numberString + ".circle"
        }
        
        return "circle.fill"
    }
}

extension String {
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        return result
    }
    
}

extension Int {
    
    var numberString: String {
        
        guard self < 10 else { return "0" }
        
        return String(self)
    }
}
