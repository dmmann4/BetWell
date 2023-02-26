//
//  PlayerBetOddsView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct PlayerBetOddsView: View {
    @State var bet: (PlayerBets, Assists)
    @State var betStrings: (String, String) = ("","")
    var body: some View {
        HStack {
            Text(bet.0.rawValue)
            Text("\(bet.1.over)")
        }
        .font(.system(size: 16, weight: .bold, design: .default))
        .padding(.bottom, 20)
        HStack {
            Text("Away")
            Text("\(bet.1.under)")
        }
        .font(.system(size: 16, weight: .bold, design: .default))
        .onAppear() {
//            betStrings = typeOfBet(bet)
        }
    }
    
    func typeOfBet(_ bet: PlayerBets) -> (String, String) {
        switch bet {
        case .playerPoints:
            return ("O 234.5", "U 234.5")
        case .playerRebounds:
            return ("O 234.5", "U 234.5")
        case .playerAssists:
            return ("O 234.5", "U 234.5")
        case .playerThrres:
            return ("O 234.5", "U 234.5")
        case .playerBlocks:
            return ("O 234.5", "U 234.5")
        case .totalPoints10:
            return ("O 234.5", "U 234.5")
        case .totalPoints15:
            return ("O 234.5", "U 234.5")
        case .totalPoints20:
            return ("O 234.5", "U 234.5")
        case .totalPoints25:
            return ("O 234.5", "U 234.5")
        case .totalPoints30:
            return ("O 234.5", "U 234.5")
        }
    }
    
}

struct PlayerBetOddsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerBetOddsView(bet: (PlayerBets.playerAssists, Assists(line: 15.5, over: -125, under: -105)))
    }
}
