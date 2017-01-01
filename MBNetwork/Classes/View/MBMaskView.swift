//
//  MBMaskView.swift
//  Pods
//
//  Created by Perry on 16/7/8.
//
//


public class MBMaskView: UIView, MBMaskable {
    public var maskId:String = "MBMaskView"
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var contentView: UIView!
    
    public init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.clear
        
        Bundle(for: MBMaskView.classForCoder()).loadNibNamed("MBMaskView", owner: self, options: nil)
        self.addMBSubView(contentView)
        
        activityIndicator.startAnimating()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        activityIndicator.stopAnimating()
    }
}
