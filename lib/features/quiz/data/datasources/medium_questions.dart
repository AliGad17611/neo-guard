import 'package:neo_guard/features/quiz/data/models/question.dart';

final List<Question> mediumQuestions = [
  const Question(
    questionText: 'Which of these is NOT a dwarf planet?',
    options: ['Pluto', 'Ceres', 'Io', 'Eris'],
    correctAnswerIndex: 2,
    explanation: 'Io is one of Jupiter\'s largest moons, not a dwarf planet. Pluto, Ceres, and Eris are all classified as dwarf planets.',
  ),
  const Question(
    questionText: 'What is the term for a star that suddenly increases greatly in brightness because of a catastrophic explosion?',
    options: ['Supernova', 'Red Giant', 'White Dwarf', 'Neutron Star'],
    correctAnswerIndex: 0,
    explanation: 'A supernova is a powerful and luminous stellar explosion. This transient event occurs during the last evolutionary stages of a massive star.',
  ),
  const Question(
    questionText: 'What does the acronym SETI stand for?',
    options: [
      'Search for Extra-Terrestrial Intelligence',
      'Stellar Exploration and Transit Initiative',
      'Solar Emission and Thermal Imaging',
      'Space Expedition and Terraforming Institute'
    ],
    correctAnswerIndex: 0,
    explanation: 'SETI stands for the Search for Extra-Terrestrial Intelligence, which is a collective term for scientific searches for intelligent extraterrestrial life.',
  ),
  const Question(
    questionText: 'The Oort Cloud is a theoretical sphere of what surrounding the solar system?',
    options: ['Gas and Dust', 'Asteroids', 'Comets', 'Dark Matter'],
    correctAnswerIndex: 2,
    explanation: 'The Oort Cloud is a theoretical, immense sphere of icy comets believed to surround the sun at a vast distance.',
  ),
  const Question(
    questionText: 'What is the name of the first artificial satellite launched into space?',
    options: ['Explorer 1', 'Sputnik 1', 'Vanguard 1', 'Telstar 1'],
    correctAnswerIndex: 1,
    explanation: 'Sputnik 1 was the first artificial Earth satellite, launched by the Soviet Union on 4 October 1957.',
  ),
];
