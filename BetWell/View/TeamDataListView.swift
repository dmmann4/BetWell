//
//  TeamDataListView.swift
//  BetWell
//
//  Created by David Mann on 2/10/23.
//

import Foundation
import SwiftUI

struct TeamDataListView: View {
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                   Image("")
                   Text("Home")
                   Text("Record")
                }
                .padding()
                Spacer()
                VStack {
                   Text("Location")
                   Text("Officials")
                }
                Spacer()
                VStack {
                    Image("")
                    Text("Away")
                    Text("Record")
                }
                .padding()
            }
            Spacer()
            MatchupDetailView(odds: [PlayerPropOdds(sportsbook: "FanDuel", players: [NBAPlayers(name: "Russell Westbrook", assists: [Lines(line: 135.5, over: -200, under: 105)])])])
            Spacer()
        }
    }
}

struct TeamDataListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDataListView()
    }
}
