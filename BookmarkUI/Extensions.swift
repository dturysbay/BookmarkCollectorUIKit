//
//  Extensions.swift
//  BookmarkUI
//
//  Created by Dinmukhambet Turysbay on 06.05.2023.
//

import Foundation
import UIKit

@propertyWrapper
struct AppDataStorage<T:Codable>{
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }


    var wrappedValue:T{
        get {
            guard let data = try? UserDefaults.standard.object(forKey: key) as? Data else{
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }

        set{
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data,forKey: key)
        }
    }

}
