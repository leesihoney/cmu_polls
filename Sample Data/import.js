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

var comments = [
  {
    "id": 0,
    "user_id": 0,
    "comment_id": "NULL",
    "poll_id": 0,
    "content": "I agree with you! I love underground!",
    "posted_at": "2019-10-12"
  },
  {
    "id": 1,
    "user_id": 0,
    "comment_id": 0,
    "poll_id": 0,
    "content": "Well, I like iNoodle the most",
    "posted_at": "2019-10-13"
  },
  {
    "id": 2,
    "user_id": 0,
    "comment_id": 0,
    "poll_id": 0,
    "content": "Actually, you guys should try Chipotle!",
    "posted_at": "2019-10-13"
  },
  {
    "id": 3,
    "user_id": 2,
    "comment_id": "NULL",
    "poll_id": 1,
    "content": "I think that Prof.H is the best professor. He is cool and awesome!",
    "posted_at": "2019-10-14"
  },
  {
    "id": 4,
    "user_id": 0,
    "comment_id": 3,
    "poll_id": 1,
    "content": "I think so too",
    "posted_at": "2019-10-15"
  },
  {
    "id": 5,
    "user_id": 1,
    "comment_id": "NULL",
    "poll_id": 1,
    "content": "I think that Prof.Z is also amazing. She is nice to everyone!",
    "posted_at": "2019-10-15"
  },
  {
    "id": 6,
    "user_id": 4,
    "comment_id": 3,
    "poll_id": 1,
    "content": "You guys will get As! Haha Qapla! ",
    "posted_at": "2019-10-16"
  },
  {
    "id": 7,
    "user_id": 0,
    "comment_id": "NULL",
    "poll_id": 4,
    "content": "I just wanna graduate guys",
    "posted_at": "2019-10-15"
  },
  {
    "id": 8,
    "user_id": 1,
    "comment_id": 7,
    "poll_id": 4,
    "content": "Same here",
    "posted_at": "2019-10-17"
  },
  {
    "id": 9,
    "user_id": 3,
    "comment_id": 7,
    "poll_id": 4,
    "content": "Me too..",
    "posted_at": "2019-10-17"
  }
]

