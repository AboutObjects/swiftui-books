//
//  Created 7/6/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    
    var text: String
    let webView: WKWebView
    let css = """
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
    body {
        font-family: Didot;
        font-size: 16;
        padding: 1em;
        background: #dcb;
    }
    </style>
    """

    init(text: String = "") {
        self.text = text
        webView = WKWebView(frame: .zero)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.loadHTMLString(css + text, baseURL: nil)
    }
}

#Preview {
    WebView(text: TestData.synopsis)
}

