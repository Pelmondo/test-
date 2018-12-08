//
//  Birthdays.swift
//  BirthdayTraker
//
//  Created by Сергей Прокопьев on 08/12/2018.
//  Copyright © 2018 someThing. All rights reserved.
//

import Foundation


class Birthdays {
    
    let firstName: String
    let lastName: String
    let birthDate: Date
    
    init(firstName: String, lastName: String, birthDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
}
