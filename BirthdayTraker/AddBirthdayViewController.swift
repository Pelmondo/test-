//
//  ViewController.swift
//  BirthdayTraker
//
//  Created by Сергей Прокопьев on 08/12/2018.
//  Copyright © 2018 someThing. All rights reserved.
//

import UIKit

protocol AddBirthdayViewDelegate {
    func addBirthdayViewController(_ addBirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthdays)
}

class AddBirthdayViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    var delegate : AddBirthdayViewDelegate?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthDatePicker.maximumDate = Date()
    }


    @IBAction func tapSaveButton(_ sender: UIBarButtonItem) {
       
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let birthdayDate = birthDatePicker.date
        let newBirthday = Birthdays(firstName: firstName, lastName: lastName, birthDate: birthdayDate)
        
        delegate?.addBirthdayViewController(self, didAddBirthday: newBirthday)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func tapCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}

