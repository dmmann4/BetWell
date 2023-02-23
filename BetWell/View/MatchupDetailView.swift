//
//  MatchupDetailView.swift
//  BetWell
//
//  Created by David Mann on 2/11/23.
//

import SwiftUI

enum TeamBets: String, CaseIterable {
    case moneyLine = "Moneyline"
    case spread = "Spread"
    case totalPoints = "Total Points"
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
                    CardView(home: home, away: away, bet: bet)
                }
            } else {
                VersusMatchupView()
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
