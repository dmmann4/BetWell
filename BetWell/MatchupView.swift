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
    var game: Teams
    @State var showModal =  false
    @State var showingCredits = true
    var body: some View {
        VStack {
            HStack {
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
//
//struct MatchupView_Previews: PreviewProvider {
//    static var previews: some View {
//       MatchupView(game: Games(homeTeam: "CIN", awayTeam: "BAL", overUnder: "45.6"))
//    }
//}

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
