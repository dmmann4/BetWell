//
//  MatchupDetailView.swift
//  BetWell
//
//  Created by David Mann on 2/11/23.
//

import SwiftUI

struct MatchupDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let last5GamesHome: [LastFiveGames] =  [
        LastFiveGames(date: "12/14", opponent: "CHA", score: "120-114", result: "W"),
        LastFiveGames(date: "12/16", opponent: "BOS", score: "123-134", result: "L"),
        LastFiveGames(date: "12/20", opponent: "LAL", score: "113-109", result: "W"),
        LastFiveGames(date: "12/22", opponent: "GSW", score: "101-119", result: "L"),
        LastFiveGames(date: "12/25", opponent: "NYK", score: "113-114", result: "L")
    ]
    let last5GamesVisitor: [LastFiveGames] =  [
        LastFiveGames(date: "12/15", opponent: "MIA", score: "122-130", result: "L"),
        LastFiveGames(date: "12/16", opponent: "MEM", score: "101-105", result: "L"),
        LastFiveGames(date: "12/19", opponent: "IND", score: "109-107", result: "W"),
        LastFiveGames(date: "12/22", opponent: "CLE", score: "108-115", result: "L"),
        LastFiveGames(date: "12/26", opponent: "BRK", score: "98-94", result: "W")
    ]
    @State var segmentationSelection: MatchupDataSelection = .h2h
    let odds: [PlayerPropOdds]
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.clear)
            VStack {
                Picker("", selection: $segmentationSelection) {
                    ForEach(MatchupDataSelection.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                if segmentationSelection == .h2h {
                    Last5View(last5GamesHome: last5GamesHome, last5GamesVisitor: last5GamesVisitor)
                } else {
                    VersusMatchupView()
                }
            }
            
        }
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .background(.teal)
        if !odds.isEmpty {
            List(odds[0].players, id: \.name) { player in
                HStack {
                    Text(player.name)
    //                Text(player.assists)
    //                Text("Line: \(player.assists.line) - O: \(player.assists.over) / U: \(player.assists.under)")
                }
            }
        }
        
    }
}


struct MatchupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchupDetailView(odds: [PlayerPropOdds(sportsbook: "FanDuel", players: [NBAPlayers(name: "Russell Westbrook", assists: [Lines(line: 135.5, over: -200, under: 105)])])])
    }
}
