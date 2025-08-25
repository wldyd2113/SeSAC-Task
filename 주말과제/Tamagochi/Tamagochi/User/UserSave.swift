//
//  UserSave.swift
//  Tamagochi
//
//  Created by 차지용 on 8/25/25.
//

import Foundation

struct UserSave {
    static var rice: Int {
        get { UserDefaults.standard.integer(forKey: UserTamagochi.rice.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: UserTamagochi.rice.rawValue) }
    }
    static var warter: Int {
        get { UserDefaults.standard.integer(forKey: UserTamagochi.water.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: UserTamagochi.water.rawValue) }
    }
    
    static var level: Int {
        get {
            let level = UserDefaults.standard.integer(forKey: UserTamagochi.level.rawValue)
            return level == 0 ? 1 :level
        }
        set { UserDefaults.standard.set(newValue, forKey: UserTamagochi.level.rawValue) }
    }
    
    static var nickName: String {
        get { UserDefaults.standard.string(forKey: UserTamagochi.nickName.rawValue) ?? "다마고치 이야기" }
        set { UserDefaults.standard.set(newValue, forKey: UserTamagochi.nickName.rawValue) }
    }
    
    static var selectedTamagochi: String {
        get { UserDefaults.standard.string(forKey: UserTamagochi.selectedTamagochi.rawValue) ?? "1-1" }
        set { UserDefaults.standard.set(newValue, forKey: UserTamagochi.selectedTamagochi.rawValue) }
    }

}
