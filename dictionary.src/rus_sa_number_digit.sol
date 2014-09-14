﻿wordentry_set МодификаторЧисла={ наречие:еще{}, наречие:даже{}, наречие:лишь{},
наречие:только{}, наречие:всего{}, наречие:всего лишь{},
наречие:эдак{}, наречие:почти{}, наречие:сразу{}, наречие:примерно{},
наречие:приблизительно{}, наречие:почти что{}
}


// ------------------------------------------------
//     ЧИСЛИТЕЛЬНЫЕ В ВИДЕ ЦИФРОВОЙ ЗАПИСИ
// ------------------------------------------------

patterns ЧислоЦифрами0 export { ЧИСЛО node:root_node }

// 36 спелых яблок лежат на столе
// ^^
pattern ЧислоЦифрами0
{
 @regex("[[:digit:]]*[023456789]"):export{ ЧИСЛО:МН node:root_node }
}

// она съела 111 яблок
//           ^^^
pattern ЧислоЦифрами0
{
 @regex("[[:digit:]]*11"):export{ ЧИСЛО:МН node:root_node }
}


// 21 сочное яблоко лежит в миске
// ^^
pattern ЧислоЦифрами0
{
 @regex("[[:digit:]]*1"):export{ ЧИСЛО:ЕД node:root_node }
}



pattern ЧислоЦифрами0
{
 @regex("[[:digit:]]+,[[:digit:]]+"):export{ ЧИСЛО:МН node:root_node }
}

// 2. миллиметра
pattern ЧислоЦифрами0
{
 @regex("[[:digit:]]+\\.[[:digit:]]*"):export{ ЧИСЛО:МН node:root_node }
} : ngrams { -1 }

// .36 дюймов
pattern ЧислоЦифрами0
{
 @regex("[[:digit:]]*\\.[[:digit:]]+"):export{ ЧИСЛО:МН node:root_node }
}

// «Зенит» проиграл «Атлетико» со счетом 1:3 в матче Лиги чемпионов
//                                       ^^^
pattern ЧислоЦифрами0
{
 n1=num_word:*{}:export{ ЧИСЛО:МН node:root_node }
 d=':'
 n2=num_word:*{}
} : links { n1.<NEXT_COLLOCATION_ITEM>d.<NEXT_COLLOCATION_ITEM>n2 }


// Материальный ущерб оценивается в 20 000 рублей.
//                                  ^^^^^^
pattern ЧислоЦифрами0
{
 n1=@regex("[1-9][0-9]{1,2}") : export { ЧИСЛО:МН node:root_node }
 n2=@regex("[0-9][0-9][0-9]")
}
: links { n1.<NEXT_COLLOCATION_ITEM>n2 }
: ngrams { 1 }


// Внешнеторговый оборот Кузбасса за год составил более $7 млрд.
//                                                      ^^
pattern ЧислоЦифрами0
{
 n1=@regex("[$₤€￥¥][0-9]+") : export { ЧИСЛО:МН node:root_node }
}


// Долг составил только $25 млрд
//               ^^^^^^^^^^
pattern ЧислоЦифрами0
{
 mod=МодификаторЧисла
 n=ЧислоЦифрами0 : export { ЧИСЛО:МН node:root_node }
}
: links { n.<ATTRIBUTE>mod }
: ngrams { 1 }

// Долги составили более $25 млрд
//                 ^^^^^^^^^
pattern ЧислоЦифрами0
{
 mod=ГруппаСрНареч1{ БолееМенее }
 n=ЧислоЦифрами0 : export { ЧИСЛО:МН node:root_node }
}
: links { n.<ATTRIBUTE>mod }
: ngrams { 1 }


pattern ЧислоЦифрами0
{
 n0=@regex("[[:digit:]]*[023456789]")
 n=ЧислоЦифрами0 : export { ЧИСЛО:МН node:root_node }
}
: links { n.<ATTRIBUTE>n0 }
: ngrams { -10 }



