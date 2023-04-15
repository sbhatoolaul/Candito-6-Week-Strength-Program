//
//  Candito_6_Week_ProgramApp.swift
//  Candito 6 Week Program
//
//  Created by Shivam Bhatoolaul on 2023-03-29.
//

import SwiftUI

@main
struct Candito_6_Week_ProgramApp: App {
    var body: some Scene {
        WindowGroup {
            TabsView(weeks: InitialData().weeks)
        }
    }
}
