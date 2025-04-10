//
//  ChangeQuestionController.swift
//  test
//
//  Created by S M Techno Manthan on 05/04/25.
//

import UIKit

protocol ChangeQuestionControllerDelegate {
    func updateInQuestion(model : QuestionModel?)
}

class ChangeQuestionController: UIViewController {
    
    
    var model : QuestionModel? = nil
    var delegate : ChangeQuestionControllerDelegate?
    
    @IBOutlet weak var questionOuterContainerView: UIView!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var textViewQuestion: UITextView!
    
    @IBOutlet weak var outerContainerViewAnswer1: UIView!
    @IBOutlet weak var labelAnswer1: UILabel!
    @IBOutlet weak var switchAnswer1: UISwitch!
    @IBOutlet weak var textViewAnswer1: UITextView!
    
    @IBOutlet weak var outerContainerViewAnswer2: UIView!
    @IBOutlet weak var labelAnswer2: UILabel!
    @IBOutlet weak var switchAnswer2: UISwitch!
    @IBOutlet weak var textViewAnswer2: UITextView!
    
    @IBOutlet weak var outerContainerViewAnswer3: UIView!
    @IBOutlet weak var labelAnswer3: UILabel!
    @IBOutlet weak var switchAnswer3: UISwitch!
    @IBOutlet weak var textViewAnswer3: UITextView!
    
    @IBOutlet weak var outerContainerViewAnswer4: UIView!
    @IBOutlet weak var labelAnswer4: UILabel!
    @IBOutlet weak var switchAnswer4: UISwitch!
    @IBOutlet weak var textViewAnswer4: UITextView!
    
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        self.labelQuestion.text = "Quetions"
        
        self.buttonSubmit.backgroundColor = AppColors.topLinear
        self.buttonSubmit.setTitleColor(AppColors.topText, for: .normal)
        
        
        self.buttonSubmit.layer.cornerRadius = 15
        self.buttonSubmit.clipsToBounds = true
        
        self.buttonCancel.backgroundColor = AppColors.topText
        self.buttonCancel.setTitleColor(AppColors.topLinear, for: .normal)
        
        
        self.switchAnswer1.onTintColor = AppColors.topLinear
        self.switchAnswer2.onTintColor = AppColors.topLinear
        self.switchAnswer3.onTintColor = AppColors.topLinear
        self.switchAnswer4.onTintColor = AppColors.topLinear
        
        self.switchAnswer1.tag = 0
        self.switchAnswer2.tag = 1
        self.switchAnswer3.tag = 2
        self.switchAnswer4.tag = 3
        
        self.questionOuterContainerView.clipsToBounds = true
        self.questionOuterContainerView.layer.cornerRadius = 15
        self.outerContainerViewAnswer1.clipsToBounds = true
        self.outerContainerViewAnswer1.layer.cornerRadius = 15
        self.outerContainerViewAnswer2.clipsToBounds = true
        self.outerContainerViewAnswer2.layer.cornerRadius = 15
        self.outerContainerViewAnswer3.clipsToBounds = true
        self.outerContainerViewAnswer3.layer.cornerRadius = 15
        self.outerContainerViewAnswer4.clipsToBounds = true
        self.outerContainerViewAnswer4.layer.cornerRadius = 15
        
        
        self.questionOuterContainerView.viewShadow()
        self.outerContainerViewAnswer1.viewShadow()
        self.outerContainerViewAnswer2.viewShadow()
        self.outerContainerViewAnswer3.viewShadow()
        self.outerContainerViewAnswer4.viewShadow()
        
    }
    
    func setupView(){
        
        self.textViewQuestion.text = self.model?.question
        
        if(self.model?.options.indices.contains(0) ?? false){
            self.outerContainerViewAnswer1.isHidden = false
            self.switchAnswer1.isOn = self.model?.options[0].isAnswer ?? false
            self.labelAnswer1.text = "Option \(self.model?.options[0].key ?? "")"
            self.textViewAnswer1.text = self.model?.options[0].value
        }else{
            self.outerContainerViewAnswer1.isHidden = true
        }
        
        
        if(self.model?.options.indices.contains(1) ?? false){
            self.outerContainerViewAnswer2.isHidden = false
            self.switchAnswer2.isOn = self.model?.options[1].isAnswer ?? false
            self.labelAnswer2.text = "Option \(self.model?.options[1].key ?? "")"
            self.textViewAnswer2.text = self.model?.options[1].value
        }else{
            self.outerContainerViewAnswer2.isHidden = true
        }
        
        if(self.model?.options.indices.contains(2) ?? false){
            self.outerContainerViewAnswer3.isHidden = false
            self.switchAnswer3.isOn = self.model?.options[2].isAnswer ?? false
            self.labelAnswer3.text = "Option \(self.model?.options[2].key ?? "")"
            self.textViewAnswer3.text = self.model?.options[2].value
        }else{
            self.outerContainerViewAnswer3.isHidden = true
        }
        
        if(self.model?.options.indices.contains(3) ?? false){
            self.outerContainerViewAnswer4.isHidden = false
            self.switchAnswer4.isOn = self.model?.options[3].isAnswer ?? false
            self.labelAnswer4.text = "Option \(self.model?.options[3].key ?? "")"
            self.textViewAnswer4.text = self.model?.options[3].value
        }else{
            self.outerContainerViewAnswer4.isHidden = true
        }
        
    }
    
    
    @IBAction func buttonSubmitClick(_ sender: UIButton) {
        
        self.model?.question = self.textViewQuestion.text
        self.model?.options[0].value = self.textViewAnswer1.text
        self.model?.options[1].value = self.textViewAnswer2.text
        self.model?.options[2].value = self.textViewAnswer3.text
        self.model?.options[3].value = self.textViewAnswer4.text
        
        self.dismiss(animated: true) {
            self.delegate?.updateInQuestion(model: self.model)
        }
    }
    
    @IBAction func switchValueChange(_ sender: UISwitch) {
        if let options = self.model?.options{
            for i in 0...options.count-1{
                self.model?.options[i].isAnswer = false
            }
        }
        self.model?.options[sender.tag].isAnswer = true
        self.setupView()
    }
    
    
    @IBAction func buttonCancelClick(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

extension UIView{
    func viewShadow(cornerRadius : CGFloat = 0.0, shadowColor : UIColor? = nil){
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor?.cgColor ?? AppColors.topLinear.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
