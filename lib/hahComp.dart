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
class VowConsSet{
  late final Set<String> _allChars;
  late final Set<String> _vowels;
  late final Set<String> _semiVowels;
  late final Set<String> _consonants;
  late final CharArrangeSet _charArranges;
  VowConsSet(Set<String> vowels, Set<String> consonants, Set<String> semiVowels, CharArrangeSet charArranges){
    Set<String> vsDiff = vowels.difference(semiVowels);
    Set<String> csDiff = consonants.difference(semiVowels);
    Set<String> vcDiff = vowels.difference(consonants);
    if(vsDiff.isNotEmpty || csDiff.isNotEmpty || vcDiff.isNotEmpty){
      throw Exception("Vowels, semiVowels, consonants must be disjoint");
    }
    this._vowels = vowels;
    this._semiVowels = semiVowels;
    this._consonants = consonants;
    this._allChars = vowels.union(consonants).union(semiVowels);
    this._charArranges = charArranges;
  }
  Set<String> get vowels => this._vowels;
  Set<String> get semiVowels => this._semiVowels;
  Set<String> get consonants => this._consonants;
  CharArrangeSet get charArranges => this._charArranges;

}
class CharArrange extends BijectiveFiniteSets<String, int>{
  List<String> get chars => this.domain;
  List<int> get places => this.codomain;
  int plaseByChar(String char)=> this.surjection[char];
  String charByPlace(int place)=> this.injection[place];
  Function(String, String) get compare =>(String a, String b)=> this.plaseByChar(a).compareTo(this.plaseByChar(b));
}
class HahComp{
  static int Function(String, String) defaultCompare = (a, b) => a.compareTo(b);
  static hahComp(String str, [int len = 4]){
    List<String> temp = str.splitForLen(len);
    List<String> result = temp.map((String s) => s.substring(0, 1) + s.substring(s.length - 1, 1)).toList();
    return result.join("");
  }
  static randomHahComp(String str, [Random? random,int len = 4]){
    String temp = str.shuffle(random);
    return HahComp.hahComp(temp, len);
  }
  static sortHahComp(String str, int Function(String,String) compare,[,int Function(String,String)? preCompare, int len = 4]){
    String temp = str.sort(preCompare ?? HahComp.defaultCompare);
    String temp2 = HahComp.hahComp(temp, len);
    return temp2.sort(compare);
  }
  static byCharHahComp(String str, VowConsSet vcs, [int len = 4]){
    List<String> temp = str.split("");
    String vowelsOnStr = temp.where((String s) => vcs.vowels.contains(s)).toList().join("");
    String semiVowelsOnStr = temp.where((String s) => vcs.semiVowels.contains(s)).toList().join("");
    String consonantsOnStr = temp.where((String s) => vcs.consonants.contains(s)).toList().join("");
    String hahedVowels = HahComp.hahComp(vowelsOnStr, len);
    String hahedSemiVowels = HahComp.hahComp(semiVowelsOnStr, len);
    String hahedConsonants = HahComp.hahComp(consonantsOnStr, len);
    String result = hahedVowels + hahedSemiVowels + hahedConsonants;
    result.sort(vcs.charArranges.compare);
    return result;
  }
}
extension HahCompApply on String{
  String hahComp([int len = 4]){
    return HahComp.hahComp(this, len);
  }
  String randomHahComp([Random? random,int len = 4]){
    return HahComp.randomHahComp(this, random, len);
  }
  String sortHahComp(int Function(String,String) compare,[int Function(String,String)? preCompare, int len = 4]){
    return HahComp.sortHahComp(this, compare, preCompare, len);
  }
  String byCharHahComp(VowConsSet vcs, [int len = 4]){
    return HahComp.byCharHahComp(this, vcs, len);
  }
}