// ----------------------------


// 13 воробьев клюют просо
// ^^
pattern ЧислоЦифрами
{
 n1=ЧислоЦифрами0 : export { ЧИСЛО node:root_node }
}

// 13 или 14 ворон сидят на крыше
// ^^^^^^^^^
pattern ЧислоЦифрами
{
 n1=ЧислоЦифрами0 : export { node:root_node }
 conj=ЛогичСоюз
 n2=ЧислоЦифрами0 : export { ЧИСЛО }
} : links { n1.<RIGHT_LOGIC_ITEM>conj.<NEXT_COLLOCATION_ITEM>n2 }


// 26-27 воробьев клевали крошки
// ^^^^^
pattern ЧислоЦифрами
{
 n1=ЧислоЦифрами0 : export { node:root_node }
 t='-'
 n2=ЧислоЦифрами0 : export { ЧИСЛО }
} : links { n1.<RIGHT_LOGIC_ITEM>t.<NEXT_COLLOCATION_ITEM>n2 }

pattern ЧислоЦифрами
{
 n1=ЧислоЦифрами0 : export { node:root_node }
 n2=ЧислоЦифрами : export { ЧИСЛО }
}
: links { n1.<NEXT_COLLOCATION_ITEM>n2 }
: ngrams { -10 }


// ------------------------------

// числительное после существительного
// "калашников" советской или российской сборки калибра 7,62
//                                              ^^^^^^^^^^^^
pattern Сущ0 export{ РОД ПАДЕЖ ЧИСЛО ОДУШ (МОДАЛЬНЫЙ) (CharCasing) (ПАДЕЖВАЛ) node:root_node }
{
 n1=существительное:*{ одуш:неодуш } : export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 n2=ЧислоЦифрами
} : links { n1.<RIGHT_NAME>n2 }
: ngrams { -5 }




// ------------------------------


// ----- СЛОВОСОЧЕТАНИЯ ИЗ ЧИСЛИТЕЛЬНОГО И СУЩЕСТВИТЕЛЬНОГО ----

patterns ЧислСущ export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }

pattern СущСПредложДоп
{
 ЧислСущ : export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}

// -------------------------------


patterns СущДляЧисл export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }

// На снимке видно два светящихся облака газа
//                     ^^^^^^^^^^^^^^^^^^^^^^
pattern СущДляЧисл
{
 СущСПредложДоп : export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}


// Принеси шесть зеленых
//               ^^^^^^^
pattern СущДляЧисл
{
 ГруппаПрил2 : export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
} : ngrams { -3 }

// -------------------------------

// ====================
// ИМЕНИТЕЛЬНЫЙ ПАДЕЖ
// ====================


// 125 картофелин лежат на столе
// ^^^^^^^^^^^^^^
// На борту находятся 25 членов экипажа.
//                    ^^^^^^^^^^^^^^^^^
// 5 попыток дозвониться провалились
// ^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами{ ЧИСЛО:МН } : export { ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:РОД }:export { РОД ПАДЕЖ:ИМ ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }


// 21 яблоко лежит в миске
// ^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами{ ЧИСЛО:ЕД } : export { ЧИСЛО }
 obj=СущДляЧисл{ ЧИСЛО:ЕД ПАДЕЖ:ИМ }:export { РОД ПАДЕЖ:ИМ ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }


// ====================
// ВИНИТЕЛЬНЫЙ ПАДЕЖ
// ====================

// Взять 3 кекса.
//       ^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами{ ЧИСЛО:МН } : export { ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:РОД }:export { РОД ПАДЕЖ:ВИН ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }


// Возьмите 1 яблоко
//          ^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами{ ЧИСЛО:ЕД } : export { ЧИСЛО }
 obj=СущДляЧисл{ ЧИСЛО:ЕД ПАДЕЖ:ВИН }:export { РОД ПАДЕЖ:ВИН ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }

