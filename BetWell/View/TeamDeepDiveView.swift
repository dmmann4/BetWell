//
//  TeamDeepDiveView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

enum DataDeepDive: String, CaseIterable {
    case overview = "Overview"
    case rawData = "Raw Data"
}



struct TeamDeepDiveView: View {
    var teamName: String
    var teamLogo: String
    @State var typeOfDataShown: DataDeepDive = .overview
    @State var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    var colors: [Color] = [.yellow, .purple, .green]
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text(teamName)
                    Image(teamLogo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
                Picker("", selection: $typeOfDataShown) {
                    ForEach(DataDeepDive.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                Spacer()
                if typeOfDataShown == .overview {
                    LazyVGrid(columns: gridItemLayout) {
                        ForEach((0...9999), id: \.self) {
                            Image(systemName: symbols[$0 % symbols.count])
                                .font(.system(size: 30))
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200)
                                .background(colors[$0 % colors.count])
                                .cornerRadius(10)
                                .padding(5)
                        }
                    }
                } else {
                    List {
                        ForEach(symbols, id: \.self) { i in
                            Text("here")
                        }
                    }
                }
            }
        }
    }
}

struct TeamDeepDiveView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDeepDiveView(teamName: "Boston Celtics", teamLogo: "BOS")
    }
}
