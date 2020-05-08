//
//  ScreenSelect.swift
//  mediapipetest
//
//  Created by Santiago Calvo on 5/7/20.
//  Copyright © 2020 Eagerworks. All rights reserved.
//

import SwiftUI

struct ScreenSelectScreen: View {
  @ObservedObject var viewRouter: ViewRouter

  var body: some View {
    VStack {
      VStack(spacing: 10.0) {
        Text("Select screen")
        Spacer()
        Button(action: {
          self.viewRouter.currentPage = .exampleScreen
        }) {
          Text("example screen")
        }
        Spacer()
      }
    }
  }
}

struct LevelSelectScreen_Previews: PreviewProvider {
  static var previews: some View {
    ScreenSelectScreen(viewRouter: ViewRouter())
  }
}
