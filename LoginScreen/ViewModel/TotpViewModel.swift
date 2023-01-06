//
//  TotpViewModel.swift
//  LoginScreen
//
//  Created by Anton Demkin on 12.12.2022.
//

import Foundation
import SwiftUI
import Combine

class TotpViewModel: ObservableObject {
    
    @Published public var code: String = ""
    private var lastCode: String = ""
    private var cancellables: [AnyCancellable] = []
    weak var delegate: TotpViewModelDelegate?
    
    init(delegate: TotpViewModelDelegate?) {
        self.delegate = delegate
        $code.sink { [weak self] newCode in
            if newCode.count == 6 && newCode != self?.lastCode {
                self?.lastCode = newCode
                self?.delegate?.didEnterCode(code: newCode)
                print("Yaay", newCode)
            }
        }.store(in: &self.cancellables)

    }
}
protocol TotpViewModelDelegate: AnyObject {
    func didEnterCode(code: String)
}
