//
//  TotpViewModel.swift
//  LoginScreen
//
//  Created by Anton Demkin on 12.12.2022.
//

import Foundation
import SwiftUI

class TotpViewModel: ObservableObject {
    
    @Published public var code: String = ""
    weak var delegate: TotpViewModelDelegate?
    init(delegate: TotpViewModelDelegate?) {
        self.delegate = delegate

    }
}
protocol TotpViewModelDelegate: AnyObject {
    func didEnterCode(code: String)
}
