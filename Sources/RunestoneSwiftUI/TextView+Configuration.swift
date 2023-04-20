//
//  TextView+Configuration.swift
//  
//
//  Created by Adrian Schönig on 23/5/2022.
//

import UIKit

@_exported import Runestone

extension TextEditor {
  
  /// Configuration options of the TextEditor
  public struct Configuration {
    public init(isEditable: Bool = true, showLineNumbers: Bool = false) {
      self.isEditable = isEditable
      self.showLineNumbers = showLineNumbers
    }
    
    /// A Boolean value that indicates whether the text view is editable.
    public var isEditable: Bool = true
    
    /// Enable to show line numbers in the gutter.
    public var showLineNumbers: Bool = false
  }
}


extension TextView {
  func apply(_ configuration: TextEditor.Configuration) {
    showLineNumbers = configuration.showLineNumbers
    isEditable = configuration.isEditable
  }
}
