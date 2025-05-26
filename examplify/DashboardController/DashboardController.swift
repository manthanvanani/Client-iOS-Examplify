//
//  DashboardController.swift
//  examplify
//
//  Created by Manthan Vanani on 06/04/25.
//

import UIKit

class DashboardController: UIViewController {
    
    
    
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelExamNumber: UILabel!
    @IBOutlet weak var labelUserCode: UILabel!
    
    @IBOutlet weak var labelUserCode1: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPanGesture()
    }
    
    func setupPanGesture(){
        let panGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.minimumPressDuration = 5 // seconds
        self.labelUserName.isUserInteractionEnabled = true
        self.labelUserName.addGestureRecognizer(panGesture)
        
        
        let panGesture1 = UILongPressGestureRecognizer(target: self, action: #selector(handlePan1(_:)))
        panGesture1.minimumPressDuration = 5 // seconds
        self.labelUserCode.isUserInteractionEnabled = true
        self.labelUserCode.addGestureRecognizer(panGesture1)
        
        let panGesture2 = UILongPressGestureRecognizer(target: self, action: #selector(handlePan2(_:)))
        panGesture2.minimumPressDuration = 5 // seconds
        self.labelUserCode1.isUserInteractionEnabled = true
        self.labelUserCode1.addGestureRecognizer(panGesture2)
        
        
        let panGesture3 = UILongPressGestureRecognizer(target: self, action: #selector(handlePan3(_:)))
        panGesture3.minimumPressDuration = 5 // seconds
        self.labelDate.isUserInteractionEnabled = true
        self.labelDate.addGestureRecognizer(panGesture3)
        
        
        let panGesture4 = UILongPressGestureRecognizer(target: self, action: #selector(handlePan4(_:)))
        panGesture4.minimumPressDuration = 5 // seconds
        self.bottomLabel.isUserInteractionEnabled = true
        self.bottomLabel.addGestureRecognizer(panGesture4)
        
        
        
        
        
        
        let longPressGesture1 = UILongPressGestureRecognizer(target: self, action: #selector(labelExamNumber(_:)))
        longPressGesture1.minimumPressDuration = 5 // seconds
        self.labelExamNumber.isUserInteractionEnabled = true
        labelExamNumber.addGestureRecognizer(longPressGesture1)
        
    }
    
    @objc func labelExamNumber(_ gesture: UILongPressGestureRecognizer) {
        print(#function)
        if gesture.state == .began {
            print("Button long pressed!")
            let vc = NameChangeController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.keyboardType = .default
            vc.delegate = self
            vc.key = .number
            self.present(vc, animated: true)
        }
    }
    
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        print(#function)
        if gesture.state == .began {
            print("Button long pressed!")
            
        }
    }
    
    @objc func handlePan(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let vc = NameChangeController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.keyboardType = .default
            vc.delegate = self
            self.present(vc, animated: true)
        }
    }
    
    @objc func handlePan1(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let vc = NameChangeController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.keyboardType = .default
            vc.delegate = self
            vc.key = .code
            self.present(vc, animated: true)
        }
    }
    
    @objc func handlePan2(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let vc = NameChangeController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.keyboardType = .default
            vc.delegate = self
            vc.key = .code1
            self.present(vc, animated: true)
        }
    }
    
    
    @objc func handlePan3(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let vc = NameChangeController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.keyboardType = .default
            vc.delegate = self
            vc.key = .date
            self.present(vc, animated: true)
        }
    }
    
    @objc func handlePan4(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let vc = NameChangeController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.keyboardType = .default
            vc.delegate = self
            vc.key = .bottomLabel
            self.present(vc, animated: true)
        }
    }
    
    
    
    
    
    @IBAction func buttonLeaveFeedBack(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
}


extension DashboardController : NameChangeControllerDelegate{
    
    func nameChangeControllerDidFinish(name: String?, key : ChangeKey) {
        switch key {
        case .name:
            self.labelUserName.text = name ?? self.labelUserName.text
            break;
        case .number:
            self.labelExamNumber.text = name ?? self.labelExamNumber.text
            break;
        case .code:
            self.labelUserCode.text = name ?? self.labelUserCode.text
            break;
        case .code1:
            self.labelUserCode1.text = name ?? self.labelUserCode1.text
            break;
        case .numberOfQuestion:
            break;
        case .date:
            self.labelDate.text = name ?? self.labelDate.text
            break;
        case .bottomLabel:
            self.bottomLabel.text = name ?? self.bottomLabel.text
            break;
            
        }
    }
}
