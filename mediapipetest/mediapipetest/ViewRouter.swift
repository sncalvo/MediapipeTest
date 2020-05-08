//
//  ViewRouter.swift
//  mediapipetest
//
//  Created by Santiago Calvo on 5/7/20.
//  Copyright © 2020 Eagerworks. All rights reserved.
//

import Combine
import SwiftUI

class ViewRouter: ObservableObject {
  let objectWillChange = PassthroughSubject<ViewRouter, Never>()

  var currentPage: Pages = .mainScreen {
    didSet {
      objectWillChange.send(self)
    }
  }
}

enum Pages: String {
  case exampleScreen, mainScreen
}
