//
//  ContentView.swift
//  Memorize-cs193p
//
//  Created by Juancho Marengo on 19/08/2024.
//

import SwiftUI

struct ContentView: View {
    var emojis = [["🇵🇹","🏴󠁧󠁢󠁥󠁮󠁧󠁿","🇺🇸","🇪🇸","🇦🇷"],["👻", "🎃", "🕷️", "😈", "💀","🕸️"],["🐶","🐨","🐵","🐱","🦊","🐍","🐙"]]
    
    @State var emojiKind: Int = 0
    @State var cardCount: Int = 1
    

    
    var body: some View {
        Text("Memorize!").font(.largeTitle)
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjusters
            cardsChangeTheme
        }.padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            getShuffledCards(array: emojis[emojiKind])
        }
        .foregroundColor(.orange)
    }
    
    var cardsChangeTheme: some View {
        HStack{
            cardFlagTheme
            cardFacesTheme
            cardAnimalsTheme
        }
    }
    
    var cardCountAdjusters: some View {
        HStack {
           cardRemover
            Spacer()
            cardAdder
        }.imageScale(.large).font(.largeTitle)
    }
    
    func getShuffledCards(array: [String]) -> some View {
        var newArray = array.shuffled()
        
        return ForEach(0..<cardCount, id: \.self){index in
            CardView(content: newArray[index]).aspectRatio(1 ,contentMode: .fit)
            }
    }
    
    func cardChangeTheme(to theme:Int, symbol: String) -> some View {
        Button(action: {
            emojiKind = theme
        }){
            Image(systemName:symbol).font(.title)
        }.disabled(emojiKind == theme)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
                cardCount += offset
        }) {
            Image(systemName:symbol)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis[emojiKind].count)
    }
    
    var cardRemover: some View{
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.fill.badge.plus")
    }
    
    var cardFlagTheme: some View {
        cardChangeTheme(to: 0, symbol: "flag.checkered.circle")
    }
    
    var cardFacesTheme: some View {
        cardChangeTheme(to: 1, symbol: "person.circle")
    }
    
    var cardAnimalsTheme: some View {
        cardChangeTheme(to: 2, symbol: "dog.circle.fill")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base =  RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)

            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
