//
//  ChangeTimerController.swift
//  test
//
//  Created by S M Techno Manthan on 05/04/25.
//

import UIKit

protocol ChangeTimerControllerDelegate{
    
    func ChangeTimerControllerDidFinish(time: Int?)
    
}

class ChangeTimerController: UIViewController {
    
    var delegate : ChangeTimerControllerDelegate?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var timeContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerView.layer.cornerRadius = 15
        self.containerView.clipsToBounds = true
        
        
        self.labelTime.textColor = AppColors.topLinear
        
        self.buttonDone.backgroundColor = AppColors.topLinear
        self.buttonDone.setTitleColor(AppColors.topText, for: .normal)
        
        self.buttonCancel.backgroundColor = AppColors.topText
        self.buttonCancel.setTitleColor(AppColors.topLinear, for: .normal)
        
        self.buttonDone.layer.cornerRadius = 15
        self.buttonDone.clipsToBounds = true
        
        self.timeContainerView.layer.cornerRadius = 15
        self.timeContainerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.timeContainerView.layer.shadowOpacity = 0.2
        self.timeContainerView.layer.shadowRadius = 10
        self.timeContainerView.layer.shadowOffset = .zero
        
    }
    
    @IBAction func buttonDoneClick(_ sender: UIButton) {
        
        guard let time = Int(self.timeTextField.text ?? "") else {
            
            return
        }
        
        let alert = UIAlertController(title: "Change Timne",
                                      message: "Are you sure you want to change time?",
                                      preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            self.dismiss(animated: true) {
                
                self.delegate?.ChangeTimerControllerDidFinish(time: time)
            }
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buttonCancelClick(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
        }
    }
}

