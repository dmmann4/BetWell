//
//  ContentView.swift
//  BetWell
//
//  Created by David Mann on 1/15/23.
//

import SwiftUI
import CoreData
import Combine

struct Games: Identifiable {
    let id = UUID()
    let homeTeam: String
    let awayTeam: String
    let overUnder: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var  networking = Networking()
    @State var todaysGames: [Response] = []
    @State private var userdata = [User]()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Who is playing tonight?")
                        .padding()
                    ForEach($todaysGames, id: \.id) { game in
                        NavigationLink {
                            MatchupView(game: game.teams.wrappedValue)
                        } label: {
                            PlayingTodayView(game: game.wrappedValue)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                }
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("BetWell", displayMode: .large)
                .onAppear() {
                    networking.fetchTodaysGames { games in
                        switch games {
                            case .success(let count):
                               todaysGames = count
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                    }
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


struct UserView: View {
    let user: User
    @State var initialImage = UIImage()
    var body: some View {
        
        VStack {
            Image(uiImage: self.initialImage)
                .resizable()
                .cornerRadius(50)
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 60, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
                .onAppear {
                    guard let url = URL(string: self.user.avatar) else { return }
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        guard let data = data else { return }
                        guard let image = UIImage(data: data) else { return }
                        
                        DispatchQueue.main.async {
                            self.initialImage = image
                        }
                        
                    }.resume()
            }
            
            Text(user.first_name + " " + user.last_name)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
    }
}

struct PlayingTodayView: View {
    var game: Response
    var body: some View {
        HStack(spacing: 15.0) {
            VStack(alignment: .center) {
                Text(parseName(game.teams.home.name))
    //                .frame(width: 100, height: 100)  // <--- here
                    .allowsTightening(true)
                    .lineLimit(2)
                    .scaledToFit()
                    .minimumScaleFactor(0.4)
                AsyncImage(url: URL(string: game.teams.home.logo)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 44, height: 44)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            
            Spacer()
            Text("vs")
            Spacer()
            VStack(alignment: .center) {
                Text(parseName(game.teams.visitors.name))
    //                .frame(width: 100, height: 100)  // <--- here
                    .allowsTightening(true)
                    .lineLimit(2)
                    .scaledToFit()
                    .minimumScaleFactor(0.4)
                AsyncImage(url: URL(string: game.teams.visitors.logo)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 44, height: 44)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            Spacer()
            Text(game.league)
//                .frame(width: 100, height: 100)  // <--- here
//                .allowsTightening(true)
                .lineLimit(2)
                .scaledToFit()
                .minimumScaleFactor(0.4)
            Spacer()
        }
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(Color.init(uiColor: .systemGray5))
    }
    
    func parseName(_ string: String) -> String {
        let parsed = string.components(separatedBy: " ")
        if parsed.count >= 2 {
            let count = parsed.count
            print("\(parsed[count - 1])")
            return parsed[parsed.count - 1]
        } else {
            return string
        }
    }
}

struct UserDetail: Decodable {
    var page: Int
    var data: [User]
}


//                VStack {
//                    VStack(alignment: .leading) {
//                        Text("My Teams")
//                            .font(.headline)
//                            .fontWeight(.heavy)
//                        ScrollView(.horizontal,showsIndicators: false) {
//                            HStack(spacing: 15) {
//                                ForEach(userdata,id: \.id) { user in
//                                    UserView(user: user)
//                                }
//                            }
//                            .padding(.top, 10)
//                        }
//                        .frame(height: 80)
//                    }
//                    .padding()
//                    VStack(alignment: .leading) {
//                        Text("My Players")
//                            .font(.headline)
//                            .fontWeight(.heavy)
//                        ScrollView(.horizontal,showsIndicators: false) {
//                            HStack(spacing: 15) {
//                                ForEach(userdata,id: \.id) { user in
//                                    UserView(user: user)
//                                }
//                            }
//                            .padding(.top, 10)
//                        }
//                        .frame(height: 80)
//                    }
//                    .padding()
