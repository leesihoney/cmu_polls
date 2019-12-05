//
//  CommentView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/12/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct CommentView: View {
  let comment: Comment
  let onReply: () -> Void

  @State var commentUser: User?
  @State var parentComment: Comment?
  @State var parentCommentUser: User?
  
  
  var body: some View {
    HStack(alignment: .top, spacing: 20) {
      Image(systemName: "person.fill")
        .font(.system(size: 30))
        .foregroundColor(Color(red: 118 / 255.0, green: 118 / 255.0, blue: 118 / 255.0))
        .padding(.top, 8)
      VStack(alignment: .leading, spacing: 10) {
        VStack(alignment: .leading, spacing: 10) {
          HStack (alignment: .firstTextBaseline){
            VStack(alignment: .leading, spacing: 3) {
              if (self.commentUser != nil) {
                Text("\(self.commentUser!.first_name) \(self.commentUser!.last_name)")
                  .font(Font.system(size: 12, design: .default))
                  .fontWeight(.semibold)
                
                if (self.commentUser!.graduation_year != nil) {
                  Text("\(self.commentUser!.major) • Class of \(String(self.commentUser!.graduation_year!))")
                    .font(Font.system(size: 10, design: .default))
                    .fontWeight(.light)
                    .foregroundColor(Color(red: 116 / 255.0, green: 116 / 255.0, blue: 116 / 255.0))
                }
              }
            }
            Spacer()
            VStack(alignment: .leading) {
              Text(self.comment.getDateDisplayString())
                .font(Font.system(size: 10, design: .default))
                .foregroundColor(Color(red: 116 / 255.0, green: 116 / 255.0, blue: 116 / 255.0))
            }
          }
          .frame(minWidth: 0, maxWidth: .infinity)
          
          HStack(alignment: .firstTextBaseline, spacing: 10) {
            if (self.parentCommentUser != nil) {
              Text("@\(self.parentCommentUser!.first_name) \(self.parentCommentUser!.last_name)")
                .font(Font.system(size: 12, design: .default))
                .fontWeight(.bold)
                .foregroundColor(Color.accentColor)
            }
            Text(self.comment.content)
              .lineLimit(nil)
              .multilineTextAlignment(.leading)
              .font(Font.system(size: 12, design: .default))
              .lineSpacing(6)
            
          }
        }
        .padding(.vertical, 11)
        .padding(.horizontal, 13)
        .background(Color(red: 248 / 255.0, green: 248 / 255.0, blue: 248 / 255.0))
        .cornerRadius(12)
        
        Button(action: {
          self.onReply()
        }, label: {
          ReplyButtonView()
          .padding(.leading, 8)
        }
        )
        

      }
    }
    .onAppear {
      self.getCommentUser()
    }
  }
  
  func getCommentUser() {
    self.comment.user(completion: { user in
      DispatchQueue.main.async {
        self.commentUser = user
        if let id = self.comment.comment_id {
          self.getParentComment(id: id)
        }
      }
    })
  }
  
  func getParentComment(id: String) {
    Comment.withId(id: id, completion: { comment in
      DispatchQueue.main.async {
        self.parentComment = comment
        self.getParentCommentUser()
      }
    })
  }
  
  func getParentCommentUser() {
    if let comment = self.parentComment {
      comment.user(completion: { user in
        self.parentCommentUser = user
      })
    }
  }
}

struct ReplyButtonView: View {
  var body: some View {
    HStack(alignment: .top, spacing: 4) {
      Image(systemName: "arrowshape.turn.up.left.fill")
        .font(.system(size: 12))
        .rotationEffect(.degrees(180), anchor: .center)
        .foregroundColor(Color(red: 140 / 255.0, green: 140 / 255.0, blue: 140 / 255.0))
        .padding(.top, 4.8)
      
        
      Text("Reply")
        .font(Font.system(size: 12, design: .default))
        .foregroundColor(Color(red: 140 / 255.0, green: 140 / 255.0, blue: 140 / 255.0))

      

    }
  }
}
struct CommentView_Previews: PreviewProvider {
  static var previews: some View {
    CommentView(comment: Comment(id: "1", content: "I honestly don’t like any of study places in CMU. They are all too noisy to concentrate.", posted_at: "2019-10-11",
                                 user_id: "2",
                                 comment_id: nil,
                                 poll_id: "1"), onReply: {}
    )
  }
}
