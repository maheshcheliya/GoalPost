//
//  GoalVC.swift
//  GoalPost
//
//  Created by Mahesh on 29/10/20.
//

import UIKit
import Foundation
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var goals : [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblView.delegate = self
        tblView.dataSource = self
        tblView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
    }
    
    func fetchCoreDataObjects() {
        fetch { (success) in
            if success {
                if goals.count > 0 {
                    tblView.isHidden = false
                } else {
                    tblView.isHidden = true
                }
            }
        }
        tblView.reloadData()
    }
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let createGoalVc = storyboard?.instantiateViewController(identifier: "CreateGoalVC") else { return }
        
        self.presentDetail(createGoalVc)
    }
}
extension GoalVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell {
            let goal = goals[indexPath.row]
            
            cell.configureCell(goal: goal)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
//            self.tblView.deleteRows(at: [indexPath], with: .automatic)
            self.fetchCoreDataObjects()
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        let addAction = UITableViewRowAction(style: .destructive, title: "ADD 1") { (rowAction, indexPath) in            
            self.setProgressForGoal(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        addAction.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        
        return [deleteAction, addAction]
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//        }
//    }
}

extension GoalVC {
    func fetch(completion :  (_ success : Bool) -> Void) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest) as! [Goal]
            completion(true)
        } catch let error {
            debugPrint("Could not fetch : \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func setProgressForGoal(atIndexPath indexPath : IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress += 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            debugPrint("successfully set progress")
        } catch let error {
            debugPrint("Could not save progress : \(error.localizedDescription)")
        }
    }
    
    func removeGoal(atIndexPath indexPath : IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(goals[indexPath.row])
        do {
            try managedContext.save()
            print("successfully removed goal")
        } catch let error {
            debugPrint("Could not delete : \(error.localizedDescription)")
        }
    }
}
