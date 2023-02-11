//
//  TeamDataListView.swift
//  BetWell
//
//  Created by David Mann on 2/10/23.
//

import Foundation
import SwiftUI

struct TeamDataListView: View {
    
    let teams: UpcomingGame
    
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
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        AsyncImage(url: URL(string: teams.home.logo)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 44, height: 44)
                            .background(Color.gray)
                            .clipShape(Circle())
                        Text(teams.home.nickname)
                        Text("\(teams.home.standings.win.total)-\(teams.home.standings.loss.total)(\(teams.home.standings.conference.rank)th in \(teams.home.standings.conference.name))")
                        HStack {
                            Text("Streak: \(teams.home.standings.winStreak ? "W" : "L") \(teams.home.standings.streak)")
                        }
                        Text("Home: \(teams.home.standings.win.home)-\(teams.home.standings.loss.home)")
                        Text("Away: \(teams.home.standings.win.away)-\(teams.home.standings.loss.away)")
                        Text("Last 10: \(teams.home.standings.win.lastTen)-\(teams.home.standings.loss.lastTen)")
                        Text("Last 10 Avg: Pts: 121.2 | Ast: 25.1 | Reb: 45.0 | Team 3's: 16.2")
                    }
                    .padding()
                    Spacer()
                    VStack {
                       Text("Madison Square Garden, New York, NY")
                       Text("Officials: G. Brady, H. Smith, L. Jones")
                    }
                    Spacer()
                    VStack {
                        AsyncImage(url: URL(string: teams.away.logo)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 44, height: 44)
                        .background(Color.gray)
                        .clipShape(Circle())
                        Text(teams.away.nickname)
                        Text("\(teams.away.standings.win.total)-\(teams.away.standings.loss.total)(\(teams.away.standings.conference.rank)th in \(teams.away.standings.conference.name))")
                        HStack {
                            Text("Streak: \(teams.away.standings.winStreak ? "W" : "L") \(teams.away.standings.streak)")
                        }
                        Text("Home: \(teams.away.standings.win.home)-\(teams.away.standings.loss.home)")
                        Text("Away: \(teams.away.standings.win.away)-\(teams.away.standings.loss.away)")
                        Text("Last 10: \(teams.away.standings.win.lastTen)-\(teams.away.standings.loss.lastTen)")
                        Text("Last 10 Avg: Pts: 121.2 | Ast: 25.1 | Reb: 45.0 | Team 3's: 16.2")
                    }
                    .padding()
                }
                Text("Last 5")
                Last5View(last5GamesHome: last5GamesHome, last5GamesVisitor: last5GamesVisitor)
                MatchupDetailView(game: teams)
                Spacer()
            }
        }
    }
}

struct TeamDataListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDataListView(teams: UpcomingGame(statsGameID: 11900, home: BetWell.Team(id: 24, name: "New York Knicks", nickname: "Knicks", code: "NYK", logo: "https://upload.wikimedia.org/wikipedia/fr/3/34/Knicks_de_NY.png", standings: BetWell.Standings(conference: BetWell.Conference(name: "east", rank: 7, win: 30, loss: 27, gamesBehind: nil), division: BetWell.Conference(name: "atlantic", rank: 4, win: 30, loss: 27, gamesBehind: Optional("10.5")), win: BetWell.Record(home: 14, away: 16, total: 30, percentage: "0.526", lastTen: 5), loss: BetWell.Record(home: 15, away: 12, total: 27, percentage: "0.474", lastTen: 5), gamesBack: Optional("10.5"), streak: 1, winStreak: false)), away: BetWell.Team(id: 40, name: "Utah Jazz", nickname: "Jazz", code: "UTA", logo: "https://upload.wikimedia.org/wikipedia/fr/3/3b/Jazz_de_l%27Utah_logo.png", standings: BetWell.Standings(conference: BetWell.Conference(name: "west", rank: 11, win: 28, loss: 29, gamesBehind: nil), division: BetWell.Conference(name: "northwest", rank: 4, win: 28, loss: 29, gamesBehind: Optional("10.5")), win: BetWell.Record(home: 18, away: 10, total: 28, percentage: "0.491", lastTen: 5), loss: BetWell.Record(home: 12, away: 17, total: 29, percentage: "0.509", lastTen: 5), gamesBack: Optional("10.5"), streak: 1, winStreak: true)), oddsEventID: Optional("aa489f30b7dbe20d28c3357f4172886f"), bookmakers: Optional([BetWell.Bookmaker(key: BetWell.BookmakerKey.draftkings, title: BetWell.Title.draftKings, lastUpdate: "2023-02-11T16:22:24Z", markets: [BetWell.Market(key: BetWell.MarketKey.h2H, lastUpdate: "2023-02-11T16:22:24Z", outcomes: [BetWell.Outcome(name: "New York Knicks", price: -225), BetWell.Outcome(name: "Utah Jazz", price: 190)])]), BetWell.Bookmaker(key: BetWell.BookmakerKey.fanduel, title: BetWell.Title.fanDuel, lastUpdate: "2023-02-11T16:22:23Z", markets: [BetWell.Market(key: BetWell.MarketKey.h2H, lastUpdate: "2023-02-11T16:22:23Z", outcomes: [BetWell.Outcome(name: "New York Knicks", price: -240), BetWell.Outcome(name: "Utah Jazz", price: 198)])])])))
    }
}
