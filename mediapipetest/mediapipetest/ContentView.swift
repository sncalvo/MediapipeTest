//
//  ContentView.swift
//  mediapipetest
//
//  Created by Santiago Calvo on 5/7/20.
//  Copyright © 2020 Eagerworks. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewRouter: ViewRouter

  var body: some View {
    switch viewRouter.currentPage {
    case .exampleScreen:
      return AnyView(MediapipeTestScreen(viewRouter: viewRouter))
    default:
      return AnyView(ScreenSelectScreen(viewRouter: viewRouter))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView(viewRouter: ViewRouter())
    }
}
