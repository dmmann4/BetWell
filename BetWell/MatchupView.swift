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

struct MatchupDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var segmentationSelection: MatchupDataSelection = .last5
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.blue)
            Picker("", selection: $segmentationSelection) {
                ForEach(MatchupDataSelection.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
        
    }
}
