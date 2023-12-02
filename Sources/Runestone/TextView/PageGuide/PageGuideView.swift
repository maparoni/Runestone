import UIKit

final class PageGuideView: UIView {
#if os(visionOS)
  var hairlineWidth: CGFloat = 0.5
#else
  var hairlineWidth: CGFloat = 1 / UIScreen.main.scale {
        didSet {
            if hairlineWidth != oldValue {
                setNeedsLayout()
            }
        }
    }
#endif
  
    var hairlineColor: UIColor? {
        get {
            hairlineView.backgroundColor
        }
        set {
            hairlineView.backgroundColor = newValue
        }
    }

    private let hairlineView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        hairlineView.isUserInteractionEnabled = false
        addSubview(hairlineView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        hairlineView.frame = CGRect(x: 0, y: 0, width: hairlineWidth, height: bounds.height)
    }
}
