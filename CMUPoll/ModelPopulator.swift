//
//  ModelPopulator.swift
//  CMUPoll
//
//  Created by Sung on 11/2/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation

class ModelPopulator {
  
  static func populate() {
    for collection in FirebaseDataHandler.collections {
      FirebaseDataHandler.getData(collection: collection, documentId: nil, completion: { data in
        for documentId in data.keys {
          print(data[documentId])
        }
      })
    }
  }
}
