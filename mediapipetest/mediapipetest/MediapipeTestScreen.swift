//
//  MediapipeTestScreen.swift
//  mediapipetest
//
//  Created by Santiago Calvo on 5/7/20.
//  Copyright © 2020 Eagerworks. All rights reserved.
//

import SwiftUI

struct MediapipeTestScreen: View {
  @ObservedObject var viewRouter: ViewRouter

  init(viewRouter: ViewRouter) {
    self.viewRouter = viewRouter
  }

  var body: some View {
    VStack {
      HStack {
        Button(action: { self.viewRouter.currentPage = .mainScreen }) {
          Text("Back")
        }.padding()
        Spacer()
      }.padding()
      Spacer()
      Spacer()
      MediapipeHandler()
        .frame(maxWidth: 300, maxHeight: 400 ,alignment: .center)
        .padding()
      Spacer()
    }.frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct VideoChatScreen_Previews: PreviewProvider {
  static var previews: some View {
    MediapipeTestScreen(viewRouter: ViewRouter())
  }
}

