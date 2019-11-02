//
//  FirebaseDataHandler.swift
//  CMUPoll
//
//  Created by Sung on 10/24/19.
//  Copyright © 2019 67442. All rights reserved.
//
import Foundation
import Firebase

typealias FirebaseData = [String:Any]

class FirebaseDataHandler {

  static let db = Firestore.firestore()
  static let collections = ["user", "poll", "question", "like", "comment", "tag", "option", "answer"]

  // CREATE
  static func addData(collection: String, data: FirebaseData) {
    var ref: DocumentReference? = nil
    ref = db.collection(collection).addDocument(data: data) { err in
      if let err = err {
        print("Error adding document: \(err)")
      } else {
        print("Document added with ID: \(ref!.documentID)")
      }
    }
  }

  // READ
  static func getData(collection: String, documentId: String?, completion: @escaping (FirebaseData) -> ()) {
    var data: FirebaseData = [:]
    // Get a specific document for a collection
    if let id = documentId {
      let docRef = db.collection(collection).document(id)
      docRef.getDocument { (document, error) in
        if let document = document, document.exists {
          data[document.documentID] = document.data()!
        } else {
          print("Document does not exist")
        }
      }
      completion(data)
    }
    // Get ALL documents for a collection
    else {
      db.collection(collection).getDocuments() { (querySnapshot, err) in
        if let err = err {
          print("Error getting documents: \(err)")
        } else {
          for document in querySnapshot!.documents {
            data[document.documentID] = document.data()
          }
        }
        completion(data)
      }
    }
  }

  // UPDATE
  static func updateData(collection: String, documentId: String, data: FirebaseData) {
    let docRef = db.collection(collection).document(documentId)
    docRef.updateData(data) { err in
      if let err = err {
        print("Error updating document: \(err)")
      } else {
        print("Document successfully updated")
      }
    }
  }

  // DELETE
  static func removeData(collection: String, documentId: String) {
    let docRef = db.collection(collection).document(documentId)
    docRef.delete() { err in
      if let err = err {
        print("Error removing document: \(err)")
      } else {
        print("Document successfully removed!")
      }
    }
  }
}