// ====================
// РОДИТЕЛЬНЫЙ ПАДЕЖ
// ====================


// Откажись от 120 рублей!
//             ^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами : export { ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:РОД }:export { РОД ПАДЕЖ:РОД ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }

// ====================
// ТВОРИТЕЛЬНЫЙ ПАДЕЖ
// ====================

// Мы обошлись 100 рублями
//             ^^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами : export { ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ТВОР }:export { РОД ПАДЕЖ:ТВОР ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }


// ====================
// ДАТЕЛЬНЫЙ ПАДЕЖ
// ====================

// Передай 5 сотрудникам
//         ^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами : export { ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ДАТ }:export { РОД ПАДЕЖ:ДАТ ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }

// ====================
// ПРЕДЛОЖНЫЙ ПАДЕЖ
// ====================

// они остановились на 8 штуках
//                     ^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами : export { ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ПРЕДЛ }:export { РОД ПАДЕЖ:ПРЕДЛ ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }


// ----- СЛОВОСОЧЕТАНИЯ ИЗ ЧИСЛИТЕЛЬНОГО, ПРИЛАГАТЕЛЬНОГО И СУЩЕСТВИТЕЛЬНОГО ----


// ------------------------------

// Группа прилагательных для модификации
// существительного в паттерне с числом.

patterns ГруппаПрилДляСущ export { ЧИСЛО ПАДЕЖ node:root_node }

// Мы взяли 4 престижнейших приза
//            ^^^^^^^^^^^^^
pattern ГруппаПрилДляСущ
{
 ГруппаПрил2 : export { ЧИСЛО ПАДЕЖ node:root_node }
}

// ------------------------------

// ====================
// ИМЕНИТЕЛЬНЫЙ ПАДЕЖ
// ====================

// 5 спелых яблок лежат на полу
// ^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами{ ЧИСЛО:МН } : export { ЧИСЛО }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:РОД ЧИСЛО:МН }
 obj=СущДляЧисл{ ПАДЕЖ:РОД }:export { РОД ПАДЕЖ:ИМ ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }

// 21 сочное яблоко лежит в миске
// ^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами{ ЧИСЛО:ЕД } : export { ЧИСЛО }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ИМ ЧИСЛО:ЕД }
 obj=СущДляЧисл{ ПАДЕЖ:ИМ ЧИСЛО:ЕД }:export { РОД ПАДЕЖ:ИМ ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }

// ====================
// ВИНИТЕЛЬНЫЙ ПАДЕЖ
// ====================

// я съел 5 сочных яблок
//        ^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами{ ЧИСЛО:МН } : export { ЧИСЛО }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:РОД ЧИСЛО:МН }
 obj=СущДляЧисл{ ПАДЕЖ:РОД ЧИСЛО:МН }:export { РОД ПАДЕЖ:ВИН ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }


// принеси 4 стальные булавки
//         ^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами{ ЧИСЛО:МН } : export { ЧИСЛО }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ВИН ЧИСЛО:МН }
 obj=СущДляЧисл{ ПАДЕЖ:ВИН ЧИСЛО:МН }:export { РОД ПАДЕЖ:ВИН ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }


// дети съели 4 сочных яблока
//            ^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами{ ЧИСЛО:МН } : export { ЧИСЛО }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:РОД ЧИСЛО:МН }
 obj=СущДляЧисл{ ПАДЕЖ:РОД ЧИСЛО:ЕД }:export { РОД ПАДЕЖ:ВИН ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }

// Я съем 1 зелёное яблоко
//        ^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами{ ЧИСЛО:ЕД } : export { ЧИСЛО }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ВИН ЧИСЛО:ЕД }
 obj=СущДляЧисл{ ПАДЕЖ:ВИН ЧИСЛО:ЕД }:export { РОД ПАДЕЖ:ВИН ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }


// ====================
// РОДИТЕЛЬНЫЙ ПАДЕЖ
// ====================

// Они остались без 6 новых велосипедов
//                  ^^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами : export { ЧИСЛО }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:РОД =c:ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:РОД }:export { РОД ПАДЕЖ:РОД ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }


// ====================
// ТВОРИТЕЛЬНЫЙ ПАДЕЖ
// ====================

// Они воспользовались 3 длинными шестами
//                     ^^^^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами : export { ЧИСЛО }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ТВОР =c:ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ТВОР }:export { РОД ПАДЕЖ:ТВОР ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }


// ====================
// ДАТЕЛЬНЫЙ ПАДЕЖ
// ====================

// Волны ударили по 8 новым щитам
//                  ^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами : export { ЧИСЛО }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ДАТ =c:ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ДАТ }:export { РОД ПАДЕЖ:ДАТ ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }


// ====================
// ПРЕДЛОЖНЫЙ ПАДЕЖ
// ====================

// Мы поехали на 7 новых машинах
//               ^^^^^^^^^^^^^^^
pattern ЧислСущ
{
 c=ЧислоЦифрами : export { ЧИСЛО }
 adj=ГруппаПрилДляСущ{ ПАДЕЖ:ПРЕДЛ =c:ЧИСЛО }
 obj=СущДляЧисл{ ПАДЕЖ:ПРЕДЛ }:export { РОД ПАДЕЖ:ПРЕДЛ ОДУШ node:root_node }
}
: links { obj.{ <ATTRIBUTE>c <ATTRIBUTE>adj } }



pattern ЧислСущ
{
 c=ЧислоЦифрами : export { ЧИСЛО }
 obj=СущДляЧисл : export { РОД ПАДЕЖ ОДУШ node:root_node }
}
: links { obj.<ATTRIBUTE>c }
: ngrams { -10 }


// ================================================================

word_set АббревиатураДенежн={"млн","млрд","тыс","трлн","млн.","млрд.","тыс.","трлн."}

patterns КоличДенегНескл export { node:root_node }

pattern КоличДенегНескл
{
 c=ЧислоЦифрами
 n=АббревиатураДенежн:export{ node:root_node }
}
: links { n.<ATTRIBUTE>c }
: ngrams { 1 }


pattern ГруппаСущ1 export { (РОД) ПАДЕЖ ЧИСЛО (ОДУШ) (МОДАЛЬНЫЙ) (CHARCASING) (ПАДЕЖВАЛ) node:root_node }
{
 КоличДенегНескл:export { ЧИСЛО:МН ПАДЕЖ:ИМ node:root_node }
}

// Общая стоимость проекта оценивается в $482 млн.
//                                            ^^^^
pattern ГруппаСущ1 export { (РОД) ПАДЕЖ ЧИСЛО (ОДУШ) (МОДАЛЬНЫЙ) (CHARCASING) (ПАДЕЖВАЛ) node:root_node }
{
 КоличДенегНескл:export { ЧИСЛО:МН ПАДЕЖ:ВИН node:root_node }
}

// Внешнеторговый оборот Кузбасса за год составил более $7 млрд.
//                                                         ^^^^^
pattern ГруппаСущ1 export { (РОД) ПАДЕЖ ЧИСЛО (ОДУШ) (МОДАЛЬНЫЙ) (CHARCASING) (ПАДЕЖВАЛ) node:root_node }
{
 КоличДенегНескл:export { ЧИСЛО:МН ПАДЕЖ:РОД node:root_node }
}

pattern ГруппаСущ1 export { (РОД) ПАДЕЖ ЧИСЛО (ОДУШ) (МОДАЛЬНЫЙ) (CHARCASING) (ПАДЕЖВАЛ) node:root_node }
{
 КоличДенегНескл:export { ЧИСЛО:МН ПАДЕЖ:ДАТ node:root_node }
}