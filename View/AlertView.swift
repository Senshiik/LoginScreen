//
//  AlertView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 23.08.2022.
//

import SwiftUI

struct AlertView: View {
    var body: some View {
            Text("Your email or password is wrong!")
        .font(.title2)
        .minimumScaleFactor(0.5)
        .lineLimit(1)
        .padding()
        .frame(maxWidth:.infinity)
        .foregroundColor(.white)
        .background(Color("salmon"))
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
            .preferredColorScheme(.light)
        AlertView()
            .preferredColorScheme(.dark)
        
    }
}
