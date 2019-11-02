//
//  Tag.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Tag: Identifiable {
  var id = UUID()
  var name: String
  var documentId: String = "It is a document for model: Tag"
  
  init (name: String, documentId: String) {
    self.name = name
    self.documentId = documentId
  }
}
