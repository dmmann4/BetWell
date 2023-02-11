//
//  Last5View.swift
//  BetWell
//
//  Created by David Mann on 2/11/23.
//

import SwiftUI

struct Last5View: View {
    let last5GamesHome: [LastFiveGames]
    let last5GamesVisitor: [LastFiveGames]
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ForEach(last5GamesHome, id: \.date) { home in
                    HStack {
                        LastFiveTextView(string: home.date, type: .date)
                        LastFiveTextView(string: home.opponent, type: .opponent)
                        LastFiveTextView(string: home.score, type: .score)
                        LastFiveTextView(string: home.result, type: .result)
                    }
                    .padding(.leading, 5)
                }
            }
            Spacer()
            VStack(alignment: .leading) {
                ForEach(last5GamesVisitor, id: \.date) { vis in
                    HStack {
                        LastFiveTextView(string: vis.date, type: .date)
                        LastFiveTextView(string: vis.opponent, type: .opponent)
                        LastFiveTextView(string: vis.score, type: .score)
                        LastFiveTextView(string: vis.result, type: .result)
                    }
                    .padding(.trailing, 5)
                }
            }
        }
    }
}

struct Last5View_Previews: PreviewProvider {
    static var previews: some View {
        Last5View(last5GamesHome: [
            LastFiveGames(date: "12/14", opponent: "CHA", score: "120-114", result: "W"),
            LastFiveGames(date: "12/16", opponent: "BOS", score: "123-134", result: "L"),
            LastFiveGames(date: "12/20", opponent: "LAL", score: "113-109", result: "W"),
            LastFiveGames(date: "12/22", opponent: "GSW", score: "101-119", result: "L"),
            LastFiveGames(date: "12/25", opponent: "NYK", score: "113-114", result: "L")
        ], last5GamesVisitor: [
            LastFiveGames(date: "12/15", opponent: "MIA", score: "122-130", result: "L"),
            LastFiveGames(date: "12/16", opponent: "MEM", score: "101-105", result: "L"),
            LastFiveGames(date: "12/19", opponent: "IND", score: "109-107", result: "W"),
            LastFiveGames(date: "12/22", opponent: "CLE", score: "108-115", result: "L"),
            LastFiveGames(date: "12/26", opponent: "BRK", score: "98-94", result: "W")
        ])
    }
}


struct LastFiveTextView: View {
    let string: String
    let type: LastViewType
    var body: some View {
        Text(string)
            .font(.subheadline)
            .multilineTextAlignment(.leading)
            .frame(width: textType(type))
    }
    
    func textType(_ type: LastViewType) -> CGFloat {
        switch type {
        case .date:
            return 40
        case .opponent:
            return 35
        case .score:
            return 60
        case .result:
            return 15
        }
    }
}
