﻿// ПАТТЕРНЫ С ЧИСЛИТЕЛЬНЫМИ, КОТОРЫЕ ЗАПИСАНЫ СЛОВАМИ

patterns ГруппаЧисл0 export { node:root_node ПАДЕЖ ЧИСЛО РОД }

// --------------------------------------------------------

wordentry_set ЕдиницыБольше1 =
{
 числительное:два{},
 числительное:полтора{},
 числительное:три{},
 числительное:четыре{},
 числительное:пять{},
 числительное:шесть{},
 числительное:семь{},
 числительное:восемь{},
 числительное:девять{}
}

wordentry_set ЕдиницыБольше9 =
{
 ЧИСЛИТЕЛЬНОЕ:ДЕСЯТЬ{}, ЧИСЛИТЕЛЬНОЕ:ОДИННАДЦАТЬ{},
 ЧИСЛИТЕЛЬНОЕ:ДВЕНАДЦАТЬ{}, ЧИСЛИТЕЛЬНОЕ:ТРИНАДЦАТЬ{},
 ЧИСЛИТЕЛЬНОЕ:ЧЕТЫРНАДЦАТЬ{}, ЧИСЛИТЕЛЬНОЕ:ПЯТНАДЦАТЬ{},
 ЧИСЛИТЕЛЬНОЕ:ШЕСТНАДЦАТЬ{}, ЧИСЛИТЕЛЬНОЕ:СЕМНАДЦАТЬ{},
 ЧИСЛИТЕЛЬНОЕ:ВОСЕМНАДЦАТЬ{},
 ЧИСЛИТЕЛЬНОЕ:ДЕВЯТНАДЦАТЬ{}, ЧИСЛИТЕЛЬНОЕ:ДВАДЦАТЬ{}
}


wordentry_set Десятки = {
                         числительное:двадцать{},
                         числительное:тридцать{},
                         числительное:сорок{},
                         числительное:пятьдесят{},
                         числительное:шестьдесят{},
                         числительное:семьдесят{},
                         числительное:восемьдесят{},
                         числительное:девяносто{}
                        }

wordentry_set Сотни = {
                       числительное:сто{},
                       числительное:двести{},
                       числительное:триста{},
                       числительное:четыреста{},
                       числительное:пятьсот{},
                       числительное:шестьсот{},
                       числительное:семьсот{},
                       числительное:восемьсот{},
                       числительное:девятьсот{}
                      }


// ---------------------------


// --------------------

patterns Числ1 export { ПАДЕЖ РОД node:root_node }

// одно пальто висело на вешалке
// ^^^^
pattern Числ1
{
 ЧИСЛИТЕЛЬНОЕ:ОДИН{} : export { ПАДЕЖ РОД node:root_node }
}

wordentry_set ПравыйМодифОдин={ наречие:еще{}, наречие:лишь{},
наречие:только{}, наречие:всего{}

}


// оставался один только выход
//           ^^^^^^^^^^^
pattern Числ1
{
 n=ЧИСЛИТЕЛЬНОЕ:ОДИН{} : export { ПАДЕЖ РОД node:root_node }
 mod=ПравыйМодифОдин
} : links { n.<ATTRIBUTE>mod }



// двадцать одно пальто висело на вешалке
// ^^^^^^^^^^^^^
pattern Числ1
{
 N10=Десятки : export { ПАДЕЖ node:root_node }
 N=ЧИСЛИТЕЛЬНОЕ:ОДИН{ =N10:ПАДЕЖ }:export { РОД }
}
: links { n10.<CONUMBER>n }
: ngrams { 1 }


// Триста один спартанец встал в строй
// ^^^^^^^^^^^
pattern Числ1
{
 N100=Сотни : export { ПАДЕЖ node:root_node }
 N=ЧИСЛИТЕЛЬНОЕ:ОДИН{ =N100:ПАДЕЖ }:export { РОД }
} : links { n100.<CONUMBER>n }
: ngrams { 1 }


// двести двадцать одно пальто с воротником висело на стене
// ^^^^^^^^^^^^^^^^^^^^
pattern Числ1
{
 N100=Сотни : export { ПАДЕЖ node:root_node }
 N10=Десятки{=N100:ПАДЕЖ}
 N=ЧИСЛИТЕЛЬНОЕ:ОДИН{ =N10:ПАДЕЖ }:export { РОД }
}
: links { n100.<CONUMBER>n10.<CONUMBER>n }
: ngrams { 2 }


