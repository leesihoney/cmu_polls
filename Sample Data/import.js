const firebase = require("firebase");
// Required for side-effects
require("firebase/firestore");

// Initialize Cloud Firestore through Firebase
firebase.initializeApp({
    apiKey: "AIzaSyDkujOfKPxvvvzlbv63K7HVyj17xPFmmBE",
    authDomain: "https://cmupoll-1569464537887.firebaseio.com",
    projectId: "cmupoll-1569464537887"
  });

var db = firebase.firestore();

var comment = [
  {
    "id": 0,
    "user_id": 0,
    "comment_id": "NULL",
    "poll_id": 0,
    "content": "I agree with you! I love underground!",
    "posted_at": "2019-10-12 12:24:26"
  },
  {
    "id": 1,
    "user_id": 0,
    "comment_id": 0,
    "poll_id": 0,
    "content": "Well, I like iNoodle the most",
    "posted_at": "2019-10-13 13:17:18"
  },
  {
    "id": 2,
    "user_id": 0,
    "comment_id": 0,
    "poll_id": 0,
    "content": "Actually, you guys should try Chipotle!",
    "posted_at": "2019-10-13 23:59:59"
  },
  {
    "id": 3,
    "user_id": 2,
    "comment_id": "NULL",
    "poll_id": 1,
    "content": "I think that Prof.H is the best professor. He is cool and awesome!",
    "posted_at": "2019-10-14 00:00:00"
  },
  {
    "id": 4,
    "user_id": 0,
    "comment_id": 3,
    "poll_id": 1,
    "content": "I think so too",
    "posted_at": "2019-10-15 01:01:01"
  },
  {
    "id": 5,
    "user_id": 1,
    "comment_id": "NULL",
    "poll_id": 1,
    "content": "I think that Prof.Z is also amazing. She is nice to everyone!",
    "posted_at": "2019-10-15 12:30:30"
  },
  {
    "id": 6,
    "user_id": 4,
    "comment_id": 3,
    "poll_id": 1,
    "content": "You guys will get As! Haha Qapla! ",
    "posted_at": "2019-10-16 08:45:15"
  },
  {
    "id": 7,
    "user_id": 0,
    "comment_id": "NULL",
    "poll_id": 4,
    "content": "I just wanna graduate guys",
    "posted_at": "2019-10-15 02:19:27"
  },
  {
    "id": 8,
    "user_id": 1,
    "comment_id": 7,
    "poll_id": 4,
    "content": "Same here",
    "posted_at": "2019-10-17 06:15:49"
  },
  {
    "id": 9,
    "user_id": 3,
    "comment_id": 7,
    "poll_id": 4,
    "content": "Me too..",
    "posted_at": "2019-10-17 01:03:31"
  }
]

var like = [
  {
    "id": 0,
    "user_id": 0,
    "poll_id": 0
  },
  {
    "id": 1,
    "user_id": 0,
    "poll_id": 1
  },
  {
    "id": 2,
    "user_id": 1,
    "poll_id": 1
  },
  {
    "id": 3,
    "user_id": 1,
    "poll_id": 1
  },
  {
    "id": 4,
    "user_id": 1,
    "poll_id": 2
  },
  {
    "id": 5,
    "user_id": 2,
    "poll_id": 2
  },
  {
    "id": 6,
    "user_id": 2,
    "poll_id": 3
  },
  {
    "id": 7,
    "user_id": 3,
    "poll_id": 0
  },
  {
    "id": 8,
    "user_id": 3,
    "poll_id": 4
  },
  {
    "id": 9,
    "user_id": 3,
    "poll_id": 5
  },
  {
    "id": 10,
    "user_id": 3,
    "poll_id": 6
  },
  {
    "id": 11,
    "user_id": 3,
    "poll_id": 7
  },
  {
    "id": 12,
    "user_id": 3,
    "poll_id": 8
  },
  {
    "id": 13,
    "user_id": 3,
    "poll_id": 9
  },
  {
    "id": 14,
    "user_id": 4,
    "poll_id": 1
  },
  {
    "id": 15,
    "user_id": 4,
    "poll_id": 2
  },
  {
    "id": 16,
    "user_id": 4,
    "poll_id": 3
  },
  {
    "id": 17,
    "user_id": 4,
    "poll_id": 4
  },
  {
    "id": 18,
    "user_id": 4,
    "poll_id": 5
  },
  {
    "id": 19,
    "user_id": 4,
    "poll_id": 6
  }
]

