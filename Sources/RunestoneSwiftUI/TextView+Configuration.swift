//
//  TextView+Configuration.swift
//  
//
//  Created by Adrian Schönig on 23/5/2022.
//

import UIKit

@_exported import Runestone

extension TextView {
  public struct Configuration {
    public init(isEditable: Bool = true, showLineNumbers: Bool = false) {
      self.isEditable = isEditable
      self.showLineNumbers = showLineNumbers
    }
    
    public var isEditable: Bool = true
    public var showLineNumbers: Bool = false
  }
}


extension TextView {
  func apply(_ configuration: Configuration) {
    showLineNumbers = configuration.showLineNumbers
    isEditable = configuration.isEditable
  }
}
