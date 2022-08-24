//
//  SafariViewController.swift
//  LoginScreen
//
//  Created by Anton Demkin on 15.08.2022.
//

import SwiftUI
import SafariServices

struct SafariViewController: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SafariViewController_Previews: PreviewProvider {
    static var previews: some View {
        SafariViewController()
    }
}

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
}
