class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

final List<Question> easyQuestions = [
  const Question(
    questionText: 'What is the largest planet in our Solar System?',
    options: ['Earth', 'Mars', 'Jupiter', 'Saturn'],
    correctAnswerIndex: 2,
    explanation: 'Jupiter is the largest planet, more than twice as massive as all the other planets combined.',
  ),
  const Question(
    questionText: 'Which planet is known as the Red Planet?',
    options: ['Venus', 'Mars', 'Mercury', 'Uranus'],
    correctAnswerIndex: 1,
    explanation: 'Mars is known as the Red Planet due to the iron oxide prevalent on its surface, giving it a reddish appearance.',
  ),
  const Question(
    questionText: 'What is at the center of our Solar System?',
    options: ['The Earth', 'A Black Hole', 'The Moon', 'The Sun'],
    correctAnswerIndex: 3,
    explanation: 'The Sun, a star, is the center of our Solar System, and all planets orbit around it.',
  ),
  const Question(
    questionText: 'How many moons does Earth have?',
    options: ['One', 'Two', 'None', 'Three'],
    correctAnswerIndex: 0,
    explanation: 'Earth has only one natural satellite, which we call the Moon.',
  ),
  const Question(
    questionText: 'What is the name of the galaxy that contains our Solar System?',
    options: ['Andromeda', 'Triangulum', 'Whirlpool', 'Milky Way'],
    correctAnswerIndex: 3,
    explanation: 'Our Solar System is located in the Milky Way galaxy, a barred spiral galaxy.',
  ),
];
