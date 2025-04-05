//
//  CircleCollectionCell.swift
//  examplify
//
//  Created by Manthan Vanani on 05/03/25.
//

import UIKit

class CircleCollectionCell: UICollectionViewCell {
    
    static let identifier : String = "CircleCollectionCell"
    
    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var labelNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prePareUI()
    }
    
    func configCell(model : QuestionModel?, indexPath : IndexPath){
        self.labelNumber.text = "\(indexPath.item + 1)"
        self.imageFlag.isHidden = (model?.isflag ?? false) == false
        self.labelNumber.layer.borderColor = UIColor.black.cgColor
        self.labelNumber.layer.borderWidth = 1
        switch model?.outline ?? .outline {
        case .outline:
            self.labelNumber.layer.borderColor = AppColors.eyeIcon.cgColor
            self.labelNumber.textColor = AppColors.eyeIcon
            self.labelNumber.layer.borderWidth = 1
            self.labelNumber.backgroundColor = .clear
        case .filled:
            self.labelNumber.layer.borderWidth = 1
            self.labelNumber.layer.borderColor = AppColors.blueColor.cgColor
            self.labelNumber.textColor = AppColors.topText
            self.labelNumber.backgroundColor = AppColors.blueColor
        case .visible:
            self.labelNumber.layer.borderWidth = 1
            self.labelNumber.layer.borderColor = AppColors.blueColor.cgColor
            self.labelNumber.textColor = AppColors.blueColor
            self.labelNumber.backgroundColor = .clear
        }
        self.prePareUI()
    }
    
    func prePareUI(){
        self.labelNumber.layer.cornerRadius = self.labelNumber.layer.frame.height / 2
        self.labelNumber.clipsToBounds = true
        
        self.imageFlag.layer.cornerRadius = self.imageFlag.layer.frame.height / 2
        self.imageFlag.clipsToBounds = true
        
        
    }
}