var poll = [
  {
    "id": 0,
    "user_id": 0,
    "title": "Where is the best place to eat in CMU?",
    "posted_at": "2019-10-12 13:15:19",
    "link": "www.cmupoll.com/poll0",
    "private": "TRUE",
    "closed": "TRUE",
    "description": "I'm a freshman, and I want to know the best place to eat!",
    "passcode": "1234"
  },
  {
    "id": 1,
    "user_id": 0,
    "title": "Who is your favorite Information Systems professor?",
    "posted_at": "2019-10-13 08:08:08",
    "link": "www.cmupoll.com/poll1",
    "private": "TRUE",
    "closed": "FALSE",
    "description": "I want to take the best professor's course!",
    "passcode": "0"
  },
  {
    "id": 2,
    "user_id": 1,
    "title": "Where do you find the most productive while studying for exams?",
    "posted_at": "2019-10-13 01:00:00",
    "link": "www.cmupoll.com/poll2",
    "private": "FALSE",
    "closed": "TRUE",
    "description": "For me, hunt library is too packed to study hard. Are there any good places to study?",
    "passcode": "NULL"
  },
  {
    "id": 3,
    "user_id": 1,
    "title": "What is your favorite Information Systems course?",
    "posted_at": "2019-10-14 23:23:23",
    "link": "www.cmupoll.com/poll3",
    "private": "FALSE",
    "closed": "TRUE",
    "description": "I'm a freshman IS student. Next week is course registration week, and I want to know which courses to take!",
    "passcode": "NULL"
  },
  {
    "id": 4,
    "user_id": 1,
    "title": "Do you want to go to Graduate school?",
    "posted_at": "2019-10-15 23:59:59",
    "link": "www.cmupoll.com/poll4",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "My parents want me to go a graduate school, but I'm not sure if I want to. So I want to ask you guys how you guys feel about it.",
    "passcode": "NULL"
  },
  {
    "id": 5,
    "user_id": 2,
    "title": "Do you find TOC useful?",
    "posted_at": "2019-10-15 23:59:59",
    "link": "www.cmupoll.com/poll5",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "I'm a Senior, but I think that TOC is not very useful. I want to hear your thoughts.",
    "passcode": "NULL"
  },
  {
    "id": 6,
    "user_id": 2,
    "title": "How many hours do you normally sleep?",
    "posted_at": "2019-10-16 13:49:12",
    "link": "www.cmupoll.com/poll6",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "I'm researching on the average sleep hours of CMU students for my sociology class.",
    "passcode": "NULL"
  },
  {
    "id": 7,
    "user_id": 3,
    "title": "Have you ever felt discrimated in CMU?",
    "posted_at": "2019-10-15 11:18:17",
    "link": "www.cmupoll.com/poll7",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "I'm taking Psychology class. I'm writing a paper about the discrimination. So I wanted to see the occurrence of discrimation happened in CMU",
    "passcode": "NULL"
  },
  {
    "id": 8,
    "user_id": 3,
    "title": "What is your favorite thing about CMU?",
    "posted_at": "2019-10-17 16:19:13",
    "link": "www.cmupoll.com/poll8",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "My favorite thing is the people! How about you?",
    "passcode": "NULL"
  },
  {
    "id": 9,
    "user_id": 5,
    "title": "Any advice for incoming freshman?",
    "posted_at": "2019-10-17 14:14:14",
    "link": "www.cmupoll.com/poll9",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "I'm a incoming freshman. Do you recommend dining plans or housing to live? Thanks a lot!",
    "passcode": "NULL"
  }
]

