//
//  Week6SpecialDetailView.swift
//  Candito 6 Week Program
//
//  Created by Shivam Bhatoolaul on 2023-04-16.
//

import SwiftUI

struct Week6SpecialDetailView: View {
    var body: some View {
        
        NavigationView {
            VStack (alignment: .leading) {
                List {
                    Section(header: Text("Options")) {
                        Text("1.  Skip Week 6.  Just use projected one rep max from last week's 1-4 rep set.  Start next cycle.")
                        Text("2.  Use projected max for next cycle, but take a deload week (repeat Week 1 but skip last upper workout).")
                        Text("3.  Take this 6th week to actually find your 1 rep max.  Then either deload or start new cycle.")
                    }
                    
                    Section(header: Text("Determining Projected Max")) {
                        Text("Take what you lifted in Week 5, and multiply by 1.03 if you completed 2 reps, 1.06 if 3 reps, and 1.09 if 4 reps.")
                    }
                    
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Week 6").font(.headline)
                            Text("Deload (optional)").font(.caption2)
                        }
                    }
                }
            }
        }
    }
}

struct Week6SpecialDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Week6SpecialDetailView()
    }
}
