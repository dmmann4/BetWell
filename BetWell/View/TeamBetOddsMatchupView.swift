//
//  TeamBetOddsMatchupView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct TeamBetOddsMatchupView: View {
    let bet: Outcome
    var body: some View {
        VStack {
            HStack {
                if bet.name != "Over" || bet.name != "Under" {
                    Text(teamAcronymName(bet.name))
                } else {
                    Text(bet.name)
                }
                if let point = bet.point {
                    Text("\(String(format: "%.1f", point))")
                }
                Text("\(bet.price)")
            }
        }
        .font(.system(size: 16, weight: .bold, design: .default))
        .padding()
        .onAppear() {
            print(bet.name)
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
    
    func teamAcronymName(_ name: String) -> String {
        let team = NBATeams(rawValue: name)
        switch team {
        case .atl:
            return "ATL"
        case .bos:
            return "BOS"
        case .brk:
            return "BRK"
        case .cha:
            return "CHA"
        case .chi:
            return "CHI"
        case .cle:
            return "CLE"
        case .dal:
            return "DAL"
        case .den:
            return "DEN"
        case .det:
            return "DET"
        case .gsw:
            return "GSW"
        case .hou:
            return "HOU"
        case .ind:
            return "IND"
        case .lal:
            return "LAL"
        case .lac:
            return "LAC"
        case .mem:
            return "MEM"
        case .mia:
            return "MIA"
        case .mil:
            return "MIL"
        case .minn:
            return "MIN"
        case .nop:
            return "NOP"
        case .nyk:
            return "NYK"
        case .okc:
            return "OKC"
        case .orl:
            return "ORL"
        case .phi:
            return "PHI"
        case .phx:
            return "PHX"
        case .por:
            return "POR"
        case .sac:
            return "SAC"
        case .sas:
            return "SAS"
        case .tor:
            return "TOR"
        case .uta:
            return "UTA"
        case .was:
            return "WAS"
        case .none:
            return "O/U"
        }
    }
    
}

struct TeamBetOddsMatchupView_Previews: PreviewProvider {
    static var previews: some View {
        TeamBetOddsMatchupView(bet: SampleData.bookmaker[0].markets[0].outcomes[1])
    }
}
