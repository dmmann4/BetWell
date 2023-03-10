//
//  CardView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct CardView: View {
    var home: Team
    var away: Team
    let teambet: Market
    @State var playerORMatchup: MatchupDataSelection
    @State var dataVolumeType: DataVolumeType = .last10
    @State var showDeepDiveView = false
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                HStack(alignment: .top) {
                    Text(convertTeamKeyVal(teambet.key))
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .padding([.top, .bottom], 10)
                    Spacer()
                    Picker("", selection: $dataVolumeType) {
                        ForEach(DataVolumeType.allCases, id: \.self) { option in
                            Text(option.rawValue)
                                .font(.system(size: 26, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 175)
                    .padding([.top, .trailing], 10)
                }
                Spacer()
                ForEach(teambet.outcomes, id: \.name) { key in
                    HStack {
                        HStack {
                            TeamBetOddsMatchupView(bet: key)
                            Spacer()
                            HeadToHeadOrSeasonDetailView(state: dataVolumeType)
                        }
                    }
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.leading, 15)
            VStack {
                HStack {
                    VStack {
                        Text("Last Updated")
                        Text(parseDate(teambet.lastUpdate))
                    }
                    .foregroundColor(Color.gray)
                    .font(.system(size: 10, weight: .light, design: .default))
                    .padding(.leading, 10)
                    Spacer()
                    Button {
                        showDeepDiveView.toggle()
                    } label: {
                        Text("More Details")
                            .frame(width: 75, height: 30)
                            .font(.system(size: 12, weight: .regular, design: .default))
                    }
                    NavigationLink("", destination: MatchupDeepDiveView(), isActive: $showDeepDiveView)
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
    
    func convertTeamKeyVal(_ key: MarketKey) -> String {
        switch key {
        case .h2H:
            return "Moneyline"
        case .spreads:
            return "Spread"
        case .totals:
            return "Total Points"
        }
    }
    
    func parseDate(_ date: String) -> String {
        let localDate = date.components(separatedBy: "T")
        let date = localDate[0]
        let time = localDate[1].components(separatedBy: "Z")
        return "\(date) \(time[0])"
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(home: SampleData.home, away: SampleData.away, teambet: SampleData.bookmaker[0].markets[0], playerORMatchup: .h2h)
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}


