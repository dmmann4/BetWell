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
    let game: UpcomingGame
    @State var havePlayed: Bool = true
    var body: some View {
        VStack {
            Picker("", selection: $segmentationSelection) {
                ForEach(MatchupDataSelection.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            if segmentationSelection == .h2h {
                if havePlayed {
                    VStack {
                        Text("12/17 @Home 123(BOS)-115(PHI)")
                        Text("Home: Assists: 32 Rebounds: 45 Total 3's: 14")
                        Text("Away: Assists: 21 Rebounds: 34 Total 3's: 16")
                        Text("Officials: G. Brady, H. Smith, L. Jones")
                    }
                } else {
                    Text("No previous matchups this season!")
                }
                ForEach(game.bookmakers!, id:\.key.rawValue) { bets in
                    Text("\(bets.title.rawValue) \(bets.markets[0].key == .h2H ? "Moneyline" : "Spread")")
                    Text(bets.markets[0].outcomes[0].name)
                    Text("\(bets.markets[0].outcomes[0].price)")
                    Text(bets.markets[0].outcomes[1].name)
                    Text("\(bets.markets[0].outcomes[1].price)")
                }
//                    Last5View(last5GamesHome: last5GamesHome, last5GamesVisitor: last5GamesVisitor)
            } else {
                VersusMatchupView()
            }
        }
    }
}


//struct MatchupDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MatchupDetailView(odds: [PlayerPropOdds(sportsbook: "FanDuel", players: [NBAPlayers(name: "Russell Westbrook", assists: [Lines(line: 135.5, over: -200, under: 105)])])])
//    }
//}
