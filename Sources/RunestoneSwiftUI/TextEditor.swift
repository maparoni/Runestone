//
//  SwiftUITextView.swift
//  
//
//  Created by Adrian Schönig on 23/5/2022.
//

import SwiftUI
import UIKit

@_exported import Runestone

public struct TextEditor: UIViewRepresentable {
  
  @StateObject private var preparer = StatePreparer()
  
  public let text: Binding<String>
  public let theme: Theme
  public let language: TreeSitterLanguage?
  public let configuration: TextView.Configuration
  
  public init(text: Binding<String>, theme: Theme, language: TreeSitterLanguage? = nil, configuration: TextView.Configuration = .init()) {
    self.text = text
    self.theme = theme
    self.language = language
    self.configuration = configuration
  }

  public func makeUIView(context: Context) -> UIView {
    let textView = TextView()
    textView.apply(configuration)
    
    textView.editorDelegate = preparer
    preparer.configure(text: text, theme: theme, language: language)
    
    return textView
  }
  
  public func updateUIView(_ uiView: UIView, context: Context) {
    if let state = preparer.state {
      (uiView as! TextView).setState(state)
    }
  }
}

extension TextEditor {
  public init(text: String, theme: Theme, language: TreeSitterLanguage? = nil, configuration: TextView.Configuration = .init()) {
    var config = configuration
    config.isEditable = false
    self.init(text: .constant(text), theme: theme, language: language, configuration: config)
  }
}

fileprivate class StatePreparer: ObservableObject {
  @Published var state: TextViewState?
  
  var text: Binding<String>?
  
  func configure(text: Binding<String>, theme: Theme, language: TreeSitterLanguage?) {
    self.text = text
    
    DispatchQueue.global(qos: .background).async {
      let state: TextViewState
      if let language = language {
        state = TextViewState(text: text.wrappedValue, theme: theme, language: language)
      } else {
        state = TextViewState(text: text.wrappedValue, theme: theme)
      }
      DispatchQueue.main.async {
        self.state = state
      }
    }
  }
}

extension StatePreparer: Runestone.TextViewDelegate {
  func textViewDidChange(_ textView: TextView) {
    text?.wrappedValue = textView.text
  }
}
