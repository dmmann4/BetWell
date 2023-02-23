//
//  TeamBetOddsMatchupView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct TeamBetOddsMatchupView: View {
    let bet: TeamBets
    @State var betStrings: (String, String) = ("","")
    var body: some View {
        HStack {
            Text("Home")
            Text(betStrings.0)
        }
        .font(.system(size: 16, weight: .bold, design: .default))
        .padding(.bottom, 20)
        HStack {
            Text("Away")
            Text(betStrings.1)
        }
        .font(.system(size: 16, weight: .bold, design: .default))
        .onAppear() {
            betStrings = typeOfBet(bet)
        }
    }
    
    func typeOfBet(_ bet: TeamBets) -> (String, String) {
        switch bet {
        case .moneyLine:
            return ("-237", "+200")
        case .spread:
            return ("-6.5", "+6.5")
        case .totalPoints:
            return ("O 234.5", "U 234.5")
        }
    }
    
}

struct TeamBetOddsMatchupView_Previews: PreviewProvider {
    static var previews: some View {
        TeamBetOddsMatchupView(bet: .moneyLine)
    }
}
