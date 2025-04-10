//
//  NameChangeController.swift
//  test
//
//  Created by S M Techno Manthan on 05/04/25.
//

import UIKit

enum ChangeKey : String{
    case name = "name"
    case number = "number"
    case code = "code"
    case numberOfQuestion = "Question"
}

protocol NameChangeControllerDelegate{
    func nameChangeControllerDidFinish(name: String?, key : ChangeKey)
}

class NameChangeController: UIViewController {
    
    var key : ChangeKey = .name
    var keyboardType : UIKeyboardType = .default
    var delegate : NameChangeControllerDelegate?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var nameContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerView.layer.cornerRadius = 15
        self.containerView.clipsToBounds = true
        
        self.labelName.textColor = AppColors.topLinear
        
        self.buttonDone.backgroundColor = AppColors.topLinear
        self.buttonDone.setTitleColor(AppColors.topText, for: .normal)
        
        self.buttonCancel.backgroundColor = AppColors.topText
        self.buttonCancel.setTitleColor(AppColors.topLinear, for: .normal)
        
        self.buttonDone.layer.cornerRadius = 15
        self.buttonDone.clipsToBounds = true
        
        self.nameContainerView.layer.cornerRadius = 15
        self.nameContainerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.nameContainerView.layer.shadowOpacity = 0.2
        self.nameContainerView.layer.shadowRadius = 10
        self.nameContainerView.layer.shadowOffset = .zero
        
        self.nameTextField.keyboardType = self.keyboardType
        
        self.nameLabel.text = key.rawValue
        self.nameTextField.placeholder = key.rawValue
        
    }
    
    @IBAction func buttonDoneClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "Change?",
                                      message: "Are you sure you want to change?",
                                      preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            self.dismiss(animated: true) {
                self.delegate?.nameChangeControllerDidFinish(name: self.nameTextField.text, key: self.key)
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
