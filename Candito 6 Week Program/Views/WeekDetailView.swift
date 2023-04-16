//
//  WeekDetailView.swift
//  Candito 6 Week Program
//
//  Created by Shivam Bhatoolaul on 2023-03-29.
//

import SwiftUI

struct WeekDetailView: View {
    let week: Week
    var body: some View {
        
        NavigationView {
            VStack {
                List (week.sessions) { session in
                    Section(header: Text(session.name)) {
                        
                        ForEach(session.exercises) { exercise in
                            
                            VStack (alignment: .leading){
                                Text(exercise.name).font(.headline)
                                
                                
                                ForEach(exercise.loads) { load in
                                    
                                    VStack(alignment: .leading){
                                        Text(load.weight==0 ? "× \(load.reps)" :  "\(load.weight)lbs × \(load.reps)")
                                            .listRowSeparator(.hidden)
                                        Text("\(load.comments)")
                                    }
                                }
                            }
                        }
                    }
                }
                
                //.navigationTitle("Week \(week.number)")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Week \(week.number)").font(.headline)
                            Text(week.subtitle).font(.caption2)
                        }
                    }
                }
            }
        }
    }
}

struct WeekDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeekDetailView(week: InitialData().weeks[0])
    }
}
