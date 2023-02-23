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
    @State var segmentationSelection: MatchupDataSelection = .h2h
    
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
                    CardView(home: home, away: away, teambet: bet, playerBet: nil)
                }
            } else {
                ForEach(PlayerBets.allCases, id: \.self) { bet in
                    CardView(home: home, away: away, teambet: nil, playerBet: bet)
                }
            }
        }
        .padding()
    }
}

struct MatchupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchupDetailView(home: SampleData.home, away: SampleData.away)
    }
}
