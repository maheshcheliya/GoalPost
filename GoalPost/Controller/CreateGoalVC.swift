//
//  CreateGoalVC.swift
//  GoalPost
//
//  Created by Mahesh on 29/10/20.
//

import UIKit

class CreateGoalVC: UIViewController {

//    Outlets
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
//    Variables
    
    var goalType : GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goalTextView.delegate = self
        
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if (goalTextView.text != "" && goalTextView.text != "What is your goal?") {
            guard let finishGoalVc = storyboard?.instantiateViewController(identifier: "FinishGoalVC") as? FinishGoalVC else {
                return
            }
            finishGoalVc.initData(desc: goalTextView.text!, type: goalType)
            self.presentingViewController?.presentSecondaryDetail(finishGoalVc)
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        dismissDetail()
    }
}

extension CreateGoalVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = UIColor(named: "headerColor")
    }
}
