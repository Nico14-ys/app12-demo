// Class of translation questions.
class Tran {
  /// Respective essay the translation is from.
  final String topic;

  /// The sentence which the word is in.
  final String sentence;

  /// The original word.
  final List<int> original;

  /// The correct translation.
  final List<String> translations;

  Tran(
      {required this.topic,
      required this.sentence,
      required this.original,
      required this.translations});
}
