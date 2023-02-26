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

struct MatchupDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var betDataType: MatchupDataSelection = .h2h
    @State var bookSelected: BookmakerKey = .fanduel
    var oddBetID: String
    @State var bookType: [BookmakerKey] = []
    @State var playerProps: [String: NewPlayerPropOdds] = [:]
    @State var teamProps: [String: Bookmaker] = [:]
    var home: Home
    var away: Away
    @State var teamBooks: [Bookmaker]
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack {
                Picker("Select a paint color", selection: $bookSelected) {
                    ForEach(bookType, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.menu)
            }
            Picker("", selection: $betDataType) {
                ForEach(MatchupDataSelection.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            if betDataType == .h2h {
                ForEach(teamProps[bookSelected.rawValue]?.markets ?? [], id: \.key) { bet in
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
            for i in SampleData.playerProps {
                print("book - \(i.sportsbook)")
                let key = BookmakerKey(rawValue: i.sportsbook.lowercased())
                bookType.append(key!)
                playerProps[key!.rawValue] = i
            }
            for i in teamBooks {
                teamProps[i.key.rawValue] = i
            }
            print(teamProps)
            /// netowrking to get the player props with the odds ID
        }
    }
}

struct MatchupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchupDetailView(oddBetID: SampleData.oddsID, home: SampleData.home, away: SampleData.away, teamBooks: SampleData.bookmaker)
    }
}
