//
//  BirthdaysTableViewController.swift
//  BirthdayTraker
//
//  Created by Сергей Прокопьев on 08/12/2018.
//  Copyright © 2018 someThing. All rights reserved.
//

import UIKit
import CoreData

class BirthdaysTableViewController: UITableViewController {

    var birthdays = [Birthday]()
    let dateFormatter = DateFormatter()
    let cellInd = "birthdayCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = Birthday.fetchRequest() as NSFetchRequest<Birthday>
        let sortDiscriptorLastName = NSSortDescriptor(key: "lastName", ascending: true)
        let sortDiscriptorFirstName = NSSortDescriptor(key: "firstName", ascending: true)
        fetchRequest.sortDescriptors = [sortDiscriptorLastName,sortDiscriptorFirstName]
        do {
            birthdays = try context.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        tableView.reloadData()
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
        let firstName = birthday.firstName ?? ""
        let lastName = birthday.lastName ?? ""
        cell.textLabel?.text = firstName + " " + lastName
        
        if let date = birthday.dateBirthday {
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
        } else {
            cell.backgroundColor = UIColor.yellow
            cell.detailTextLabel?.textColor = UIColor.red
            cell.detailTextLabel?.text = "Укажите дату"
        }
            

        return cell
    }

    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if birthdays.count > indexPath.row {
            let birthday = birthdays[indexPath.row]
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(birthday)
            do {
                try context.save()
            } catch let error {
                print(error)
            }
            
            birthdays.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

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
}
