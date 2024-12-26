//
//  ContentView.swift
//  Animations
//
//  Created by Parth Antala on 2024-12-26.
//

import SwiftUI
import Liquid
import Shiny
import Pow

struct ContentView: View {
    
    @State private var fontSize = 32.0

    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    
                    Text("Liquid")
                        .animatableSystemFont(size: fontSize)
                                   .onTapGesture {
                                       withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1).repeatForever()) {
                                           fontSize = 72
                                       }
                                   }
                }
                .frame(width: 300, height: 300)
                
                Divider()
                ZStack {
                    Liquid()
                        .frame(width: 240, height: 240)
                        .foregroundColor(.blue)
                        .opacity(0.3)
                    
                    
                    Liquid()
                        .frame(width: 220, height: 220)
                        .foregroundColor(.blue)
                        .opacity(0.6)
                    
                    Liquid(samples: 5)
                        .frame(width: 200, height: 200)
                        .foregroundColor(.blue)
                    
                    Text("Liquid").font(.largeTitle).foregroundColor(.white)
                }.shiny()
                
                Divider()
                
                ZStack {
                    Liquid(samples: 3, period: 10.0)
                        .frame(width: 400, height: 200)
                        .foregroundColor(.green)
                        .opacity(0.2)
                        .blur(radius: 10)
                    Image("pattern")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 280, height: 120)
                        .mask(Liquid(samples: 3, period: 6.0))
                        .shadow(radius: 40)
                    Text("Hello, World!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white).shiny()
                }
                
                Divider()
                
                Text("Pow")
                    .font(.largeTitle)
                    .bold()
                    .textFieldStyle(.roundedBorder)
                
                Text("Anvil")
                    .font(.title)
                    .bold()
                    .textFieldStyle(.roundedBorder)
                
                PriceSlide()
                    .frame(width: 300, height: 300)
                    .background(.black)
                    .cornerRadius(20)
                
                Divider()
                
                Text("Flip")
                    .font(.title)
                    .bold()
                    .textFieldStyle(.roundedBorder)
                
                Flip()
                
                Divider()
                
                Text("Glow")
                    .font(.title)
                    .bold()
                    .textFieldStyle(.roundedBorder)
                Glow()
                Divider()
                
                Text("Poof")
                    .font(.title)
                    .bold()
                    .textFieldStyle(.roundedBorder)
                
                poof()
                
                Divider()
                
                Text("Like")
                    .font(.title)
                    .bold()
                    .textFieldStyle(.roundedBorder)
                
                LikeButton(favoriteCount: 40)
                
                Divider()
                
                Text("Hello, world!")
                    .font(.largeTitle)
                    .phaseAnimator(AnimationPhase.allCases) { content, phase in
                        content
                            .scaleEffect(phase.scale)
                            .opacity(phase.opacity)
                    }
               
            }
        }
    }
}




struct PriceSlide: View {
  @State
  var isPriceRevealed = false

  var body: some View {
    ZStack {
//      LinearGradient(
//        colors: [.black, Color(red: 0.45, green: 0.45, blue: 0.52)],
//        startPoint: .top,
//        endPoint: .bottom
//      )

    if isPriceRevealed {
        Text("$499")
          .transition(
             .identity
             .animation(.linear(duration: 1).delay(2))
             .combined(
               with: .movingParts.anvil
             )
          )
      } else {
          Text("$999")
            .transition(
              .asymmetric(
                insertion: .identity,
                removal: .opacity.animation(.easeOut(duration: 0.2)))
            )
      }
    }
    .font(.largeTitle.bold())
    .foregroundColor(.white)
    .contentShape(Rectangle())
    .onTapGesture {
      withAnimation {
        isPriceRevealed.toggle()
      }
    }
  }
}

struct Flip: View {
  @State var isAdded = false

  var body: some View {
    ZStack {
      Color.clear.frame(width: 300, height: 300)
        Text("Tap me")
      if isAdded {
       Image("pattern")
              .resizable()
              .scaledToFit()
              .frame(width: 300, height: 300)
          .transition(.movingParts.flip)
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      withAnimation(.interpolatingSpring(mass: 1, stiffness: 10, damping: 10, initialVelocity: 10)) {
        isAdded.toggle()
      }
    }
  }
}

struct Glow: View {
    @State var canContinue = true

  var body: some View {
    ZStack {
      Color.clear

     Button {
         canContinue.toggle()
      } label: {
          Text("Continue")
              .padding(.horizontal, 64)
      }
      .conditionalEffect(
          .repeat(
            .glow(color: .blue, radius: 50),
            every: 1.5
          ),
          condition: canContinue
      )
    //  .disabled(!canContinue)
      .animation(.default, value: canContinue)
      .font(.body.bold())
      .buttonStyle(.borderedProminent)
      .buttonBorderShape(.capsule)
      .controlSize(.large)
    }
  }
}

struct poof: View {
  @State var isAdded = true

  var body: some View {
    ZStack {
      Color.clear
            .frame(width: 300, height: 300)
      if isAdded {
          Image("pattern")
                 .resizable()
                 .scaledToFit()
                 .frame(width: 300, height: 300)
          .transition(.movingParts.poof)
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      withAnimation {
        isAdded.toggle()
      }
    }
  }
}

struct LikeButton: View {
  @State var isFavorited = false

  var favoriteCount: Int

  var body: some View {
    Button {
      withAnimation {
        isFavorited.toggle()
      }
    } label: {
      HStack {
        if isFavorited {
          Image(systemName: "heart.fill")
            .foregroundColor(.red)
            .transition(
              .movingParts.pop(.red)
            )
        } else {
          Image(systemName: "heart")
            .foregroundColor(.gray)
            .transition(.identity)
        }

        Text(favoriteCount.formatted())
          .foregroundColor(isFavorited ? .red : .gray)
          .animation(isFavorited ? .default.delay(0.4) : nil, value: isFavorited)
      }
    }
  }
}

enum AnimationPhase: CaseIterable {
    case fadingIn, middle, zoomingOut

    var scale: Double {
        switch self {
        case .fadingIn: 0
        case .middle: 1
        case .zoomingOut: 3
        }
    }

    var opacity: Double {
        switch self {
        case .fadingIn: 0
        case .middle: 1
        case .zoomingOut: 0
        }
    }
}




#Preview {
    ContentView()
}
