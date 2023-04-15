//
//  ContentView.swift
//  Candito 6 Week Program
//
//  Created by Shivam Bhatoolaul on 2023-03-29.
//

import SwiftUI

struct TabsView: View {
    var weeks: [Week]
    var body: some View {
        TabView{
            PRsView(weeks: weeks)
                .tabItem(){
                    Image(systemName: "chart.bar.fill")
                    Text("PRs")
                }
            WeeksView(weeks: weeks)
                .tabItem(){
                    Image(systemName: "figure.strengthtraining.traditional")
                    Text("Weeks")
                }
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView(weeks: InitialData().weeks)
    }
}
