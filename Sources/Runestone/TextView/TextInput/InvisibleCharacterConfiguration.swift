//
//  InvisibleCharacterConfiguration.swift
//  
//
//  Created by Simon Støvring on 31/01/2021.
//

import UIKit

final class InvisibleCharacterConfiguration {
    var font: UIFont = .systemFont(ofSize: 12) {
        didSet {
            if font != oldValue {
                _lineBreakSymbolSize = nil
            }
        }
    }
    var textColor: UIColor = .black
    var showTabs = false
    var showSpaces = false
    var showLineBreaks = false {
        didSet {
            if showTabs != oldValue {
                _lineBreakSymbolSize = nil
            }
        }
    }
    var tabSymbol = "\u{25b8}"
    var spaceSymbol = "\u{00b7}"
    var lineBreakSymbol = "\u{00ac}" {
        didSet {
            if lineBreakSymbol != oldValue {
                _lineBreakSymbolSize = nil
            }
        }
    }
    var lineBreakSymbolSize: CGSize {
        if let lineBreakSymbolSize = _lineBreakSymbolSize {
            return lineBreakSymbolSize
        } else if showLineBreaks {
            let attrs: [NSAttributedString.Key: Any] = [.font: font]
            let lineBreakSymbolSize = lineBreakSymbol.size(withAttributes: attrs)
            _lineBreakSymbolSize = lineBreakSymbolSize
            return lineBreakSymbolSize
        } else {
            return .zero
        }
    }

    private var _lineBreakSymbolSize: CGSize?
}