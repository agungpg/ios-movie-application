

import Foundation
import NVActivityIndicatorView
import SnapKit
import UIKit
import Alamofire

private var containerIndicator : UIView!
private var activityIndicator : NVActivityIndicatorView!

public class Helper {
    class func starLoading(view: UIView) {
        if containerIndicator == nil {
            let frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            activityIndicator = NVActivityIndicatorView(frame: frame)
            containerIndicator = UIView()
            containerIndicator.backgroundColor = .subPrimaryColor
            view.addSubview(containerIndicator)
            containerIndicator.addSubview(activityIndicator)
            containerIndicator.snp.makeConstraints { (make) in
                make.top.left.right.bottom.equalTo(view)
            }
            activityIndicator.snp.makeConstraints { (make) in
                make.centerY.equalTo(containerIndicator)
                make.centerX.equalTo(containerIndicator)
            }
            activityIndicator.type = .ballPulse // add your type
            activityIndicator.color = UIColor.colorPrimary // add your color
            activityIndicator.backgroundColor = UIColor.clear
            activityIndicator.layer.cornerRadius = 5.0
            activityIndicator.alpha = 0.8
            activityIndicator.startAnimating()
        }
    }

    class func stopLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        if containerIndicator != nil {
            containerIndicator.removeFromSuperview()
            containerIndicator = nil
        }
    }
    
    //MARK : CHECKING IS CONNECTING TO NETWORK
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }

}
