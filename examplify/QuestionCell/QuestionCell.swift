//
//  QuestionCell.swift
//  examplify
//
//  Created by Manthan Vanani on 05/03/25.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    static let identifier : String = "QuestionCell"
    
    @IBOutlet weak var labelOptionKey: UILabel!
    @IBOutlet weak var labelOptionValue: UILabel!
    @IBOutlet weak var buttonViewClick: UIButton!
    @IBOutlet weak var questionView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        DispatchQueue.main.async{
            self.prepareUI()
        }
        // Configure the view for the selected state
    }
    
    func configCell(model : QuestionModel?, indexPath : IndexPath){
        self.labelOptionKey.text = model?.options[indexPath.row].key.uppercased() ?? ""
        self.labelOptionValue.text = model?.options[indexPath.row].value ?? ""
        self.questionView.layer.borderWidth = (model?.selectedOption?.key == model?.options[indexPath.row].key) ? 2 : 0
        self.questionView.layer.borderColor = AppColors.blueColor.cgColor
        self.prepareUI()
    }
    
    func prepareUI(){
        self.questionView.layer.cornerRadius = self.questionView.frame.height / 2
        self.questionView.clipsToBounds = true
    }
    
}