var likes = [
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

var polls = [
  {
    "id": 0,
    "user_id": 0,
    "title": "Where is the best place to eat in CMU?",
    "posted_at": "2019-10-12",
    "link": "www.cmupoll.com/poll0",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "I'm a freshman, and I want to know the best place to eat!"
  },
  {
    "id": 1,
    "user_id": 0,
    "title": "Who is your favorite Information Systems professor?",
    "posted_at": "2019-10-13",
    "link": "www.cmupoll.com/poll1",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "I want to take the best professor's course!"
  },
  {
    "id": 2,
    "user_id": 1,
    "title": "Where do you find the most productive while studying for exams?",
    "posted_at": "2019-10-13",
    "link": "www.cmupoll.com/poll2",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "For me, hunt library is too packed to study hard. Are there any good places to study?"
  },
  {
    "id": 3,
    "user_id": 1,
    "title": "What is your favorite Information Systems course?",
    "posted_at": "2019-10-14",
    "link": "www.cmupoll.com/poll3",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "I'm a freshman IS student. Next week is course registration week, and I want to know which courses to take!"
  },
  {
    "id": 4,
    "user_id": 1,
    "title": "Do you want to go to Graduate school?",
    "posted_at": "2019-10-15",
    "link": "www.cmupoll.com/poll4",
    "private": "FALSE",
    "closed": "TRUE",
    "description": "My parents want me to go a graduate school, but I'm not sure if I want to. So I want to ask you guys how you guys feel about it."
  },
  {
    "id": 5,
    "user_id": 2,
    "title": "Do you find TOC useful?",
    "posted_at": "2019-10-15",
    "link": "www.cmupoll.com/poll5",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "I'm a Senior, but I think that TOC is not very useful. I want to hear your thoughts."
  },
  {
    "id": 6,
    "user_id": 2,
    "title": "How many hours do you normally sleep?",
    "posted_at": "2019-10-16",
    "link": "www.cmupoll.com/poll6",
    "private": "TRUE",
    "closed": "TRUE",
    "description": "I'm researching on the average sleep hours of CMU students for my sociology class."
  },
  {
    "id": 7,
    "user_id": 3,
    "title": "Have you ever felt discrimated in CMU?",
    "posted_at": "2019-10-15",
    "link": "www.cmupoll.com/poll7",
    "private": "TRUE",
    "closed": "TRUE",
    "description": "I'm taking Psychology class. I'm writing a paper about the discrimination. So I wanted to see the occurrence of discrimation happened in CMU"
  },
  {
    "id": 8,
    "user_id": 3,
    "title": "What is your favorite thing about CMU?",
    "posted_at": "2019-10-17",
    "link": "www.cmupoll.com/poll8",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "My favorite thing is the people! How about you?"
  },
  {
    "id": 9,
    "user_id": 5,
    "title": "Any advice for incoming freshman?",
    "posted_at": "2019-10-17",
    "link": "www.cmupoll.com/poll9",
    "private": "FALSE",
    "closed": "FALSE",
    "description": "I'm a incoming freshman. Do you recommend dining plans or housing to live? Thanks a lot!"
  }
]

var questions = [
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

var options = [
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

var answers = [
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
    "option_id": 0
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
    "option_id": 0
  },
  {
    "id": 4,
    "user_id": 1,
    "question_id": 2,
    "option_id": 0
  },
  {
    "id": 5,
    "user_id": 1,
    "question_id": 3,
    "option_id": 0
  },
  {
    "id": 6,
    "user_id": 1,
    "question_id": 4,
    "option_id": 0
  },
  {
    "id": 7,
    "user_id": 1,
    "question_id": 5,
    "option_id": 0
  },
  {
    "id": 8,
    "user_id": 1,
    "question_id": 6,
    "option_id": 0
  },
  {
    "id": 9,
    "user_id": 1,
    "question_id": 7,
    "option_id": 0
  },
  {
    "id": 10,
    "user_id": 1,
    "question_id": 8,
    "option_id": 0
  },
  {
    "id": 11,
    "user_id": 2,
    "question_id": 3,
    "option_id": 0
  },
  {
    "id": 12,
    "user_id": 2,
    "question_id": 9,
    "option_id": 0
  },
  {
    "id": 13,
    "user_id": 2,
    "question_id": 10,
    "option_id": 0
  },
  {
    "id": 14,
    "user_id": 3,
    "question_id": 1,
    "option_id": 0
  },
  {
    "id": 15,
    "user_id": 3,
    "question_id": 4,
    "option_id": 0
  },
  {
    "id": 16,
    "user_id": 3,
    "question_id": 7,
    "option_id": 0
  },
  {
    "id": 17,
    "user_id": 3,
    "question_id": 10,
    "option_id": 0
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
    "option_id": 0
  }
]

var polltags = [
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
    "tag_id": 6
  },
  {
    "id": 7,
    "poll_id": 3,
    "tag_id": 7
  },
  {
    "id": 8,
    "poll_id": 3,
    "tag_id": 8
  },
  {
    "id": 9,
    "poll_id": 4,
    "tag_id": 9
  },
  {
    "id": 10,
    "poll_id": 5,
    "tag_id": 10
  },
  {
    "id": 11,
    "poll_id": 6,
    "tag_id": 11
  },
  {
    "id": 12,
    "poll_id": 6,
    "tag_id": 12
  },
  {
    "id": 13,
    "poll_id": 7,
    "tag_id": 13
  },
  {
    "id": 14,
    "poll_id": 7,
    "tag_id": 14
  },
  {
    "id": 15,
    "poll_id": 8,
    "tag_id": 15
  },
  {
    "id": 16,
    "poll_id": 8,
    "tag_id": 16
  },
  {
    "id": 17,
    "poll_id": 9,
    "tag_id": 17
  },
  {
    "id": 18,
    "poll_id": 9,
    "tag_id": 18
  },
  {
    "id": 19,
    "poll_id": 9,
    "tag_id": 19
  }
]

var tags = [
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
    "name": "place"
  },
  {
    "id": 7,
    "name": "Course"
  },
  {
    "id": 8,
    "name": "Academic"
  },
  {
    "id": 9,
    "name": "Academic"
  },
  {
    "id": 10,
    "name": "Career"
  },
  {
    "id": 11,
    "name": "Time"
  },
  {
    "id": 12,
    "name": "Research"
  },
  {
    "id": 13,
    "name": "Research"
  },
  {
    "id": 14,
    "name": "Discrimination"
  },
  {
    "id": 15,
    "name": "Life"
  },
  {
    "id": 16,
    "name": "Favorite"
  },
  {
    "id": 17,
    "name": "Freshman"
  },
  {
    "id": 18,
    "name": "life"
  },
  {
    "id": 19,
    "name": "Recommendation"
  }
]

