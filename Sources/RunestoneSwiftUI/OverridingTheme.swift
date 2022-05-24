//
//  OverridingTheme.swift
//  
//
//  Created by Adrian Schönig on 23/5/2022.
//

import UIKit
import Runestone

class OverridingTheme: Theme {
  let base: Theme
  
  init(base: Theme) {
    self.base = base
    self.font = base.font
    self.textColor = base.textColor
  }
  
  var font: UIFont
  var textColor: UIColor
  var gutterBackgroundColor: UIColor { base.gutterBackgroundColor }
  var gutterHairlineColor: UIColor { base.gutterHairlineColor }
  var lineNumberColor: UIColor { base.lineNumberColor }
  var lineNumberFont: UIFont { base.lineNumberFont }
  var selectedLineBackgroundColor: UIColor { base.selectedLineBackgroundColor }
  var selectedLinesLineNumberColor: UIColor { base.selectedLinesLineNumberColor }
  var selectedLinesGutterBackgroundColor: UIColor { base.selectedLinesGutterBackgroundColor }
  var invisibleCharactersColor: UIColor { base.invisibleCharactersColor }
  var pageGuideHairlineColor: UIColor { base.pageGuideHairlineColor }
  var pageGuideBackgroundColor: UIColor { base.pageGuideBackgroundColor }
  var markedTextBackgroundColor: UIColor { base.markedTextBackgroundColor }
  
  func textColor(for highlightName: String) -> UIColor? {
    base.textColor(for: highlightName)
  }
  
}
