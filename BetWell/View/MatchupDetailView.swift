//
//  MatchupDetailView.swift
//  BetWell
//
//  Created by David Mann on 2/11/23.
//

import SwiftUI

struct MatchupDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var segmentationSelection: MatchupDataSelection = .h2h
    @State var segmentationSelection2: MatchupDataSelection = .h2h
    var home: Home
    var away: Away
    @State var havePlayed: Bool = true
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Picker("", selection: $segmentationSelection) {
                ForEach(MatchupDataSelection.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            if segmentationSelection == .h2h {
                ForEach(TeamBets.allCases, id: \.self) { bet in
                    VStack {
                        HStack {
                            Text(bet.rawValue)
                            Spacer()
                            VStack {
                                Picker("", selection: $segmentationSelection2) {
                                    ForEach(MatchupDataSelection.allCases, id: \.self) { option in
                                        Text(option.rawValue)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .frame(width: 200)
                                if segmentationSelection == .h2h {
                                    Text("Last 10 games results")
                                } else {
                                    Text("Season results")
                                }
                            }
                            
                        }
                        HStack {
                           Text("Home")
                           Text("-100")
                        }
                        HStack {
                           Text("Away")
                           Text("-100")
                        }
                    }
                   
                    
                }
            } else {
                VersusMatchupView()
            }
        }
        .padding()
    }
}

enum TeamBets: String, CaseIterable {
    case moneyLine = "Moneyline"
    case spread = "Spread"
    case totalPoints = "Total Points"
}


//struct MatchupDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MatchupDetailView(game: UpcomingGame(statsGameID: 11900, home: BetWell.Team(id: 24, name: "New York Knicks", nickname: "Knicks", code: "NYK", logo: "https://upload.wikimedia.org/wikipedia/fr/3/34/Knicks_de_NY.png", standings: BetWell.Standings(conference: BetWell.Conference(name: "east", rank: 7, win: 30, loss: 27, gamesBehind: nil), division: BetWell.Conference(name: "atlantic", rank: 4, win: 30, loss: 27, gamesBehind: Optional("10.5")), win: BetWell.Record(home: 14, away: 16, total: 30, percentage: "0.526", lastTen: 5), loss: BetWell.Record(home: 15, away: 12, total: 27, percentage: "0.474", lastTen: 5), gamesBack: Optional("10.5"), streak: 1, winStreak: false)), away: BetWell.Team(id: 40, name: "Utah Jazz", nickname: "Jazz", code: "UTA", logo: "https://upload.wikimedia.org/wikipedia/fr/3/3b/Jazz_de_l%27Utah_logo.png", standings: BetWell.Standings(conference: BetWell.Conference(name: "west", rank: 11, win: 28, loss: 29, gamesBehind: nil), division: BetWell.Conference(name: "northwest", rank: 4, win: 28, loss: 29, gamesBehind: Optional("10.5")), win: BetWell.Record(home: 18, away: 10, total: 28, percentage: "0.491", lastTen: 5), loss: BetWell.Record(home: 12, away: 17, total: 29, percentage: "0.509", lastTen: 5), gamesBack: Optional("10.5"), streak: 1, winStreak: true)), oddsEventID: Optional("aa489f30b7dbe20d28c3357f4172886f"), bookmakers: Optional([BetWell.Bookmaker(key: BetWell.BookmakerKey.draftkings, title: BetWell.Title.draftKings, lastUpdate: "2023-02-11T16:22:24Z", markets: [BetWell.Market(key: BetWell.MarketKey.h2H, lastUpdate: "2023-02-11T16:22:24Z", outcomes: [BetWell.Outcome(name: "New York Knicks", price: -225), BetWell.Outcome(name: "Utah Jazz", price: 190)])]), BetWell.Bookmaker(key: BetWell.BookmakerKey.fanduel, title: BetWell.Title.fanDuel, lastUpdate: "2023-02-11T16:22:23Z", markets: [BetWell.Market(key: BetWell.MarketKey.h2H, lastUpdate: "2023-02-11T16:22:23Z", outcomes: [BetWell.Outcome(name: "New York Knicks", price: -240), BetWell.Outcome(name: "Utah Jazz", price: 198)])])])))
//    }
//}

struct PreviousMatchups: View {
    let game: NewUpcomingGames
    var body: some View {
        VStack(alignment: .leading) {
            Text("Previous Matchup")
            Text("12/17 @Home 123(BOS)-115(PHI)")
            Text("\(game.home.alias): Assists: 32 Rebounds: 45 Total 3's: 14")
            Text("\(game.away.alias): Assists: 21 Rebounds: 34 Total 3's: 16")
            Text("Officials: G. Brady, H. Smith, L. Jones")
        }
        .font(.caption)
    }
}

struct CardView: View {
    let game: NewUpcomingGames
    var body: some View {
        HStack {
            
        }
    }
//    func getBooks(_ book: UpcomingGame) -> [String: [(String, [String: String])]] {
//        var returnVal: [String: [(String, [String: String])]] = [:]
//        book.bookmakers?.forEach({ book in
//            returnVal[book.title.rawValue] = parseMarketValues(book.markets)
//        })
//        return returnVal
//    }
//    
//    func parseMarketValues(_ markets: [Market]) -> [(String, [String: String])] {
//        var array: [(String, [String: String])] = []
//        markets.forEach { market in
//            let title = market.key.rawValue
//            let odds = parseBookValues(market)
//            array.append((title, odds))
//        }
//        return array
//    }
//    
//    func parseBookValues(_ markets: Market) -> [String: String] {
//        var odds: [String: String] = [:]
//        markets.outcomes.forEach { outcome in
//            odds[outcome.name] = "\(outcome.price)"
//        }
//        return odds
//    }
}

struct BooksCardView: View {
    
    let books: [String: [(String, [String: String])]]
    
    @State var segmentationSelection: String = ""
    
    var body: some View {
        let keys = books.map{$0.key}
        let values = books.map {$0.value}
//        print(values)
//        let newVal = values[0]
//        print(newVal)
        return Picker("", selection: $segmentationSelection) {
            ForEach(keys, id: \.self) { key in
                Text(key)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .onAppear {
            segmentationSelection = "books.keys[0]"
        }
    }
}

//
//struct OddsData {
//    let title: String
//    let bets:
//}
