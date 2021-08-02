//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Mahesh on 29/10/20.
//

import UIKit

class FinishGoalVC: UIViewController {
    
    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    
    var goalDesc = ""
    var goalType : GoalType!
    
    func initData(desc : String, type : GoalType) {
        self.goalDesc = desc
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.pointsTextField.resignFirstResponder()
    }
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
//        pass data into core data Goal model
        if pointsTextField.text != nil  {
            self.save { (success) in
                if success {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func save(completion : (_ finished : Bool) -> Void) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDesc
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            completion(true)
        } catch let error {
            debugPrint("Could not save : \(error.localizedDescription)")
            completion(false)
        }
    }
}
