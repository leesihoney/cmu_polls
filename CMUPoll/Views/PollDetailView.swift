//
//  PollDetailView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import UIKit

struct PollDetailView: View {
  let poll: Poll
  @State var tags = [Tag]()
  @State var questions = [Question]()
  @State var comments = [Comment]()
  @State var likes = [Like]()
  @State var pollUser: User?
  @State var questionAnswered = [String: Bool]()
  @State var accumulatedQuestionAnswered = [String: Bool]()
  @State var initialized: Bool = false
  @Environment(\.presentationMode) var presentation
  @State var userAlreadyLiked: Bool = false
  @State var replyingComment: Comment? = nil
  @State var replyingCommentUser: User?
  @State var commentContent: String = ""
  @State var commentsLoaded = false

  
  
  var body: some View {
    VStack(alignment: .leading) {
      ScrollView() {
        VStack(alignment: .leading) {
          if (pollUser != nil) {
            PollUploaderProfileView(uploaderName: "\(pollUser!.first_name) \(pollUser!.last_name)", uploaderMajor: pollUser!.major, uploaderGraduationYear: String(pollUser!.graduation_year ?? 2020), uploadedDaysAgo: self.poll.getDateDisplayString())
          }
          
          HStack(alignment: .firstTextBaseline) {
            Text(poll.title)
              .fontWeight(.semibold)
              .multilineTextAlignment(.leading)
              .font(Font.system(size: 20, design: .default))
              .lineSpacing(10)
            
            Spacer()
            
            if !self.userAlreadyLiked {
              Button(action: {
                print("like button is clicked!")
                print("here, likes: \(self.likes)")
                self.addLike()
                self.getPollLikes()
              }) {
                Image(systemName: "hand.thumbsup")
                  .foregroundColor(.gray)
                  .frame(width: CGFloat(20.0), height: CGFloat(20.0)
                    ,alignment: .bottomLeading)
                Text("Like")
                  .fontWeight(.regular)
                  .foregroundColor(Color.gray)
                  .font(Font.system(size: 10, design: .default))
              }
            }
            else {
              Button(action: {
                print("like button is unclicked!")
                print("here, likes: \(self.likes)")
                self.deleteLike()
                self.getPollLikes()
              }) {
                Image(systemName: "hand.thumbsup.fill")
                  .foregroundColor(.gray)
                  .frame(width: CGFloat(20.0), height: CGFloat(20.0)
                    ,alignment: .bottomLeading)
                Text("Unlike")
                  .fontWeight(.regular)
                  .foregroundColor(Color.gray)
                  .font(Font.system(size: 10, design: .default))
              }
            }
          }
          
          HStack(alignment: .firstTextBaseline, spacing: 5) {
            ForEach(self.tags) { tag in
              TagView(tagText: tag.name)
            }
          }
          .padding(.vertical, 14)
          
          PollDetailDescriptionView(description: poll.description)
          Text(verbatim: "You will get 5 point per questions that you answered")
            .font(Font.system(size: 12, design: .default))
            .fontWeight(.semibold)
            .foregroundColor(Color(red: 236 / 255.0, green: 0 / 255.0, blue: 0 / 255.0))
            .padding(.vertical, 24)
          
          if self.initialized {
            ForEach(self.questions) { question in
              if self.questionAnswered[question.id] == true {
                AnswerGraphView(question: question, onEditedAnswer: {
                  self.questionAnswered[question.id] = false
                })
              } else {
                AnswerBoxView(question: question, onNewAnswer: {
                  self.questionAnswered[question.id] = true
                })
              }
            }
          }
          
          VStack(alignment: .leading, spacing: 10) {
            Text("Comments \(self.comments.count)")
              .font(Font.system(size: 18, design: .default))
              .fontWeight(.semibold)
              .foregroundColor(Color(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0))
            
            if (self.commentsLoaded && self.comments.count > 0) {
              VStack(alignment: .leading, spacing: 9) {
                ForEach(self.comments) { comment in
                  CommentView(comment: comment, onReply: {
                    self.replyingComment = comment
                    self.replyingComment!.user(completion: { user in
                      DispatchQueue.main.async {
                        self.replyingCommentUser = user
                      }
                    })
                  })
                }
              }
              .padding(.leading, 7)
            } else {
              HStack(alignment: .top) {
                Spacer()
                Text("No comments posted for this poll!")
                  .font(Font.system(size: 12, design: .default))
                  .fontWeight(.medium)
                  .foregroundColor(Color(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0))
                Spacer()
              }
              .padding(.vertical, 24)
            }
            
          }
          .padding(.top, 33)
        }
        .navigationBarItems(leading: Button (
          action: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              self.presentation.wrappedValue.dismiss()
            }
        }, label: { Text("Back") }
        ))
      }
      .frame(minWidth: 0, maxWidth: .infinity, idealHeight: 188.0, alignment: .topLeading)
      .multilineTextAlignment(.leading)
      .padding(.vertical, 25)
      .padding(.horizontal, 15)
      .onAppear {
        self.initialized = false
        self.getPollUser()
        self.getPollComments()
        self.getPollLikes()
        self.resetCommentsLoaded()
      }
      VStack {
        if self.replyingComment != nil && self.replyingCommentUser != nil {
          HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
              Text("\(self.replyingCommentUser!.first_name) \(self.replyingCommentUser!.last_name)")
                .font(Font.system(size: 12, design: .default))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0))
              Text("\(self.replyingComment!.content)")
                .font(Font.system(size: 12, design: .default))
                .fontWeight(.regular)
                .foregroundColor(Color(red: 91 / 255.0, green: 91 / 255.0, blue: 91 / 255.0))
                .lineLimit(1)

            }
            Spacer()
            Button (
              action: {
                self.replyingCommentUser = nil
                self.replyingComment = nil
            }, label: {
              Image(systemName: "xmark.circle.fill")
              .font(.system(size: 24))

              
            }
            )
          }
        .padding()
          
        }
        HStack {
          TextField("Enter Comments", text: $commentContent)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.trailing, 4)
          Button(
            action: {
              if self.commentContent.count > 0 {
                Comment.create(content: self.commentContent, comment_id: self.replyingComment?.id, poll_id: self.poll.id ,completion: { comment in
                  print("the comment has been created!")
                  self.commentContent = ""
                  self.replyingCommentUser = nil
                  self.replyingComment = nil
                  self.getPollComments()
                  self.resetCommentsLoaded()
                })
              }
              
          }, label: { Text("Post") }
          )
        }
        .padding()
      }
      .background(Color(red: 248 / 255.0, green: 248 / 255.0, blue: 248 / 255.0, opacity: 0.92))
    }
    
  }
  
  func resetCommentsLoaded() {
    self.commentsLoaded = false
    self.commentsLoaded = true
  }

  
  func getPollUser() {
    self.poll.user(completion: { user in
      DispatchQueue.main.async {
        self.pollUser = user
        self.getPollTags()
      }
    })
  }
  
  func getPollTags() {
    self.poll.tags(completion: { tags in
      DispatchQueue.main.async {
        self.tags = tags
        self.getPollQuestions()
      }
    })
  }
  
  func getPollQuestions() {
    self.poll.questions(completion: { questions in
      DispatchQueue.main.async {
        self.questions = Question.sort(questions)
        self.getQuestionAnswered()
      }
    })
  }
  
  func getPollComments() {
    self.poll.comments(completion: { comments in
      DispatchQueue.main.async {
        self.comments = comments
      }
    })
  }
  func getPollLikes() {
    self.poll.likes(completion: { likes in
      DispatchQueue.main.async {
        self.likes = likes
        print("currently, self likes is \(self.likes)")
        let temp = self.likes.filter {$0.user_id == User.current?.id}
        if temp.isEmpty {
          self.userAlreadyLiked = false
        }
        else {
          self.userAlreadyLiked = true
        }
      }
    })
  }
  
  func addLike() {
    Like.create(poll_id: self.poll.id, completion: { like in })
  }
  
  func deleteLike() {
    let temp = self.likes.filter {$0.user_id == User.current?.id}
    if temp.isEmpty {
      print("current user did not like this poll yet!")
    }
    else {
      print("the like has been deleted!")
      temp[0].delete(completion: { () in }
      )
    }
  }
  func accumulateQuestionAnswered(question_id: String, hasAnswer: Bool) {
    accumulatedQuestionAnswered[question_id] = hasAnswer
    if (accumulatedQuestionAnswered.count >= self.questions.count) {
      self.questionAnswered = self.accumulatedQuestionAnswered
      self.initialized = true
    }
  }
  
  func getQuestionAnswered() {
    self.accumulatedQuestionAnswered = [:]
    for question in self.questions {
      question.userHasAnswer(completion: { hasAnswer in
        DispatchQueue.main.async {
          self.accumulateQuestionAnswered(question_id: question.id, hasAnswer: hasAnswer)
        }
      })
    }
  }
}

struct PollDetailView_Previews: PreviewProvider {
  static var previews: some View {
    PollDetailView(poll: Poll(id: "1", user_id: "1", title: "Who is your favorite IS Professor?", description: "Nyo", posted_at: "2019-10-24", link: "", is_private: false, is_closed: false, passcode: "0"))
  }
}
