//
//  BirthdaysTableViewController.swift
//  BirthdayTraker
//
//  Created by Сергей Прокопьев on 08/12/2018.
//  Copyright © 2018 someThing. All rights reserved.
//

import UIKit

class BirthdaysTableViewController: UITableViewController, AddBirthdayViewDelegate {

    var birthdays = [Birthdays]()
    let dateFormatter = DateFormatter()
    let cellInd = "birthdayCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellInd , for: indexPath)
        let birthday = birthdays[indexPath.row]
        cell.textLabel?.text = birthday.firstName + " " + birthday.lastName
        cell.detailTextLabel?.text = dateFormatter.string(from: birthday.birthDate)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // MARK: - Delegate
    
    func addBirthdayViewController(_ addBirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthdays) {
        birthdays.append(birthday)
        tableView.reloadData()
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let addBirthdayViewController = navigationController.topViewController as! AddBirthdayViewController
        addBirthdayViewController.delegate = self
    }
 

}