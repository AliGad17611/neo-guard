import 'package:neo_guard/features/quiz/data/models/question.dart';

final List<Question> hardQuestions = [
  const Question(
    questionText: 'What is the name of the hypothetical energy that is thought to be responsible for the universe\'s accelerating expansion?',
    options: ['Dark Matter', 'Dark Energy', 'Quintessence', 'Phantom Energy'],
    correctAnswerIndex: 1,
    explanation: 'Dark energy is the theoretical form of energy that is postulated to act in opposition to gravity and to be responsible for the universe expanding at an accelerating rate.',
  ),
  const Question(
    questionText: 'The Roche limit is the distance within which a celestial body, held together only by its own gravity, will disintegrate due to a second celestial body\'s tidal forces exceeding the first body\'s gravitational self-attraction. Which of Saturn\'s rings is located within this limit?',
    options: ['A Ring', 'F Ring', 'G Ring', 'E Ring'],
    correctAnswerIndex: 1,
    explanation: 'Saturn\'s faint F Ring is located just outside the Roche limit, and its intricate, braided structure is heavily influenced by the gravitational pull of nearby shepherd moons.',
  ),
  const Question(
    questionText: 'What is the process by which a star, after exhausting the nuclear fuel in its core, sheds its outer layers to form a planetary nebula?',
    options: ['Stellar Wind', 'Supernova', 'Accretion', 'Core Collapse'],
    correctAnswerIndex: 0,
    explanation: 'A strong stellar wind is the process by which a red giant star expels its outer layers, which are then ionized by the hot core, creating a glowing planetary nebula.',
  ),
  const Question(
    questionText: 'Which of the following is NOT a proposed method for asteroid impact avoidance?',
    options: ['Kinetic Impactor', 'Gravity Tractor', 'Laser Ablation', 'Magnetic Deflection'],
    correctAnswerIndex: 3,
    explanation: 'Magnetic Deflection is not a feasible method because asteroids are typically not magnetic. The other options are all real, proposed methods for planetary defense.',
  ),
  const Question(
    questionText: 'What is the name of the paradox that questions why we haven\'t found evidence of extraterrestrial life, despite the high probability of it existing?',
    options: ['The Fermi Paradox', 'The Olbers Paradox', 'The Simulation Hypothesis', 'The Drake Equation'],
    correctAnswerIndex: 0,
    explanation: 'The Fermi Paradox is the apparent contradiction between the lack of evidence for and the high probability estimates of the existence of extraterrestrial civilizations.',
  ),
];