var question = [
  {
    "id": 0,
    "poll_id": 0,
    "is_multiple_choice": "TRUE",
    "title": "Where is the best place to eat in CMU?"
  },
  {
    "id": 1,
    "poll_id": 0,
    "is_multiple_choice": "TRUE",
    "title": "Where is the best place to eat near CMU?"
  },
  {
    "id": 2,
    "poll_id": 1,
    "is_multiple_choice": "TRUE",
    "title": "Who is your favorite Information Systems professor?"
  },
  {
    "id": 3,
    "poll_id": 2,
    "is_multiple_choice": "TRUE",
    "title": "Where do you find the most productive while studying for exams?"
  },
  {
    "id": 4,
    "poll_id": 3,
    "is_multiple_choice": "TRUE",
    "title": "What is your favorite Information Systems course?"
  },
  {
    "id": 5,
    "poll_id": 4,
    "is_multiple_choice": "TRUE",
    "title": "Do you want to go to Graduate school?"
  },
  {
    "id": 6,
    "poll_id": 5,
    "is_multiple_choice": "FALSE",
    "title": "Do you find TOC useful?"
  },
  {
    "id": 7,
    "poll_id": 6,
    "is_multiple_choice": "TRUE",
    "title": "How many hours do you normally sleep?"
  },
  {
    "id": 8,
    "poll_id": 7,
    "is_multiple_choice": "TRUE",
    "title": "Have you ever felt discrimated in CMU?"
  },
  {
    "id": 9,
    "poll_id": 8,
    "is_multiple_choice": "TRUE",
    "title": "What is your favorite thing about CMU?"
  },
  {
    "id": 10,
    "poll_id": 9,
    "is_multiple_choice": "TRUE",
    "title": "Any advice for incoming freshman?"
  }
]

var option = [
  {
    "id": 0,
    "question_id": 0,
    "text": "iNoodle"
  },
  {
    "id": 1,
    "question_id": 0,
    "text": "Tartam Express"
  },
  {
    "id": 2,
    "question_id": 0,
    "text": "Exchange"
  },
  {
    "id": 3,
    "question_id": 1,
    "text": "Union Grill"
  },
  {
    "id": 4,
    "question_id": 1,
    "text": "Orient Express"
  },
  {
    "id": 5,
    "question_id": 1,
    "text": "Chipotle"
  },
  {
    "id": 6,
    "question_id": 2,
    "text": "Prof. H"
  },
  {
    "id": 7,
    "question_id": 2,
    "text": "Prof. Z"
  },
  {
    "id": 8,
    "question_id": 2,
    "text": "Prof. K"
  },
  {
    "id": 9,
    "question_id": 3,
    "text": "Hunt Library"
  },
  {
    "id": 10,
    "question_id": 3,
    "text": "Sorrells Library"
  },
  {
    "id": 11,
    "question_id": 3,
    "text": "Home"
  },
  {
    "id": 12,
    "question_id": 4,
    "text": "67-442"
  },
  {
    "id": 13,
    "question_id": 4,
    "text": "67-272"
  },
  {
    "id": 14,
    "question_id": 4,
    "text": "67-373"
  },
  {
    "id": 15,
    "question_id": 5,
    "text": "Yes"
  },
  {
    "id": 16,
    "question_id": 5,
    "text": "No"
  },
  {
    "id": 17,
    "question_id": 6,
    "text": "Yes"
  },
  {
    "id": 18,
    "question_id": 6,
    "text": "No"
  },
  {
    "id": 19,
    "question_id": 7,
    "text": "4-6 hours"
  },
  {
    "id": 20,
    "question_id": 7,
    "text": "6-8 hours"
  },
  {
    "id": 21,
    "question_id": 7,
    "text": "8-10 hours"
  },
  {
    "id": 22,
    "question_id": 8,
    "text": "Yes"
  },
  {
    "id": 23,
    "question_id": 8,
    "text": "No"
  },
  {
    "id": 24,
    "question_id": 9,
    "text": "People"
  },
  {
    "id": 25,
    "question_id": 9,
    "text": "Pittsburgh"
  },
  {
    "id": 26,
    "question_id": 9,
    "text": "Academics"
  },
  {
    "id": 27,
    "question_id": 10,
    "text": "Study hard"
  },
  {
    "id": 28,
    "question_id": 10,
    "text": "Get some sleep"
  },
  {
    "id": 29,
    "question_id": 10,
    "text": "Play hard"
  }
]

