//
//  MatchupView.swift
//  BetWell
//
//  Created by David Mann on 1/16/23.
//

import SwiftUI

enum MatchupDataSelection : String, CaseIterable {
    case h2h = "Head to Head"
    case playerProps = "Player Props"
}

struct MatchupView: View {
    var game: UpcomingGame
    @State var playerProps: [PlayerPropOdds] = []
    let networking = Networking()
    var body: some View {
        VStack {
            HStack {
                Spacer()
                TeamHeaderView(game: game.home, whichTeam: .home)
                Spacer()
                VStack {
                    Text("Last 5 VS")
                    Text("4-1")
                }
                Spacer()
                TeamHeaderView(game: game.away, whichTeam: .visitor)
                Spacer()
            }
            MatchupDetailView(odds: playerProps)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            Button {
                networking.fetchPlayerPropsGames(game.oddsEventId!) { result in
                    switch result {
                    case .success(let success):
                        playerProps = success
                        print("got player props - \(success)")
                    case .failure(let failure):
                        print("error getting player propbs - \(failure)")
                    }
                }
            } label: {
                Text("Press for player props")
            }

          Spacer()
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

struct MatchupView_Previews: PreviewProvider {
    static var previews: some View {
        MatchupView(game: MyOwnGamesModel(statsGameId: 1432, home: Teams(id: 13, name: "San Antonio Spurs", nickname: "Spurs", code: "SAS", logo: "https://upload.wikimedia.org/wikipedia/fr/thumb/1/1c/Miami_Heat_-_Logo.svg/1200px-Miami_Heat_-_Logo.svg.png"), away: Teams(id: 13, name: "San Antonio Spurs", nickname: "Spurs", code: "SAS", logo: "https://upload.wikimedia.org/wikipedia/fr/thumb/1/1c/Miami_Heat_-_Logo.svg/1200px-Miami_Heat_-_Logo.svg.png"), oddsEventId: nil, bookmakers: nil))
    }
}

struct LastFiveGames {
    let date: String
    let opponent: String
    let score: String
    let result: String
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

enum LastViewType {
    case date
    case opponent
    case score
    case result
}

struct TeamHeaderView: View {
    
    let game: Teams
    let whichTeam: WhichTeam

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: game.logo)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 44, height: 44)
                .background(Color.gray)
                .clipShape(Circle())
            Text(whichTeam == .home ? game.name : game.name)
                .fixedSize(horizontal: false, vertical: true)
                .scaledToFit()
                .minimumScaleFactor(0.4)
                .frame(maxWidth: 120)
        }
        .padding()
    }
    
}

enum WhichTeam {
    case home
    case visitor
}

struct VersusMatchupView: View {
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("11/29")
                        .font(.subheadline)
                    Text("SAS 109 - ATL 103")
                        .font(.subheadline)
                    Text("Officials - T. Stewart, D. Marino, L. David")
                        .font(.caption)
                }
                .padding(.leading, 10)
                Spacer()
                VStack {
                    HStack {
                        VStack {
                            Text("1Q")
                            Text("29")
                        }
                        
                        VStack {
                            Text("2Q")
                            Text("31")
                        }
                        VStack {
                            Text("3Q")
                            Text("34")
                        }
                        VStack {
                            Text("4Q")
                            Text("19")
                        }
                    }
                    .font(.subheadline)
                    .padding(.trailing, 10)
                    HStack {
                        VStack {
                            Text("1Q")
                            Text("29")
                        }
                        VStack {
                            Text("2Q")
                            Text("31")
                        }
                        VStack {
                            Text("3Q")
                            Text("34")
                        }
                        VStack {
                            Text("4Q")
                            Text("19")
                        }
                    }
                    .font(.subheadline)
                    .padding(.trailing, 10)
                    Text("")
                }
                
            }
            
        }
    }
}

