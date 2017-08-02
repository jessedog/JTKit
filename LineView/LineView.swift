//
//  LineView.swift
//  PCCBAFP
//
//  Created by Sheng Long Tan on 2017/3/29.
//  Copyright © 2017年 Puzijingrong. All rights reserved.
//

import UIKit

@IBDesignable
class LineView: UIView {
    
    @objc enum LineType: Int {
        case straight   //直线
        case border     //边框
    }
    
    fileprivate lazy var shapLayer: CAShapeLayer = {
        return CAShapeLayer()
    }()
    
    fileprivate var didLayoutSubviews = false
    
    @IBInspectable var phase: CGFloat = 1 {
        didSet {
            shapLayer.lineDashPhase = phase
        }
    }
    
    @IBInspectable var dashPattern: [Float]! {
        didSet {
            if let dash = dashPattern {
                shapLayer.lineDashPattern = dash.map({ f -> NSNumber in
                    return NSNumber(value: f)
                })
            }
        }
    }
    
    @IBInspectable var isHorizontal: Bool = true
    var type: LineType = .straight
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            guard type == .border else { return }
            shapLayer.lineWidth = borderWidth
        }
    }
    
    @IBInspectable var color: UIColor = UIColor.gray {
        didSet {
            shapLayer.strokeColor = color.cgColor
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, horizontal: Bool) {
        self.init(frame: frame)
        self.isHorizontal = horizontal
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        // set default value
        dashPattern = [3, 1]
        shapLayer.lineDashPattern = [NSNumber(value: 3), NSNumber(value: 1)]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard !didLayoutSubviews else { return }

        var path = UIBezierPath()
        if type == .straight {
            
            let startPoint = isHorizontal ? CGPoint(x: 0, y: bounds.height/2.0) : CGPoint(x: bounds.width/2.0, y: 0)
            path.move(to: startPoint)
            let endPotin = isHorizontal ? CGPoint(x: bounds.width, y: bounds.height / 2.0) : CGPoint(x: bounds.width/2.0, y: bounds.height)
            path.addLine(to: endPotin)
            shapLayer.lineWidth = isHorizontal ? bounds.height : bounds.width
        } else if type == .border {
            path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius)
            shapLayer.fillColor = UIColor.clear.cgColor
        }
        
        shapLayer.path = path.cgPath
        
        layer.addSublayer(shapLayer)
        
        didLayoutSubviews = true
    }
    
}