var users = [
  {
    "id": 0,
    "first_name": "Aiden",
    "last_name": "Lee",
    "major": "Information Systems",
    "points": 1230,
    "graduation year": 2020
  },
  {
    "id": 1,
    "first_name": "Andrew",
    "last_name": "Lee",
    "major": "Information Systems",
    "points": 4124,
    "graduation year": 2020
  },
  {
    "id": 2,
    "first_name": "Sungho",
    "last_name": "Cho",
    "major": "Information Systems",
    "points": 1231,
    "graduation year": 2020
  },
  {
    "id": 3,
    "first_name": "Anna",
    "last_name": "Yuan",
    "major": "Information Systems",
    "points": 214,
    "graduation year": 2020
  },
  {
    "id": 4,
    "first_name": "Heimann",
    "last_name": "Larry",
    "major": "NULL",
    "points": 4124,
    "graduation year": "NULL"
  },
  {
    "id": 5,
    "first_name": "Andy",
    "last_name": "Kim",
    "major": "Sociology",
    "points": 2,
    "graduation year": 2024
  }
]

comments.forEach(function(obj) {
    db.collection("comments").add({
        id: obj.id,
        user_id: obj.user_id,
        comment_id: obj.comment_id,
        poll_id: obj.poll_id,
        content: obj.content,
        posted_at: obj.posted_at,
    }).then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});

likes.forEach(function(obj) {
    db.collection("likes").add({
        id: obj.id,
        user_id: obj.user_id,
        poll_id: obj.poll_id,
    }).then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});

polls.forEach(function(obj) {
    db.collection("polls").add({
        id: obj.id,
        user_id: obj.user_id,
        title: obj.title,
        posted_at: obj.posted_at,
        link: obj.link,
        private: obj.private,
        closed: obj.closed,
        description: obj.description,
    }).then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});

questions.forEach(function(obj) {
    db.collection("questions").add({
        id: obj.id,
        poll_id: obj.poll_id,
        is_multiple_choice: obj.is_multiple_choice,
        title: obj.title,
    }).then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});

options.forEach(function(obj) {
    db.collection("options").add({
        id: obj.id,
        question_id: obj.question_id,
        text: obj.text,
    }).then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});

answers.forEach(function(obj) {
    db.collection("answers").add({
        id: obj.id,
        user_id: obj.user_id,
        question_id: obj.question_id,
        option_id: obj.option_id,
    }).then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});

polltags.forEach(function(obj) {
    db.collection("polltags").add({
        id: obj.id,
        poll_id: obj.poll_id,
        tag_id: obj.tag_id,
    }).then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});

tags.forEach(function(obj) {
    db.collection("tags").add({
        id: obj.id,
        name: obj.name,
    }).then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});

users.forEach(function(obj) {
    db.collection("users").add({
        id: obj.id,
        first_name: obj.first_name,
        last_name: obj.last_name,
        major: obj.major,
        points: obj.points,
        graduation_year: obj["graduation year"],
    }).then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});