// о 121-м приеме
//   ^^^^^^
pattern Числ1
{
 числительное:???{} : export { node:root_node ПАДЕЖ РОД }
} : ngrams { -2 }




// Давайте разберем одно последнее упражнение
//                  ^^^^
pattern ГруппаЧисл0
{
 Числ1 : export { node:root_node ПАДЕЖ ЧИСЛО:ЕД РОД }
}

// ---------------------------------------------------------

patterns Числ9 export { ПАДЕЖ РОД node:root_node }

// Я видел шесть очень ярких вспышек
//         ^^^^^
pattern Числ9
{
 ЕдиницыБольше1 : export { node:root_node ПАДЕЖ РОД }
}

// Еще десять населенных пунктов получили газ.
//     ^^^^^^
pattern Числ9
{
 ЕдиницыБольше9 : export { node:root_node ПАДЕЖ РОД }
}


// Мы насчитали двадцать ударов
//              ^^^^^^^^
pattern Числ9
{
 Десятки : export { node:root_node ПАДЕЖ РОД }
}


// Он отказался от двухсот баллов
//                 ^^^^^^^
pattern Числ9
{
 Сотни : export { node:root_node ПАДЕЖ РОД }
}


// он прополз метров двадцать пять
//                   ^^^^^^^^^^^^^
pattern Числ9
{
 n10=Десятки : export { node:root_node ПАДЕЖ }
 n1=ЕдиницыБольше1{ =n10:ПАДЕЖ } : export { РОД }
} : links { n10.<CONUMBER>n1 }
  : ngrams { 1 }




// я прошёл метров сто пятьдесят
//                 ^^^^^^^^^^^^^
pattern Числ9
{
 n100=Сотни : export { node:root_node ПАДЕЖ }
 n10=Десятки{ =n100:ПАДЕЖ } : export { РОД }
} : links { n100.<CONUMBER>n10 }
  : ngrams { 1 }


// Еще сто десять населенных пунктов получили газ.
//     ^^^^^^^^^^
pattern Числ9
{
 n100=Сотни : export { node:root_node ПАДЕЖ }
 n1=ЕдиницыБольше9{ =n100:ПАДЕЖ } : export { РОД }
} : links { n100.<CONUMBER>n1 }
  : ngrams { 1 }


// Они выкупили сто сорок четыре гектара
//              ^^^^^^^^^^^^^^^^
pattern Числ9
{
 n100=Сотни : export { node:root_node ПАДЕЖ }
 n10=Десятки{ =n100:ПАДЕЖ }
 n1=ЕдиницыБольше1{ =n10:ПАДЕЖ } : export { РОД }
} : links { n100.<CONUMBER>n10.<CONUMBER>n1 }
  : ngrams { 1 }


// Он пролетел триста четыре метра
//             ^^^^^^^^^^^^^
pattern Числ9
{
 n100=Сотни : export { node:root_node ПАДЕЖ }
 n1=ЕдиницыБольше1{ =n100:ПАДЕЖ } : export { РОД }
} : links { n100.<CONUMBER>n1 }
  : ngrams { 1 }


// Собирательные числительные не сочетаются с десятками и сотнями:
//
// Еще двое милиционеров получили тяжелые травмы.
//     ^^^^
pattern Числ9
{
 числительное:*{ КАТЕГОРИЯ_ЧИСЛ:СОБИР } : export { node:root_node ПАДЕЖ РОД }
}


// о 120-ти приемах
//   ^^^^^^
pattern Числ9
{
 числительное:???{} : export { node:root_node ПАДЕЖ РОД }
}


// ------------------------------

pattern ГруппаЧисл0
{
 Числ9 : export { node:root_node ПАДЕЖ ЧИСЛО:МН РОД }
}

// Еще пять студентов вошло.
// ^^^^^^^^
pattern ГруппаЧисл0
{
 mod=МодификаторЧисла
 n=Числ9 : export { node:root_node ПАДЕЖ ЧИСЛО:МН РОД }
}
: links { n.<ATTRIBUTE>mod }
: ngrams { 1 }


// -----------------------------------------------

// ----------------------------------------------------
//       ПРЕФИКСЫ МИЛЛИАРДОВ, МИЛЛИОНОВ, ТЫСЯЧ
// ----------------------------------------------------

