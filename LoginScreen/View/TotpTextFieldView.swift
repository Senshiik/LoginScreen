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
    @State var pin: String = ""
    @State var showPin = true
    weak var delegate: TotpViewModelDelegate?
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
        let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
            self.pin = newValue
            if pin.count == 6 {
                model.delegate?.didEnterCode(code: pin)
                return
            }
            self.submitPin()
        })
        return TextField("", text: boundPin, onCommit: submitPin)
           .accentColor(.clear)
           .foregroundColor(.clear)
           .keyboardType(.numberPad)
    }
    
    private func submitPin() {
        guard !pin.isEmpty else {
            showPin = true
            return
        }
    }
    
    private func getImageName(at index: Int) -> String {
        if index >= self.pin.count {
            return "circle"
        }
        
        if self.showPin {
            return self.pin.digits[index].numberString + ".circle"
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
