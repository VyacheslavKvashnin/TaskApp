//
//  ContentView.swift
//  TaskApp
//
//  Created by Вячеслав Квашнин on 07.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        Home()
    }
}