var answer = [
  {
    "id": 0,
    "user_id": 0,
    "question_id": 0,
    "option_id": 0
  },
  {
    "id": 1,
    "user_id": 0,
    "question_id": 1,
    "option_id": 3
  },
  {
    "id": 2,
    "user_id": 0,
    "question_id": 4,
    "option_id": 0
  },
  {
    "id": 3,
    "user_id": 0,
    "question_id": 5,
    "option_id": 15
  },
  {
    "id": 4,
    "user_id": 1,
    "question_id": 2,
    "option_id": 6
  },
  {
    "id": 5,
    "user_id": 1,
    "question_id": 3,
    "option_id": 9
  },
  {
    "id": 6,
    "user_id": 1,
    "question_id": 4,
    "option_id": 12
  },
  {
    "id": 7,
    "user_id": 1,
    "question_id": 5,
    "option_id": 16
  },
  {
    "id": 8,
    "user_id": 1,
    "question_id": 6,
    "option_id": 17
  },
  {
    "id": 9,
    "user_id": 1,
    "question_id": 7,
    "option_id": 19
  },
  {
    "id": 10,
    "user_id": 1,
    "question_id": 8,
    "option_id": 22
  },
  {
    "id": 11,
    "user_id": 2,
    "question_id": 3,
    "option_id": 10
  },
  {
    "id": 12,
    "user_id": 2,
    "question_id": 9,
    "option_id": 24
  },
  {
    "id": 13,
    "user_id": 2,
    "question_id": 10,
    "option_id": 27
  },
  {
    "id": 14,
    "user_id": 3,
    "question_id": 1,
    "option_id": 4
  },
  {
    "id": 15,
    "user_id": 3,
    "question_id": 4,
    "option_id": 13
  },
  {
    "id": 16,
    "user_id": 3,
    "question_id": 7,
    "option_id": 20
  },
  {
    "id": 17,
    "user_id": 3,
    "question_id": 10,
    "option_id": 28
  },
  {
    "id": 18,
    "user_id": 4,
    "question_id": 0,
    "option_id": 0
  },
  {
    "id": 19,
    "user_id": 4,
    "question_id": 8,
    "option_id": 23
  }
]

var polltag = [
  {
    "id": 0,
    "poll_id": 0,
    "tag_id": 0
  },
  {
    "id": 1,
    "poll_id": 0,
    "tag_id": 1
  },
  {
    "id": 2,
    "poll_id": 0,
    "tag_id": 2
  },
  {
    "id": 3,
    "poll_id": 1,
    "tag_id": 3
  },
  {
    "id": 4,
    "poll_id": 1,
    "tag_id": 4
  },
  {
    "id": 5,
    "poll_id": 1,
    "tag_id": 5
  },
  {
    "id": 6,
    "poll_id": 2,
    "tag_id": 2
  },
  {
    "id": 7,
    "poll_id": 3,
    "tag_id": 6
  },
  {
    "id": 8,
    "poll_id": 3,
    "tag_id": 3
  },
  {
    "id": 9,
    "poll_id": 4,
    "tag_id": 3
  },
  {
    "id": 10,
    "poll_id": 5,
    "tag_id": 7
  },
  {
    "id": 11,
    "poll_id": 6,
    "tag_id": 8
  },
  {
    "id": 12,
    "poll_id": 6,
    "tag_id": 9
  },
  {
    "id": 13,
    "poll_id": 7,
    "tag_id": 9
  },
  {
    "id": 14,
    "poll_id": 7,
    "tag_id": 10
  },
  {
    "id": 15,
    "poll_id": 8,
    "tag_id": 0
  },
  {
    "id": 16,
    "poll_id": 8,
    "tag_id": 11
  },
  {
    "id": 17,
    "poll_id": 9,
    "tag_id": 12
  },
  {
    "id": 18,
    "poll_id": 9,
    "tag_id": 0
  },
  {
    "id": 19,
    "poll_id": 9,
    "tag_id": 13
  }
]