patterns МасштабныйПрефиксЧисла export { ПАДЕЖ node:root_node }

wordentry_set ПрефиксЧисла = существительное:{ триллион, миллиард, миллион, тысяча }

pattern МасштабныйПрефиксЧисла
{
 c=Числ1 : export { ПАДЕЖ }
 n=ПрефиксЧисла{ ЧИСЛО:ЕД } : export { node:root_node }
} : links { n.<ATTRIBUTE>c }


pattern МасштабныйПрефиксЧисла
{
 c=Числ9 : export { ПАДЕЖ }
 n=ПрефиксЧисла{ ЧИСЛО:МН } : export { node:root_node }
} : links { n.<ATTRIBUTE>c }




// Двести тридцать шесть тысяч восемнадцать рублей - большая сумма
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаЧисл0
{
 p=МасштабныйПрефиксЧисла
 n=ГруппаЧисл0 : export { ПАДЕЖ ЧИСЛО РОД node:root_node }
} : links { n.<CONOUN>p }



// ---------------------------------------------------------

// у нас есть отдельные правила для числительных,
// записанных цифрами, поэтому данное правило
// нужно только для союзных паттернов типа "три или 4"
pattern ГруппаЧисл0
{
 num_word:*{} : export { node:root_node ПАДЕЖ ЧИСЛО РОД }
} : ngrams { -2 }


/*
wordentry_set СущДляЧисл=существительное:{ десяток, сотня, тысяча, миллион, миллиард, триллион }
pattern ГруппаЧисл0
{
 СущДляЧисл : export { node:root_node ПАДЕЖ }
}
*/

// ---------------------------------------------------

// он станет обладателем сразу десяти мировых рекордов
//                       ^^^^^^^^^^^^
pattern ГруппаЧисл0
{
 mod=МодификаторЧисла
 n=ГруппаЧисл0 : export { node:root_node ПАДЕЖ ЧИСЛО РОД }
} : links { n.<ATTRIBUTE>mod }

// Ученые публикуют огромный каталог более чем 300000 близлежащих галактик
//                                   ^^^^^^^^^^^^^^^^
pattern ГруппаЧисл0
{
 mod=наречие:более{}
 mod2=союз:чем{}
 n=ГруппаЧисл0 : export { node:root_node ПАДЕЖ ЧИСЛО РОД }
} : links { n.<ATTRIBUTE>mod.<ATTRIBUTE>mod2 }


// ----------------------------------------

patterns ГруппаЧислВосх { bottomup  } export { node:root_node ПАДЕЖ ЧИСЛО РОД }

pattern ГруппаЧислВосх
{
 ГруппаЧисл0 : export { node:root_node ПАДЕЖ ЧИСЛО РОД }
}

// купи пять, шесть или семь яблок
//      ^^^^^^^^^^^^^^^^^^^^
pattern ГруппаЧислВосх
{
 n1=ГруппаЧислВосх : export { node:root_node ПАДЕЖ РОД }
 comma=','
 n2=ГруппаЧисл0{ [-1]=n1:ПАДЕЖ [-1]=n1:РОД } : export { ЧИСЛО }
} : links { n1.<RIGHT_LOGIC_ITEM>comma.<NEXT_COLLOCATION_ITEM>n2 }

// купи пять-шесть яблок
//      ^^^^^^^^^^
// Минут десять-пятнадцать можно еще отдохнуть.
// ^^^^^^^^^^^^^^^^^^^^^^^
// Они шли террасами в три-четыре яруса.
//                     ^^^^^^^^^^^^^^^^
pattern ГруппаЧислВосх
{
 n1=ГруппаЧислВосх : export { node:root_node ПАДЕЖ РОД }
 t='-'
 n2=ГруппаЧисл0{ [-1]=n1:ПАДЕЖ [-1]=n1:РОД } : export { ЧИСЛО }
} : links { n1.<RIGHT_LOGIC_ITEM>t.<NEXT_COLLOCATION_ITEM>n2 }


