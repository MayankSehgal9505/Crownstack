//
//  UIView.swift
//  CrownStack_Assignment
//
//  Created by Mayank Sehgal on 26/07/21.
//

import UIKit

extension UIView{
    
    func hideView(){
        UIView.transition(with: self, duration: 0.1, options: .transitionCrossDissolve, animations: {[weak self] in
            self?.stopAnimation()
        })
    }
    
    func showView(){
        startAnimation()
    }
    
    //MARK:- Shimmer animations
    private func startAnimation() {
        self.clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.backgroundColor = UIColor.clear.cgColor
        let light = UIColor.white.withAlphaComponent(0.1).cgColor
        let alpha = UIColor.white.withAlphaComponent(0.6).cgColor
        gradientLayer.name = "ShimmerLayer"
        gradientLayer.colors = [light,light,light,light,light,light,alpha,alpha,alpha,light,light,light,light,light,light]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.2, y: 0.6)
        gradientLayer.frame = CGRect(x: 0, y: 0, width:self.frame.size.width , height: self.bounds.size.height)
        self.layer.mask = nil
        self.layer.addSublayer(gradientLayer)
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 0.75
        animation.fromValue = -self.frame.size.width
        animation.toValue = self.frame.size.width
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        gradientLayer.add(animation, forKey: "")
    }
    
    private func stopAnimation() {
        if let layer = self.layer.sublayers {
            for layerObj in layer {
                if layerObj.name == "ShimmerLayer" {
                    layerObj.removeFromSuperlayer()
                    self.layer.mask = nil
                    break
                }
            }
        }
    }
    
    func makeCircularView(withBorderColor color: UIColor, withBorderWidth borderWidth: CGFloat = 1.0, withCustomCornerRadiusRequired cornerRadiusRequired:Bool = false, withCustomCornerRadius cornerRadius: CGFloat = 6.0) {
        self.layer.cornerRadius = cornerRadiusRequired ? cornerRadius : (self.frame.size.width / 2)
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true,setPath: Bool = false) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        if setPath {
            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        }
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
