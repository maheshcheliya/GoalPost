//
//  GoalVC.swift
//  GoalPost
//
//  Created by Mahesh on 29/10/20.
//

import UIKit
import Foundation
import CoreData

class GoalVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let goal = Goal()
        goal.goalType = ""
    }

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        
    }
    
}