var tag = [
  {
    "id": 0,
    "name": "Life"
  },
  {
    "id": 1,
    "name": "Food"
  },
  {
    "id": 2,
    "name": "Place"
  },
  {
    "id": 3,
    "name": "Academic"
  },
  {
    "id": 4,
    "name": "Information Systems"
  },
  {
    "id": 5,
    "name": "Professor"
  },
  {
    "id": 6,
    "name": "Course"
  },
  {
    "id": 7,
    "name": "Career"
  },
  {
    "id": 8,
    "name": "Time"
  },
  {
    "id": 9,
    "name": "Research"
  },
  {
    "id": 10,
    "name": "Discrimination"
  },
  {
    "id": 11,
    "name": "Favorite"
  },
  {
    "id": 12,
    "name": "Freshman"
  },
  {
    "id": 13,
    "name": "Recommendation"
  }
]

var user = [
  {
    "id": 0,
    "first_name": "Aiden",
    "last_name": "Lee",
    "email": "yonghoo@andrew.cmu.edu",
    "major": "Information Systems",
    "points": 1230,
    "graduation year": 2020
  },
  {
    "id": 1,
    "first_name": "Andrew",
    "last_name": "Lee",
    "email": "siheon@andrew.cmu.edu",
    "major": "Information Systems",
    "points": 4124,
    "graduation year": 2020
  },
  {
    "id": 2,
    "first_name": "Sungho",
    "last_name": "Cho",
    "email": "sunghocho@andrew.cmu.edu",
    "major": "Information Systems",
    "points": 1231,
    "graduation year": 2020
  },
  {
    "id": 3,
    "first_name": "Anna",
    "last_name": "Yuan",
    "email": "xinrany@andrew.cmu.edu",
    "major": "Information Systems",
    "points": 214,
    "graduation year": 2020
  },
  {
    "id": 4,
    "first_name": "Larry",
    "last_name": "Heimann",
    "email": "profh@cmu.edu",
    "major": "Information Systems",
    "points": 4124,
    "graduation year": "NULL"
  },
  {
    "id": 5,
    "first_name": "Andy",
    "last_name": "Kim",
    "email": "andykim@andrew.cmu.edu",
    "major": "Sociology",
    "points": 2,
    "graduation year": 2024
  }
]

function deleteCollection(db, collectionPath, batchSize) {
  let collectionRef = db.collection(collectionPath);
  let query = collectionRef.orderBy('__name__').limit(batchSize);

  return new Promise((resolve, reject) => {
    deleteQueryBatch(db, query, batchSize, resolve, reject);
  });
}

function deleteQueryBatch(db, query, batchSize, resolve, reject) {
  query.get()
    .then((snapshot) => {
      // When there are no documents left, we are done
      if (snapshot.size == 0) {
        return 0;
      }

      // Delete documents in a batch
      let batch = db.batch();
      snapshot.docs.forEach((doc) => {
        batch.delete(doc.ref);
      });

      return batch.commit().then(() => {
        return snapshot.size;
      });
    }).then((numDeleted) => {
      if (numDeleted === 0) {
        resolve();
        return;
      }

      // Recurse on the next process tick, to avoid
      // exploding the stack.
      process.nextTick(() => {
        deleteQueryBatch(db, query, batchSize, resolve, reject);
      });
    })
    .catch(reject);
}

deleteCollection(db, "poll", 100);
deleteCollection(db, "like", 100);
deleteCollection(db, "user", 100);
deleteCollection(db, "comment", 100);
deleteCollection(db, "polltag", 100);
deleteCollection(db, "tag", 100);
deleteCollection(db, "question", 100);
deleteCollection(db, "answer", 100);
deleteCollection(db, "option", 100);

