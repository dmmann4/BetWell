//
//  CardView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(home: SampleData.home, away: SampleData.away, bet: .moneyLine)
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}
