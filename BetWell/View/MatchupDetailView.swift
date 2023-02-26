//
//  MatchupDetailView.swift
//  BetWell
//
//  Created by David Mann on 2/11/23.
//

import SwiftUI

protocol Bets {}

enum TeamBets: String, CaseIterable, Bets {
    case moneyLine = "Moneyline"
    case spread = "Spread"
    case totalPoints = "Total Points"
}

enum PlayerBets: String, CaseIterable, Bets {
    case playerPoints = "Points O/U"
    case playerRebounds = "Rebounds O/U"
    case playerAssists = "Assists O/U"
    case playerThrres = "Three's made O/U"
    case playerBlocks = "Blocks O/U"
    case totalPoints10 = "To score 10+"
    case totalPoints15 = "To score 15+"
    case totalPoints20 = "To score 20+"
    case totalPoints25 = "To score 25+"
    case totalPoints30 = "To score 30+"
}

struct MatchupDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var betDataType: MatchupDataSelection = .h2h
    @State var bookSelected: BookmakerKey = .fanduel
    var oddBetID: String
    @State var bookType: [BookmakerKey] = []
    @State var playerProps: [String: NewPlayerPropOdds] = [:]
    var home: Home
    var away: Away
    @State var havePlayed: Bool = true
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack {
               Picker("Select a paint color", selection: $bookSelected) {
                   ForEach(bookType, id: \.self) {
                       Text($0.rawValue)
                   }
               }
               .pickerStyle(.menu)
//               Text("Selected color: \(selection)")
            }
            Picker("", selection: $betDataType) {
                ForEach(MatchupDataSelection.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            if betDataType == .h2h {
                ForEach(TeamBets.allCases, id: \.self) { bet in
                    CardView(home: home, away: away, teambet: bet, playerORMatchup: betDataType)
                }
            } else {
                ForEach(playerProps[bookSelected.rawValue]!.players, id: \.name) { bet in
                    PlayerPropsCardView(home: home, away: away, bets: bet)
                }
            }
        }
        .padding()
        .onAppear() {
            let sample = SampleData.playerProps
            print("sample props -- \(sample)")
            for i in sample {
                print("book - \(i.sportsbook)")
                let key = BookmakerKey(rawValue: i.sportsbook.lowercased())
                bookType.append(key!)
                playerProps[key!.rawValue] = i
            }
            /// netowrking to get the player props with the odds ID
        }
    }
}

struct MatchupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchupDetailView(oddBetID: SampleData.oddsID, home: SampleData.home, away: SampleData.away)
    }
}
