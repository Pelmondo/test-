//
//  ViewController.swift
//  BirthdayTraker
//
//  Created by Сергей Прокопьев on 08/12/2018.
//  Copyright © 2018 someThing. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class AddBirthdayViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
  
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthDatePicker.maximumDate = Date()
    }

    //   MARK: - Save button

    @IBAction func tapSaveButton(_ sender: UIBarButtonItem) {
       
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let birthdayDate = birthDatePicker.date
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newBirthday = Birthday(context: context)
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.dateBirthday = birthdayDate
        newBirthday.birthdayId = UUID().uuidString
        if let uniqueId = newBirthday.birthdayId {
            print("birthdayId: \(uniqueId)")
        }
        
        do {
            try context.save()
            let message = "Сегодня \(firstName) \(lastName) празднует день рождения!"
            let content = UNMutableNotificationContent()
            content.body = message
            content.sound = UNNotificationSound.default
            var dateComponents = Calendar.current.dateComponents([.month, .day], from: birthdayDate)
            dateComponents.hour = 11
            dateComponents.minute = 50
            let trigger = UNCalendarNotificationTrigger(dateMatching:dateComponents, repeats: true)
            if let identifier = newBirthday.birthdayId {
                let request = UNNotificationRequest(identifier: identifier,content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request, withCompletionHandler: nil)
             }
        } catch let error {
            print(error)
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Cancel button
    
    @IBAction func tapCancelButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController.init(title: "Выйти?", message: "Внимание, ваши данные не будут сохранены. Вы уверены, что хотите выйти?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .cancel, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { (UIAlertAction)in
        }))
        present(alert, animated: true)
    }
    
    
    
    
}

