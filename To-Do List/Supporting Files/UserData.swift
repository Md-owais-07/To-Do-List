//
//  UserData.swift
//  To-Do List
//
//  Created by Owais on 29/06/24.
//

import Foundation

class UserData {
    static let shared = UserData()
    private let userDefault = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return userDefault.value(forKey: "isLoggedIn") as? Bool ?? false
        }
        set(status) {
            return userDefault.set(status, forKey: "isLoggedIn")
        }
    }
    var fullName: String {
        get {
            return userDefault.string(forKey: "firstName") ?? ""
        }
        set(data) {
            return userDefault.set(data, forKey: "firstName")
        }
    }
    var emailAddress: String {
        get {
            return userDefault.string(forKey: "emailAddress") ?? ""
        }
        set(data) {
            return userDefault.set(data, forKey: "emailAddress")
        }
    }
    
}
