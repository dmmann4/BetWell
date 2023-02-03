//
//  MatchupView.swift
//  BetWell
//
//  Created by David Mann on 1/16/23.
//

import SwiftUI
import SlideOverCard

enum MatchupDataSelection : String, CaseIterable {
    case last5 = "Last 5 Games"
    case vsMatchup = "Vs Matchup"
}

struct MatchupView: View {
    let game: Games
    @State var showModal =  false
    @State var showingCredits = true
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Image(systemName: "basketball")
                    Text(game.homeTeam)
                }
                .padding()
                Spacer()
                VStack {
                    Text("Last 5 VS")
                    Text("4-1")
                }
                Spacer()
                VStack {
                    Image(systemName: "basketball")
                    Text(game.awayTeam)
                }
                .padding()
                
            }
            Button(action: { showModal = true }) {
                Text("My Button")
            }
            Spacer()
        }
        .sheet(isPresented: $showingCredits) {
            MatchupDetailView()
                .presentationDetents([.fraction(0.40)])
                .fullScreenCover(isPresented: $showModal) {
                    MatchupDetailView()
                }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

struct MatchupView_Previews: PreviewProvider {
    static var previews: some View {
        MatchupView(game: Games(homeTeam: "CIN", awayTeam: "BAL", overUnder: "45.6"))
    }
}

struct MatchupDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var segmentationSelection: MatchupDataSelection = .last5
    var body: some View {
        Picker("", selection: $segmentationSelection) {
            ForEach(MatchupDataSelection.allCases, id: \.self) { option in
                Text(option.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        Spacer()
        .padding()
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
