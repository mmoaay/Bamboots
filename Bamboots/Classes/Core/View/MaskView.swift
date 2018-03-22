//
//  MaskView.swift
//  Pods
//
//  Created by Perry on 16/7/8.
//
//

public class MaskView: UIView, Maskable {

    public var maskId: String = "MaskView"

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var contentView: UIView!

    public init() {
        super.init(frame: CGRect.zero)

        backgroundColor = UIColor.clear

        Bundle(for: MaskView.classForCoder()).loadNibNamed("MaskView", owner: self, options: nil)
        self.addSubView(contentView)

        activityIndicator.startAnimating()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        activityIndicator.stopAnimating()
    }
}
