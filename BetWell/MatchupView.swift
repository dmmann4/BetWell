//
//  MatchupView.swift
//  BetWell
//
//  Created by David Mann on 1/16/23.
//

import SwiftUI

enum MatchupDataSelection : String, CaseIterable {
    case last5 = "Last 5 Games"
    case vsMatchup = "Vs Matchup"
}

struct MatchupView: View {
    var game: Teams
    @State var showModal =  false
    @State var showingCredits = true
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    AsyncImage(url: URL(string: game.home.logo)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 44, height: 44)
                        .background(Color.gray)
                        .clipShape(Circle())
                    Text(game.home.name)
                        .fixedSize(horizontal: false, vertical: true)
                        .scaledToFit()
                        .minimumScaleFactor(0.4)
                        .frame(maxWidth: 120)
                }
                .padding()
                Spacer()
                VStack {
                    Text("Last 5 VS")
                    Text("4-1")
                }
                Spacer()
                VStack {
                    AsyncImage(url: URL(string: game.visitors.logo)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 44, height: 44)
                        .background(Color.gray)
                        .clipShape(Circle())
                    Text(game.visitors.name)
                        .fixedSize(horizontal: false, vertical: true)
                        .scaledToFit()
                        .minimumScaleFactor(0.4)
                }
                Spacer()
            }
          MatchupDetailView()
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 4.5)
          Spacer()
        }
        
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}
//
struct MatchupView_Previews: PreviewProvider {
    static var previews: some View {
       MatchupView(game: Teams(visitors: TeamsHome(id: 1, name: "Boston Celtics", nickname: "Celtics", code: "BOS", logo: "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png"), home: TeamsHome(id: 1, name: "San Antonio Spurs", nickname: "Spurs", code: "SAS", logo: "https://upload.wikimedia.org/wikipedia/fr/0/0e/San_Antonio_Spurs_2018.png")))
    }
}

struct LastFiveGames {
    let date: String
    let opponent: String
    let score: String
    let result: String
}

struct MatchupDetailView: View {
    @Environment(\.presentationMode) var presentationMode
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
    @State var segmentationSelection: MatchupDataSelection = .last5
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.clear)
            VStack {
                Picker("", selection: $segmentationSelection) {
                    ForEach(MatchupDataSelection.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                if segmentationSelection == .last5 {
                    Last5View(last5GamesHome: last5GamesHome, last5GamesVisitor: last5GamesVisitor)
                } else {
                    Text("this is the view with basic data from games played against matchup")
                }
            }
            
        }
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 5)
        )
        
    }
}

enum LastViewType {
    case date
    case opponent
    case score
    case result
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
                }
            }
            .padding()
            Spacer()
            VStack(alignment: .leading) {
                ForEach(last5GamesVisitor, id: \.date) { vis in
                    HStack {
                        LastFiveTextView(string: vis.date, type: .date)
                        LastFiveTextView(string: vis.opponent, type: .opponent)
                        LastFiveTextView(string: vis.score, type: .score)
                        LastFiveTextView(string: vis.result, type: .result)
                    }
                }
            }
            .padding()
        }
    }
}
