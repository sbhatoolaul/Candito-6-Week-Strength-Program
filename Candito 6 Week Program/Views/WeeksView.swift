//
//  ViewB.swift
//  Candito 6 Week Program
//
//  Created by Shivam Bhatoolaul on 2023-03-29.
//

import SwiftUI

struct WeeksView: View {
    let weeks: [Week]
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    ForEach(weeks) { week in
                        NavigationLink(destination: WeekDetailView(week: week)) {
                            Text("Week \(week.number)")
                                .font(.headline)
                                .padding(25)
                        }
                    }
                }.navigationTitle("Weeks")
            }
        }
    }
}

struct WeeksView_Previews: PreviewProvider {
    static var previews: some View {
        WeeksView(weeks: InitialData().weeks)
    }
}