// comment.forEach(function(obj) {
//     db.collection("comment").doc(obj.id.toString()).set({
//         // id: obj.id.toString(),
//         user_id: obj.user_id.toString(),
//         comment_id: obj.comment_id.toString() == "NULL" ? null : obj["graduation_year"],
//         poll_id: obj.poll_id.toString(),
//         content: obj.content,
//         posted_at: obj.posted_at,
//     }).then(function(docRef) {
//         // console.log("Document written with ID: ", docRef.id);
//     })
//     .catch(function(error) {
//         console.error("Error adding document: ", error);
//     });
// });
//
// like.forEach(function(obj) {
//     db.collection("like").doc(obj.id.toString()).set({
//         // id: obj.id.toString(),
//         user_id: obj.user_id.toString(),
//         poll_id: obj.poll_id.toString(),
//     }).then(function(docRef) {
//         // console.log("Document written with ID: ", docRef.id);
//     })
//     .catch(function(error) {
//         console.error("Error adding document: ", error);
//     });
// });
//
// poll.forEach(function(obj) {
//     db.collection("poll").doc(obj.id.toString()).set({
//         // id: obj.id.toString(),
//         user_id: obj.user_id.toString(),
//         title: obj.title,
//         posted_at: obj.posted_at,
//         link: obj.link,
//         private: obj.private == "TRUE" ? true : false,
//         closed: obj.closed == "TRUE" ? true : false,
//         description: obj.description,
//         passcode: obj["passcode"] == "NULL" ? null : obj["passcode"],
//     }).then(function(docRef) {
//         // console.log("Document written with ID: ", docRef.id);
//     })
//     .catch(function(error) {
//         console.error("Error adding document: ", error);
//     });
// });
//
// question.forEach(function(obj) {
//     db.collection("question").doc(obj.id.toString()).set({
//         // id: obj.id.toString(),
//         poll_id: obj.poll_id.toString(),
//         is_multiple_choice: obj.is_multiple_choice == "TRUE" ? true : false,
//         title: obj.title,
//     }).then(function(docRef) {
//         // console.log("Document written with ID: ", docRef.id);
//     })
//     .catch(function(error) {
//         console.error("Error adding document: ", error);
//     });
// });
//
// option.forEach(function(obj) {
//     db.collection("option").doc(obj.id.toString()).set({
//         // id: obj.id.toString(),
//         question_id: obj.question_id.toString(),
//         text: obj.text,
//     }).then(function(docRef) {
//         // console.log("Document written with ID: ", docRef.id);
//     })
//     .catch(function(error) {
//         console.error("Error adding document: ", error);
//     });
// });
//
// answer.forEach(function(obj) {
//     db.collection("answer").doc(obj.id.toString()).set({
//         // id: obj.id.toString(),
//         user_id: obj.user_id.toString(),
//         question_id: obj.question_id.toString(),
//         option_id: obj.option_id.toString(),
//     }).then(function(docRef) {
//         // console.log("Document written with ID: ", docRef.id);
//     })
//     .catch(function(error) {
//         console.error("Error adding document: ", error);
//     });
// });
//
// polltag.forEach(function(obj) {
//     db.collection("polltag").doc(obj.id.toString()).set({
//         // id: obj.id.toString(),
//         poll_id: obj.poll_id.toString(),
//         tag_id: obj.tag_id.toString(),
//     }).then(function(docRef) {
//         // console.log("Document written with ID: ", docRef.id);
//     })
//     .catch(function(error) {
//         console.error("Error adding document: ", error);
//     });
// });
//
// tag.forEach(function(obj) {
//     db.collection("tag").doc(obj.id.toString()).set({
//         // id: obj.id.toString(),
//         name: obj.name,
//     }).then(function(docRef) {
//         // console.log("Document written with ID: ", docRef.id);
//     })
//     .catch(function(error) {
//         console.error("Error adding document: ", error);
//     });
// });
//
// user.forEach(function(obj) {
//     db.collection("user").doc(obj.id.toString()).set({
//         // id: obj.id.toString(),
//         first_name: obj.first_name,
//         last_name: obj.last_name,
//         email: obj.email,
//         major: obj.major,
//         points: obj.points,
//         graduation_year: obj["graduation year"] == "NULL" ? null : obj["graduation_year"],
//     }).then(function(docRef) {
//         // console.log("Document written with ID: ", docRef.id);
//     })
//     .catch(function(error) {
//         console.error("Error adding document: ", error);
//     });
// });
