//
//  LanguageManager.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 6.10.24.
//

import Foundation
import Observation

@Observable
class LanguageManager {
    var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "selectedLanguage")
        }
    }
    
    init() {
        self.currentLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
    }
}
