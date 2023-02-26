//
//  PlayerBetOddsView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct PlayerBetOddsView: View {
    @State var bet: PropObject
    var body: some View {
        HStack {
            VStack {
                Text("**\(bet.propType.rawValue)**")
                    .underline()
                Text("\(String(format: "%.1f", bet.lines.line))")
                HStack {
                    Text("Over:")
                    Text("\(bet.lines.over)")
                }
                HStack {
                    Text("Under:")
                    Text("\(bet.lines.under)")
                }
            }
        }
        .padding()
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
        PlayerBetOddsView(bet: PropObject(propType: PlayerBets.playerAssists, lines: Assists(line: 15.5, over: -125, under: -105)))
    }
}
