//
//  TextEditor.swift
//  
//
//  Created by Adrian Schönig on 23/5/2022.
//

import SwiftUI
import UIKit

@_exported import Runestone

public struct TextEditor: UIViewRepresentable {
  
  @StateObject private var preparer = StatePreparer()
  
  @Environment(\.themeFontSize) var themeFontSize
  
  public let text: Binding<String>
  let actualTheme: OverridingTheme
  public var theme: Theme { actualTheme.base }
  public let language: TreeSitterLanguage?
  public let configuration: Configuration
  
  public init(text: Binding<String>, theme: Theme, language: TreeSitterLanguage? = nil, configuration: Configuration = .init()) {
    self.text = text
    self.actualTheme = OverridingTheme(base: theme)
    self.language = language
    self.configuration = configuration
  }

  public func makeUIView(context: Context) -> UIView {
    let textView = TextView()
    textView.apply(configuration)
    
    textView.editorDelegate = preparer
    preparer.configure(text: text, theme: actualTheme, language: language) { state in
      textView.setState(state)
    }
    
    // We assume your theme matches the device's mode
    textView.backgroundColor = .systemBackground
    
    return textView
  }
  
  public func updateUIView(_ uiView: UIView, context: Context) {
    guard let textView = uiView as? TextView else { return assertionFailure() }
    
    // Update from context, such as...
    switch context.environment.disableAutocorrection {
    case .none:        textView.autocorrectionType = .default
    case .some(false): textView.autocorrectionType = .yes
    case .some(true):  textView.autocorrectionType = .no
    }
    
    if let fontSize = themeFontSize, fontSize != actualTheme.font.pointSize {
      actualTheme.font = UIFont(descriptor: theme.font.fontDescriptor, size: fontSize)
      textView.theme = actualTheme
    }
  }
}

extension TextEditor {
  public init(text: String, theme: Theme, language: TreeSitterLanguage? = nil, configuration: Configuration = .init()) {
    var config = configuration
    config.isEditable = false
    self.init(text: .constant(text), theme: theme, language: language, configuration: config)
  }
}

fileprivate class StatePreparer: ObservableObject {
  var text: Binding<String>?
  
  func configure(text: Binding<String>, theme: Theme, language: TreeSitterLanguage?, completion: @escaping (TextViewState) -> Void) {
    self.text = text
    
    DispatchQueue.global(qos: .background).async {
      let state: TextViewState
      if let language = language {
        state = TextViewState(text: text.wrappedValue, theme: theme, language: language)
      } else {
        state = TextViewState(text: text.wrappedValue, theme: theme)
      }
      DispatchQueue.main.async {
        completion(state)
      }
    }
  }
}

extension StatePreparer: Runestone.TextViewDelegate {
  func textViewDidChange(_ textView: TextView) {
    text?.wrappedValue = textView.text
  }
}

// MARK: .themeFontSize

public struct ThemeFontSizeKey: EnvironmentKey {
  public static let defaultValue: Double? = nil
}

extension EnvironmentValues {
  public var themeFontSize: Double? {
    get { self[ThemeFontSizeKey.self] }
    set { self[ThemeFontSizeKey.self] = newValue }
  }
}

extension View {
  
  /// Overrides the font size of the `RunestoneUI.TextEditor`'s theme
  /// - Parameter size: Text size in points
  public func themeFontSize(_ size: Double) -> some View {
    environment(\.themeFontSize, size)
  }
}
