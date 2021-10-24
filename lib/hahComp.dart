import "dart:math";

extension NumSplitter on String {
  List<String> splitForLen(int len) {
    List<String> result = [];
    int start = 0;
    int end = len;
    while (end <= this.length) {
      result.add(this.substring(start, end));
      start = end;
      end += len;
    }
    return result;
  }
}
extension CharCtl on String {
  String sort(int Function(String, String) compare) {
    List<String> chars = this.split("");
    chars.sort(compare);
    return chars.join("");
  }
  String shuffle([Random? random]) {
    List<String> chars = this.split("");
    chars.shuffle(random);
    return chars.join("");
  }
}
/**
A character set, including a part of vowel, semi-vowel, and consonant.

[Set] vowels, semiVowels, and consonants are partition of allChars.

[Set] allChars contains all characters in the alphabet(writing system).
 */
class VowConsSet{
  /**
  All characters in the alphabet(writing system).
   */
  late final Set<String> _allChars;
  /**
  Vowels chars set of the alphabet(writing system).
   */
  late final Set<String> _vowels;
  /**
  Semi-vowels chars set of the alphabet(writing system).
   */
  late final Set<String> _semiVowels;
  /**
  Consonants chars set of the alphabet(writing system).
   */
  late final Set<String> _consonants;
  /**
  Constructor.
   */
  VowConsSet(Set<String> vowels, Set<String> consonants, Set<String> semiVowels){
    Set<String> vsDiff = vowels.intersection(semiVowels);
    Set<String> csDiff = consonants.intersection(semiVowels);
    Set<String> vcDiff = vowels.intersection(consonants);
    if(vsDiff.isNotEmpty || csDiff.isNotEmpty || vcDiff.isNotEmpty){
      throw Exception("Vowels, semiVowels, consonants must be disjoint");
    }
    this._vowels = vowels;
    this._semiVowels = semiVowels;
    this._consonants = consonants;
    this._allChars = vowels.union(semiVowels).union(consonants);
  }
  /**
  All characters in the alphabet(writing system).
   */
  Set<String> get allChars => this._allChars;
  /**
  Vowels chars set of the alphabet(writing system).
   */
  Set<String> get vowels => this._vowels;
  /**
  Semi-vowels chars set of the alphabet(writing system).
   */
  Set<String> get semiVowels => this._semiVowels;
  /**
  Consonants chars set of the alphabet(writing system).
   */
  Set<String> get consonants => this._consonants;
}
/**
 A class that represents an arrangement of characters, with a athematic data structure, the pair of bijective finite sets.

 [String] for characters, and [int] for the arrangement position of the characters.
  */
class CharArrange extends BijectiveFiniteSets<String, int>{
  /**
  A character set, including a part of vowel, semi-vowel, and consonant.
   */
  List<String> get chars => this.domain;
  /**
  An arrangement position of the characters.
   */
  List<int> get places => this.codomain;
  /**
  Returns the arrangement position of the character.
   */
  int plaseByChar(String char)=> this.surjection[char];
  /**
  Returns the character at the arrangement position.
   */
  String charByPlace(int place)=> this.injection[place];
  /**
  Returns the compare method of characters, with the arrangement position.
   */
  int Function(String, String) get compare =>(String a, String b)=> this.plaseByChar(a).compareTo(this.plaseByChar(b));
}
/**
A Hah Compress class for each hah compress algorithm.
*/
class HahComp{
  /**
  Default compare method for pre-sort.
   */
  static int Function(String, String) _defaultCompare = (a, b) => a.compareTo(b);
  /**
  Applies original hah compress algorithm to the given string.
   */
  static String hahComp(String str, [int len = 4]){
    List<String> temp = str.splitForLen(len);
    List<String> result = temp.map((String s) => s.substring(0, 1) + s.substring(s.length - 1, 1)).toList();
    return result.join("");
  }
  /**
  Applies randomized hah compress algorithm to the given string.
   */
  static String randomHahComp(String str, [Random? random,int len = 4]){
    String temp = str.shuffle(random);
    return HahComp.hahComp(temp, len);
  }
  /**
  Applies sorted hah compress algorithm to the given string.
   */
  static String sortHahComp(String str, CharArrange charArranges,{int Function(String,String)? preCompare, int len = 4}){
    String temp = str.sort(preCompare ?? HahComp.defaultCompare);
    String temp2 = HahComp.hahComp(temp, len);
    return temp2.sort(charArranges.compare);
  }
  /**
  Applies hah compress algorithm using by char kind of vowels, semi-vowels, and consonants to the given string.
   */
  static String byCharHahComp(String str, VowConsSet vcs, CharArrange charArranges, [int len = 4]){
    List<String> temp = str.split("");
    String vowelsOnStr = temp.where((String s) => vcs.vowels.contains(s)).toList().join("");
    String semiVowelsOnStr = temp.where((String s) => vcs.semiVowels.contains(s)).toList().join("");
    String consonantsOnStr = temp.where((String s) => vcs.consonants.contains(s)).toList().join("");
    String hahedVowels = HahComp.hahComp(vowelsOnStr, len);
    String hahedSemiVowels = HahComp.hahComp(semiVowelsOnStr, len);
    String hahedConsonants = HahComp.hahComp(consonantsOnStr, len);
    String result = hahedVowels + hahedSemiVowels + hahedConsonants;
    result.sort(charArranges.compare);
    return result;
  }
  /**
  Default compare method for pre-sort.
   */
  static int Function(String,String) get defaultCompare => HahComp._defaultCompare;
}
/**
Methods that appies hah compress to a string.
 */
extension HahCompApply on String{
  /**
  Applies original hah compress algorithm to the given string.
   */
  String hahComp([int len = 4]){
    return HahComp.hahComp(this, len);
  }
  /**
  Applies randomized hah compress algorithm to the given string.
   */
  String randomHahComp([Random? random,int len = 4]){
    return HahComp.randomHahComp(this, random, len);
  }
  /**
  Applies sorted hah compress algorithm to the given string.
   */
  String sortHahComp(int Function(String,String) compare,[int Function(String,String)? preCompare, int len = 4]){
    return HahComp.sortHahComp(this, compare, preCompare, len);
  }
  /**
  Applies hah compress algorithm using by char kind of vowels, semi-vowels, and consonants to the given string.
   */
  String byCharHahComp(VowConsSet vcs, [int len = 4]){
    return HahComp.byCharHahComp(this, vcs, len);
  }
}