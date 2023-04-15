//
//  ViewA.swift
//  Candito 6 Week Program
//
//  Created by Shivam Bhatoolaul on 2023-03-29.
//

import SwiftUI

struct PRsView: View {
    var weeks: [Week]
    @State private var benchPR: Int = 0
    @State private var squatPR: Int = 0
    @State private var deadliftPR: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Bench Press PR (lbs)")) {
                    TextField("Bench Press PR (lbs)", text: Binding(
                        get: { String(benchPR) },
                        set: { benchPR = Int($0) ?? 0 }
                    ))
                }
                
                Section(header: Text("Squat PR (lbs)")) {
                    TextField("Squat PR (lbs)", text: Binding(
                        get: { String(squatPR) },
                        set: { squatPR = Int($0) ?? 0 }
                    ))
                }
                
                Section(header: Text("Deadlift PR (lbs)")) {
                    TextField("Deadlift PR (lbs)", text: Binding(
                        get: { String(deadliftPR) },
                        set: { deadliftPR = Int($0) ?? 0 }
                    ))
                }
                
                Button("Update PRs", action: {updatePRs(weeks: weeks, weights: [benchPR, squatPR, deadliftPR])})
                
            }
            .navigationTitle("PRs")
        }
    }
    
    
    func updatePRs(weeks: [Week], weights: [Int]) {
        for week in weeks{
            week.updateWeights(weights: weights)
        }
    }
    
}

struct PRsView_Previews: PreviewProvider {
    static var previews: some View {
        PRsView(weeks: InitialData().weeks)
    }
}