// купи пять или шесть яблок
//      ^^^^^^^^^^^^^^
// принести двадцать три или двадцать четыре стальные булавки
//          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаЧислВосх
{
 n1=ГруппаЧислВосх : export { node:root_node ПАДЕЖ РОД }
 conj=ЛогичСоюз
 n2=ГруппаЧисл0{ [-1]=n1:ПАДЕЖ [-1]=n1:РОД } : export { ЧИСЛО }
} : links { n1.<RIGHT_LOGIC_ITEM>conj.<NEXT_COLLOCATION_ITEM>n2 }


// Ты можешь взять шесть, семь или восемь пирожков
//                 ^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаЧислВосх
{
 n1=ГруппаЧислВосх : export { node:root_node ПАДЕЖ РОД }
 comma=','
 conj=ЛогичСоюз
 n2=ГруппаЧисл0{ [-1]=n1:ПАДЕЖ } : export { ЧИСЛО }
} : links
{
 n1.<RIGHT_LOGIC_ITEM>comma.
     <NEXT_COLLOCATION_ITEM>conj.
      <NEXT_COLLOCATION_ITEM>n2
}


// ----------------------------------------


pattern ГруппаЧисл
{
 ГруппаЧислВосх : export { node:root_node ПАДЕЖ ЧИСЛО РОД }
}


// Расстояние составит более двух километров.
//                     ^^^^^^^^^^
// В результате пострадало более 80 человек.
//                         ^^^^^^^^
// К 2010 году в Курганской области останется не более десяти рынков.
//                                            ^^^^^^^^^^^^^^^
pattern ГруппаЧисл
{
 mod=ГруппаСрНареч1{ БолееМенее }
 q=ГруппаЧислВосх : export { node:root_node ПАДЕЖ ЧИСЛО РОД }
}
: links { q.<ATTRIBUTE>mod }
: ngrams { 2 }


// Мост теперь охраняли не два, а четыре солдата.
//                      ^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаЧисл
{
 ne=частица:не{}
 q=ГруппаЧислВосх : export { node:root_node ПАДЕЖ РОД }
 comma=',' 
 conj=союз:а{}
 q2=ГруппаЧислВосх{ =q:ПАДЕЖ } : export { ЧИСЛО }
} : links
{
 q.{
    <NEGATION_PARTICLE>ne
    <RIGHT_LOGIC_ITEM>comma.
     <NEXT_COLLOCATION_ITEM>conj.
      <NEXT_COLLOCATION_ITEM>q2
   }
}


// Не решили ни одной
//           ^^^^^^^^
pattern ГруппаЧисл
{
 ni=частица:ни{}
 q=ГруппаЧислВосх : export { node:root_node ПАДЕЖ ЧИСЛО РОД }
} : links { q.<NEGATION_PARTICLE>ni }



// --------------------------------------------------


// ----- СЛОВОСОЧЕТАНИЯ ИЗ ЧИСЛИТЕЛЬНОГО И СУЩЕСТВИТЕЛЬНОГО ----



// Почти два млрд.
pattern ЧислСущ
{
 c=ГруппаЧисл : export { ПАДЕЖ ЧИСЛО РОД ОДУШ }
 obj=ЕДИНИЦА_ИЗМЕРЕНИЯ:*{} : export { node:root_node }
}
: links { obj.<ATTRIBUTE>c }



// ===================
// ИМЕНИТЕЛЬНЫЙ ПАДЕЖ
// ===================

// Двадцать шесть человек уместились в кабинете
// ^^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ИМ ЧИСЛО:МН } : export { ПАДЕЖ ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:РОД [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }

// Двадцать один человек поместится здесь
// ^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ИМ ЧИСЛО:ЕД } : export { ПАДЕЖ ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ИМ ЧИСЛО:ЕД }:export { РОД ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }

// Ему было лет семнадцать или восемнадцать...
//          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 obj=существительное:*{ ПАДЕЖ:РОД }:export { РОД node:root_node }
 c=ГруппаЧисл{ ПАДЕЖ:ИМ ЧИСЛО:МН } : export { ПАДЕЖ ЧИСЛО ОДУШ }
}
: links { obj.<ATTRIBUTE>c }
: ngrams { -2 }


// оставалось еще метра три
//            ^^^^^^^^^^^^^
pattern ЧислСущ
{
 mod=МодификаторЧисла
 obj=существительное:*{ ПАДЕЖ:РОД }:export { РОД node:root_node }
 c=ГруппаЧисл{ ПАДЕЖ:ИМ ЧИСЛО:МН } : export { ПАДЕЖ ЧИСЛО ОДУШ }
}
: links { obj.<ATTRIBUTE>c.<ATTRIBUTE>mod }
: ngrams { -2 }



