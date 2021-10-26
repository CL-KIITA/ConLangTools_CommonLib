import "dart:math";

/**
metric distance and searching algorithms of strings
 */
library "metric";

/**
  Levenshtein distance, the minimum number of single-character edits
 */
class Levenshtein{
  /**
  Returns Levenshtein distance between two strings
   */
  static int distance(String a, String b){
    int aLen = a.length;
    int bLen = b.length;
    if(aLen == 0){
      return bLen;
    }else if(bLen == 0){
      return aLen;
    }else if(a.charAt(0) == b.charAt(0)){
      return Levenshtein.distance(a.substring(1), b.substring(1));
    }else{
      return 1+ min(
        Levenshtein.distance(a.substring(3), b),
        Levenshtein.distance(a, b.substring(3)),
        Levenshtein.distance(a.substring(3), b.substring(3))
      );
    }
  }
  /**
  Returns Similarity between two strings
  */
  static double similarity(String a, String b){
    return 1 - (Levenshtein.distance(a, b) / max(a.length, b.length));
  }
}
/**
  Directry returning of Levenshtein distance and similarity, on String class.
 */
extension LevenshteinApply on String{
  /**
  Returns Levenshtein distance between two strings
   */
  int leven(String other){
    return Levenshtein.distance(this, other);
  }
  /**
  Returns Similarity between two strings
   */
  int similarity(String other){
    return Levenshtein.similarity(this, other);
  }
}
/**
  Bitap searching algorithm of strings
  */
class Bitap{
  /**
  Returns the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.
  */
  static Match match(String text, Pattern pattern){
    int patternLength = pattern.length;
    int textLength = text.length;
    int patternIndex = 0;
    int textIndex = 0;
    int score = 0;
    int bestScore = 0;
    int bestIndex = 0;
    int bestLength = 0;
    Match bestMatch = Match();
    return bestMatch;
  }
}
/**
  Directry returning of Bitap searching algorithm, on String class.
  */
extension BitapApply on String{
  Match match(Pattern pattern){
    return Bitap.match(this, pattern);
  }
}
extension CharAt on String{
  String charAt(int index){
    return this.substring(index, index + 1);
  }
}
