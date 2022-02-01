/**
Contains two Word Indexes named as "Toki-Pona Word-Count Index" (abbr: TWI) and "Common Toki-Pona Word-Count Index" (abbr: CTWI)

The details of TWI and CTWI, such as definitions, formulae, and considerations, please see the article, [TP に関する思案 - Migdal 🗼](https://migdal.jp/cl_kiita/tp-に関する思案-第二ラウンド-4j4p).
*/
library word_index;

import "package:conlang_tools_common_lib/src/mathlib.dart";

/**
calculate word counts from TWI
*/
int calcWordFromTWI(double twi)=>(120*twi).round();


/**
calculate word counts from CTWI
*/
int calcWordFromCTWI(double ctwi)=>calcWordFromTWI(calcTWIFromCTWI(ctwi));
/**
calculate TWI from CTWI
*/
double calcTWIFromCTWI(double ctwi)=>pow((ctwi-120)/120,120).toDouble();
/**
calculate TWI from word counts
*/
double calcTWI(int word)=>word/120;
/**
calculate CTWI from TWI
*/
double calcCTWIFromTWI(double twi)=>flog(twi,120)*120+120;
/**
calculate CTWI from word counts
*/
double calcCTWI(int word)=>calcCTWIFromTWI(calcTWI(word));