// ===================
// ВИНИТЕЛЬНЫЙ ПАДЕЖ
// ===================

// Я принесла двадцать шесть спичек
//            ^^^^^^^^^^^^^^^^^^^^^
// Взять три кекса.
//       ^^^^^^^^^
// Два года назад он ушел
// ^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ВИН ЧИСЛО:МН } : export { ПАДЕЖ ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:РОД [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }


// мы взяли сто одну вещицу
//          ^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ВИН ЧИСЛО:ЕД } : export { ПАДЕЖ ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ВИН ЧИСЛО:ЕД [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }


// Я залью литров двадцать
//         ^^^^^^^^^^^^^^^
// следовало пройти километра четыре к востоку
//                  ^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 obj=существительное:*{ ПАДЕЖ:РОД }:export { РОД node:root_node }
 c=ГруппаЧисл{ ПАДЕЖ:ВИН ЧИСЛО:МН [-1]=obj:РОД } : export { ПАДЕЖ ЧИСЛО ОДУШ }
}
: links { obj.<ATTRIBUTE>c }
: ngrams { -2 }


// ===================
// РОДИТЕЛЬНЫЙ ПАДЕЖ
// ===================

// Откажись от ста тридцати рублей!
//             ^^^^^^^^^^^^^^^^^^^
// - Двух вождей не бывает.
//   ^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:РОД ЧИСЛО:МН } : export { ПАДЕЖ ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:РОД [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }

// Откажусь от двадцати одной булочки
//             ^^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:РОД ЧИСЛО:ЕД } : export { ПАДЕЖ ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:РОД ЧИСЛО:ЕД [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }

// ===================
// ТВОРИТЕЛЬНЫЙ ПАДЕЖ
// ===================

// Мы обошлись тридцатью тремя рублями
//             ^^^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ТВОР } : export { ПАДЕЖ ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ТВОР }:export { РОД ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }

// ===================
// ДАТЕЛЬНЫЙ ПАДЕЖ
// ===================

// Передай последним тридцати сотрудникам
//                   ^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ДАТ } : export { ПАДЕЖ ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ДАТ }:export { РОД ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }


// ===================
// ПРЕДЛОЖНЫЙ ПАДЕЖ
// ===================

// они остановились на ста пятидесяти метрах
//                     ^^^^^^^^^^^^^^^^^^^^^
// Компания сделала прорыв сразу на двух направлениях.
//                                  ^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ПРЕДЛ } : export { ПАДЕЖ ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ПРЕДЛ [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }


// ----- СЛОВОСОЧЕТАНИЯ ИЗ ЧИСЛИТЕЛЬНОГО, ПРИЛАГАТЕЛЬНОГО И СУЩЕСТВИТЕЛЬНОГО ----

// ========================
// ИМЕНИТЕЛЬНЫЙ ПАДЕЖ
// ========================

// пять очень спелых яблок лежат на полу
// ^^^^^^^^^^^^^^^^^^^^^^^
// По фактам произошедшего было возбуждено два уголовных дела.
//                                         ^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ИМ ЧИСЛО:МН } : export { ЧИСЛО ПАДЕЖ }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:РОД =c:ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:РОД [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }

// Две белые фигуры мгновенно появились рядом.
// ^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ИМ ЧИСЛО:МН } : export { ЧИСЛО ПАДЕЖ }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ИМ ЧИСЛО:МН }
 obj=СущДляЧисл{ ПАДЕЖ:ИМ ЧИСЛО:МН }:export { РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }

