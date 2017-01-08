//
//  MBEyeLoading.swift
//  MBNetwork
//
//  Created by ZhengYidong on 30/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import MBNetwork
import SnapKit

extension UIView {
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var f = frame
            f.origin.x = newValue
            frame = f
        }
    }
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var f = frame
            f.origin.y = newValue
            frame = f
        }
    }
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var f = frame
            f.size.width = newValue
            frame = f
        }
    }
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var f = frame
            f.size.height = newValue
            frame = f
        }
    }
}

class MBEyeLoading: UIView, MBMaskable {

    var maskId: String = "MBEyeLoading"

    let eyeballView = UIView()
    let whitesView = UIView()

    let eyelidView = UIView()

    let eyelidLayer = CAShapeLayer()
    let eyeballLayer = CAShapeLayer()

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */

    init() {
        super.init(frame: CGRect.zero)

        self.backgroundColor = UIColor(colorLiteralRed: 0.0/255.0, green: 138.0/255.0, blue: 241.0/255.0, alpha: 1)

        eyelidView.backgroundColor = UIColor.white

        eyeballView.backgroundColor = UIColor(
            colorLiteralRed: 0.0 / 255.0, green: 138.0 / 255.0, blue: 241.0 / 255.0, alpha: 1
        )

        self.addSubview(eyelidView)
        eyelidView.addSubview(whitesView)
        whitesView.addSubview(eyeballView)

        eyeballView.snp.makeConstraints { (make: ConstraintMaker) in
            make.width.height.equalTo(16)
            make.center.equalTo(whitesView)
        }

        whitesView.snp.makeConstraints { (make: ConstraintMaker) in
            make.width.height.equalTo(40)
            make.centerX.equalTo(eyelidView)
            make.centerY.equalTo(eyelidView).offset(3)
        }

        eyelidView.snp.makeConstraints { (make: ConstraintMaker) in
            make.width.equalTo(55)
            make.height.equalTo(50)
            make.center.equalTo(self)
        }

        layoutIfNeeded()

        eyelidLayer.fillColor = eyelidView.backgroundColor?.cgColor
        eyelidLayer.frame = eyelidView.layer.bounds
        eyelidView.layer.mask = eyelidLayer
        eyelidView.layer.masksToBounds = true

        eyeballLayer.fillColor = eyeballView.backgroundColor?.cgColor
        eyeballLayer.frame = eyeballView.layer.bounds
        eyeballView.layer.mask = eyeballLayer
        eyeballView.layer.masksToBounds = true

        startAnimation()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func startAnimation() {
        eyeballLayer.path = getEyeballPath()
        eyelidLayer.path = getEyelidPath(marginTop: 0, marginBottom: 0)

        let eyelidGroup = CAAnimationGroup()
        eyelidGroup.duration = 4.2
        eyelidGroup.animations = [
            animationForEyelid(duration: 0.5, beginTime: 1, marginTop: -6, marginBottom: 0),
            animationForEyelid(duration: 1, beginTime: 1.5, marginTop: 0, marginBottom: 0),
            animationForEyelid(duration: 0.5, beginTime: 3, marginTop: -6, marginBottom: 0),
            animationForEyelid(duration: 0.5, beginTime: 3.5, marginTop: 0, marginBottom: 0),
            animationForEyelid(duration: 0.1, beginTime: 4.0, marginTop: 16, marginBottom: 16),
            animationForEyelid(duration: 0.1, beginTime: 4.1, marginTop: 0, marginBottom: 0)
        ]
        eyelidGroup.repeatCount = MAXFLOAT
        eyelidLayer.add(eyelidGroup, forKey: nil)

        let eyeballGroup = CAAnimationGroup()
        eyeballGroup.duration = 4.2
        eyeballGroup.animations = [
            positionAnimationForEyeballPath(duration: 0.5, beginTime: 1, offset: -10),
            scaleAnimationForEyeballPath(duration: 0.5, beginTime: 1, height: 0.6),
            positionAnimationForEyeballPath(duration: 0.5, beginTime: 3.5, offset: 0),
            scaleAnimationForEyeballPath(duration: 0.5, beginTime: 3.5, height: 1)
        ]
        eyeballGroup.repeatCount = MAXFLOAT
        self.eyeballView.layer.add(eyeballGroup, forKey: nil)

        let whitesGroup = CAAnimationGroup()
        whitesGroup.duration = 4.2
        whitesGroup.animations = [rotateAnimationForWhitesPath(duration: 2, beginTime: 1.5)]
        whitesGroup.repeatCount = MAXFLOAT
        self.whitesView.layer.add(whitesGroup, forKey: nil)
    }

    private func animationForEyelid(
        duration: TimeInterval,
        beginTime: TimeInterval = 0.0,
        marginTop: CGFloat, marginBottom: CGFloat
        ) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "path")

        animation.duration = duration
        animation.beginTime = beginTime
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.isRemovedOnCompletion = false
        animation.toValue = getEyelidPath(marginTop: marginTop, marginBottom: marginBottom)

        return animation
    }

    private func positionAnimationForEyeballPath(
        duration: TimeInterval,
        beginTime: TimeInterval = 0.0,
        offset: CGFloat
        ) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.translation.y")

        animation.duration = duration
        animation.beginTime = beginTime
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.isRemovedOnCompletion = false
        animation.toValue = offset

        return animation
    }

    private func scaleAnimationForEyeballPath(
        duration: TimeInterval,
        beginTime: TimeInterval = 0.0,
        height: CGFloat
        ) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale.y")

        animation.duration = duration
        animation.beginTime = beginTime
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.isRemovedOnCompletion = false
        animation.toValue = height

        return animation
    }

    private func rotateAnimationForWhitesPath(
        duration: TimeInterval,
        beginTime: TimeInterval = 0.0
        ) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")

        animation.duration = duration
        animation.beginTime = beginTime
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.isRemovedOnCompletion = false
        animation.toValue = M_PI * 2

        return animation
    }

    private func getEyeballPath() -> CGPath {
        let path = UIBezierPath(ovalIn: eyeballView.bounds)
        return path.cgPath
    }

    private func getEyelidPath(marginTop: CGFloat, marginBottom: CGFloat) -> CGPath {
        let path = UIBezierPath()

        let controlPointTopOne = CGPoint(x: eyelidView.width * 0.5 - 20, y: marginTop+6)
        let controlPointTopTwo = CGPoint(x: eyelidView.width * 0.5 + 20, y: marginTop+6)
        let controlPointBottomOne = CGPoint(x: eyelidView.width * 0.5 + 20, y: eyelidView.height - marginBottom)
        let controlPointBottomTwo = CGPoint(x: eyelidView.width * 0.5 - 20, y: eyelidView.height - marginBottom)
        path.move(to: CGPoint(x: 0, y: 28))
        path.addCurve(
            to: CGPoint(x: eyelidView.width, y: 28),
            controlPoint1: controlPointTopOne,
            controlPoint2: controlPointTopTwo
        )
        path.addCurve(
            to: CGPoint(x: 0, y: 28),
            controlPoint1: controlPointBottomOne,
            controlPoint2: controlPointBottomTwo
        )
        return path.cgPath
    }

    private func stopAnimation() {

    }

    deinit {
        stopAnimation()
    }
}
