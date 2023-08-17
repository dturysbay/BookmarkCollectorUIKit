//
//  UserSettings.swift
//  BookmarkUI
//
//  Created by Dinmukhambet Turysbay on 06.05.2023.
//

import Foundation

let defaults = UserDefaults.standard

enum StorageStates: String{
    case isOnboardingSeen
    case main
    case arrayOfTitles
    case arrayOfLinks
}


//defaults.set(true, forKey: "isOnboardingSeen")

class UserSettings{
    static let userDefaults = UserDefaults.standard
//    defaults.set(true, forKey: "isOnboardingSeen")
}
