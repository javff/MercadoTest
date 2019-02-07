//
//  PrettyAlertVC.swift
//  PrettyAlertUI
//
//  Created by Juan  Vasquez on 2/6/19.
//  Copyright © 2019 Javff Company. All rights reserved.
//

import UIKit

public class PrettyAlertVC: UIViewController {
    
    //MARK: - UI Vars
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var doneActionButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    //MARK: - Vars
    var alertText:String = ""
    
    ///The object that acts as the delegate of the PrettyAlertVC.
    public weak var delegate: PrettyAlertDelegate?
    
    //MARK: - Inits
    
    public static func createPrettyAlert(alertText:String) -> PrettyAlertVC {
        
        let bundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: "PrettyAlertView", bundle: bundle)
        let prettyAlertVC = storyboard.instantiateInitialViewController() as! PrettyAlertVC
        prettyAlertVC.alertText = alertText
        prettyAlertVC.modalTransitionStyle = .crossDissolve
        prettyAlertVC.modalPresentationStyle = .overFullScreen
        return prettyAlertVC
    }
    
    
    //MARK: - Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    //MARK: - Setups
    private func setupView(){
        textLabel.text = alertText
        textLabel.numberOfLines = 0
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .white
        textLabel.textColor = .black
        textLabel.font = UIFont.systemFont(ofSize: 14)
        doneActionButton.setTitle("OK", for: .normal)
        doneActionButton.setTitleColor(.white, for: .normal)
        doneActionButton.layer.cornerRadius = 3
    }
    
    //MARK: - Funcs
    
    @IBAction func doneActionButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.doneActionButtonTappedFor(viewController: self)
    }
    
    

}