// пятьдесят одно квадратное окно ярко светилось
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ИМ ЧИСЛО:ЕД } : export { ЧИСЛО ПАДЕЖ }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ИМ ЧИСЛО:ЕД }
 obj=СущДляЧисл{ ПАДЕЖ:ИМ ЧИСЛО:ЕД [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }

// ======================
// ВИНИТЕЛЬНЫЙ ПАДЕЖ
// ======================

// я съел пять очень сочных яблок
//        ^^^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ВИН ЧИСЛО:МН } : export { ЧИСЛО ПАДЕЖ }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:РОД ЧИСЛО:МН }
 obj=СущДляЧисл{ ПАДЕЖ:РОД ЧИСЛО:МН [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }

// принести четыре стальные булавки
//          ^^^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ВИН ЧИСЛО:МН } : export { ЧИСЛО ПАДЕЖ }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ВИН ЧИСЛО:МН }
 obj=СущДляЧисл{ ПАДЕЖ:ВИН ЧИСЛО:МН [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }

// дети съели четыре сочных яблока
//            ^^^^^^^^^^^^^^^^^^^^
// Вскоре он увидел почти рядом два белых силуэта.
//                              ^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ВИН ЧИСЛО:МН } : export { ЧИСЛО ПАДЕЖ }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:РОД ЧИСЛО:МН }
 obj=СущДляЧисл{ ПАДЕЖ:РОД ЧИСЛО:ЕД [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }


// Я исправил двадцать одну очень неприятную ошибку
//            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ВИН ЧИСЛО:ЕД } : export { ЧИСЛО ПАДЕЖ }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ВИН ЧИСЛО:ЕД }
 obj=СущДляЧисл{ ПАДЕЖ:ВИН [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }


// Они остались без шести новых велосипедов
//                  ^^^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:РОД ЧИСЛО:МН } : export { ЧИСЛО ПАДЕЖ }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:РОД =c:ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:РОД [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }

// Они обошлись без двадцати одной новой повозки
//                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:РОД ЧИСЛО:ЕД } : export { ЧИСЛО ПАДЕЖ }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:РОД ЧИСЛО:ЕД }
 obj=СущДляЧисл{ ПАДЕЖ:РОД ЧИСЛО:ЕД [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }



// Они воспользовались тремя длинными шестами
//                     ^^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ТВОР } : export { ЧИСЛО ПАДЕЖ }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ТВОР =c:ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ТВОР [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }


// Волны ударили по восьми новым щитам
//                  ^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ДАТ } : export { ЧИСЛО ПАДЕЖ }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ДАТ =c:ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ДАТ [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }


// Мы поехали на семи новых машинах
//               ^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ГруппаЧисл{ ПАДЕЖ:ПРЕДЛ } : export { ЧИСЛО ПАДЕЖ }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ПРЕДЛ =c:ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ПРЕДЛ [-1]=c:РОД }:export { РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }

// ------------------------------------------------------

// Ежегодно сюда приезжает более миллиона россиян.
//                         ^^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 mod=ГруппаСрНареч1{ БолееМенее }
 n=СущСПредложДоп{ ПрефиксЧисла ПАДЕЖ:РОД ЧИСЛО:ЕД }:export { ЧИСЛО ПАДЕЖ:ИМ РОД ОДУШ node:root_node }
}
: links { n.<ATTRIBUTE>mod }
: ngrams { 1 }

// Он потратил менее тысячи долларов
//             ^^^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 mod=ГруппаСрНареч1{ БолееМенее }
 n=СущСПредложДоп{ ПрефиксЧисла ПАДЕЖ:РОД ЧИСЛО:ЕД }:export { ЧИСЛО ПАДЕЖ:ВИН РОД ОДУШ node:root_node }
}
: links { n.<ATTRIBUTE>mod }
: ngrams { 1 }


wordentry_set КоличСущ=существительное:{ десяток, сотня, тысяча, миллион, миллиард, триллион }

// они прошли молча по улице еще сотню шагов
//                           ^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 mod=МодификаторЧисла
 n=СущСПредложДоп{ КоличСущ ПАДЕЖ:РОД }:export { ЧИСЛО ПАДЕЖ РОД ОДУШ node:root_node }
}
: links { n.<ATTRIBUTE>mod }
: ngrams { 1 }


// Он тысячу раз прав
//    ^^^^^^^^^^
pattern Обст
{
 n1=ГруппаСущ1{ КоличСущ ПАДЕЖ:ВИН }:export { node:root_node }
 n2=существительное:раз{ ПАДЕЖ:РОД }
}
: links { n1.<RIGHT_GENITIVE_OBJECT>n2 }
: ngrams { 1 }


// -----------------------------------

// связаны ли эти два значения?
//            ^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 a=ГруппаПрил1
 n=ЧислСущ{ =a:ЧИСЛО =a:ПАДЕЖ =a:РОД } : export { ЧИСЛО ПАДЕЖ РОД ОДУШ node:root_node }
}
: links { n.<ATTRIBUTE>a }

