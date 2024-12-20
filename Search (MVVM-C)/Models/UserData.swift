//
//  UserData.swift
//  Search (MVVM-C)
//
//  Created by Yegor Niedov on 19.12.2024.
//

import UIKit

struct UserData {
    var name:  String?
    var city:  String?
    var email: String?
    var phone: String?
}

extension UserData {
    static var userData = UserData(name: "Yegor", city: "Kyev", email: "yegor@niedov.com", phone: "+380987575755")
}
