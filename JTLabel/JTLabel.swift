//
//  JTLabel.swift
//  TicketsBusiness
//
//  Created by tesla on 2017/6/2.
//  Copyright © 2017年 卖票邦. All rights reserved.
//

import UIKit

class JTLabel: UILabel {

    @IBInspectable
    var paddingLeft: CGFloat {
        set { textInsets.left = newValue }
        get { return textInsets.left }
    }
    
    @IBInspectable
    var paddingRight: CGFloat {
        set { textInsets.right = newValue }
        get { return textInsets.right }
    }

    @IBInspectable
    var paddingBottom: CGFloat {
        set { textInsets.bottom = newValue }
        get { return textInsets.bottom }
    }
    
    @IBInspectable
    var paddingTop: CGFloat {
        set { textInsets.top = newValue }
        get { return textInsets.top }
    }
    
    var textInsets = UIEdgeInsets.zero
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, textInsets))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = self.textInsets
        var rect = super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x    -= insets.left
        rect.origin.y    -= insets.top
        rect.size.width  += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
}
