//
//  JTTextView.swift
//  TicketsBusiness
//
//  Created by tesla on 2017/7/27.
//  Copyright © 2017年 卖票邦. All rights reserved.
//

import UIKit

@IBDesignable
class JTTextView: UITextView {
    
    @IBInspectable var placehoderColor: UIColor {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var placehoder: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var font: UIFont?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        placehoderColor = UIColor(rgb: 0xc7c7cd, alpha: 1.0)
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        placehoderColor = UIColor(rgb: 0xc7c7cd, alpha: 1.0)
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChanged(notification:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard text.isEmpty else { return }
        guard let placehoder = placehoder as? NSString else { return }
        var rect = rect
        let attributes: [String: Any] = [
            NSFontAttributeName: self.font!,
            NSForegroundColorAttributeName: placehoderColor
        ]
        rect.origin.x = 5
        rect.origin.y = 8
        rect.size.width -= rect.origin.x * 2
        placehoder.draw(in: rect, withAttributes: attributes)
    }
    
    @objc func textDidChanged(notification: Notification) {
        setNeedsDisplay()
    }
    
}
