//
//  MatchupDetailView.swift
//  BetWell
//
//  Created by David Mann on 2/11/23.
//

import SwiftUI

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

enum TeamBets: String, CaseIterable {
    case moneyLine = "Moneyline"
    case spread = "Spread"
    case totalPoints = "Total Points"
}


struct MatchupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchupDetailView(home: SampleData.home, away: SampleData.away)
    }
}

struct PreviousMatchups: View {
    let game: NewUpcomingGames
    var body: some View {
        VStack(alignment: .leading) {
            Text("Previous Matchup")
            Text("12/17 @Home 123(BOS)-115(PHI)")
            Text("\(game.home.alias): Assists: 32 Rebounds: 45 Total 3's: 14")
            Text("\(game.away.alias): Assists: 21 Rebounds: 34 Total 3's: 16")
            Text("Officials: G. Brady, H. Smith, L. Jones")
        }
        .font(.caption)
    }
}

struct CardView: View {
    var home: Home
    var away: Away
    let bet: TeamBets
    @State var segmentationSelection2: MatchupDataSelection = .h2h
    @State var showDeepDiveView = false
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .top) {
                VStack {
                    Text(bet.rawValue)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .padding([.top, .bottom], 10)
                    Spacer()
                    TeamBetOddsMatchupView(bet: bet)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.leading, 15)
                Spacer()
                VStack(alignment: .trailing) {
                    Picker("", selection: $segmentationSelection2) {
                        ForEach(MatchupDataSelection.allCases, id: \.self) { option in
                            Text(option.rawValue)
                                .font(.system(size: 26, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 175)
                    .padding(.top, 10)
                    HeadToHeadOrSeasonDetailView(state: segmentationSelection2)
                    Spacer()
                    VStack {
                        Button {
                            showDeepDiveView.toggle()
                        } label: {
                            Text("More Details")
                                .frame(width: 75, height: 30)
                                .font(.caption)
                        }
                        NavigationLink("", destination:  MatchupDeepDiveView(), isActive: $showDeepDiveView)
                    }
                }
            }
            .padding(.trailing, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .modifier(CardModifier())
        .padding(.all, 10)
    }
}

struct MatchupDeepDiveView: View {
    var body: some View {
        Text("here we can show some really detailed numbers about the teams/matchups")
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}

struct HeadToHeadOrSeasonDetailView: View {
    var state: MatchupDataSelection
    var body: some View {
        Text(state == .h2h ? "Last 10 games results" : "Season results")
            .font(.system(size: 16, weight: .bold, design: .default))
            .foregroundColor(.white)
            .padding(.top, 8)
    }
}

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

struct BooksCardView: View {
    
    let books: [String: [(String, [String: String])]]
    
    @State var segmentationSelection: String = ""
    
    var body: some View {
        let keys = books.map{$0.key}
        let values = books.map {$0.value}
        return Picker("", selection: $segmentationSelection) {
            ForEach(keys, id: \.self) { key in
                Text(key)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .onAppear {
            segmentationSelection = "books.keys[0]"
        }
    }
}

//
//struct OddsData {
//    let title: String
//    let bets:
//}
