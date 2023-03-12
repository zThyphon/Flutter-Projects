class QuestionModel {
  String? question;
  Map<String, bool>? answer;

  QuestionModel(this.question, this.answer);
}

List<QuestionModel> questions = [
  QuestionModel(
    "How many bits is a byte?",
    {
      "1": false,
      "2": false,
      "4": false,
      "8": true,
    },
  ),
  QuestionModel(
    "Which language is not object oriented?",
    {
      "Java": false,
      "C": true,
      "C++": false,
      "C#": false,
    },
  ),
  QuestionModel(
    "Which language is not using for web programming?",
    {
      "Python": false,
      "C++": true,
      "PHP": false,
      "Java": false,
    },
  ),
  QuestionModel(
    "Which language is not using for mobile programming?",
    {
      "Kotlin": false,
      "Flutter": false,
      "React Native": false,
      "Javascript": true,
    },
  ),
  QuestionModel(
    "Which is not a component of web programming?",
    {
      "Kotlin": true,
      "CSS": false,
      "HTML": false,
      "Javascript": false,
    },
  ),
  QuestionModel(
    "Which is not a physical component of a network?",
    {
      "Switch": false,
      "Router": false,
      "Protocols": true,
      "Hub": false,
    },
  ),
  QuestionModel(
    "Which is not an application layer protocol?",
    {
      "TCP": true,
      "DNS": false,
      "DHCP": false,
      "SMTP": false,
    },
  ),
  QuestionModel(
    "Which is not using with TCP protocol?",
    {
      "HTTP": false,
      "HTTPS": false,
      "FTP": false,
      "DNS": true,
    },
  ),
  QuestionModel(
    "Which is not an packet in TCP 3 way handshake?",
    {
      "SYN": false,
      "SYN-ACK": false,
      "ACK": false,
      "FIN": true,
    },
  ),
  QuestionModel(
    "Which is not a part of information security triad?",
    {
      "Confitentiality": false,
      "Authority": true,
      "Integrity": false,
      "Availability": false,
    },
  ),
];
