//
//  FinishViewController.swift
//  examplify
//
//  Created by Manthan Vanani on 05/03/25.
//

import UIKit

class FinishViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonFeedbackClick(_ sender: UIButton) {
        
    }
    
    @IBAction func buttonMainDashboardClick(_ sender: UIButton) {
        let vc = DashboardController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}
