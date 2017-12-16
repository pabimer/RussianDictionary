﻿// Правила разбора сложной союзной группы прилагательного

#define _запятая ','

// -------------------------------------------------------------

patterns ГруппаПрил_Голова export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }

word_set НеГоловаГруппыПрил = { "это" }

// это твое настоящее имя?
// ~~~ ^^^^
pattern ГруппаПрил_Голова
{
 ГруппаПрил1{ ~НеГоловаГруппыПрил } : export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }
}

pattern ГруппаПрил_Голова
{
 ГруппаПрил1{ НеГоловаГруппыПрил } : export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }
} : ngrams { -2 }



pattern ГруппаПрил_Голова
{
 ПричОборот2:export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}

// И она будет самой дорогостоящей.
//             ^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил_Голова
{
 СуперлативСПредлДоп:export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}



// Было и плохое, и хорошее.
//      ^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил_Голова
{
 conj1=ЛогичСоюз2
 a1=ГруппаПрил_Голова : export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }
 comma=','
 conj2=ЛогичСоюз2
 a2=ГруппаПрил2{ =a1:ЧИСЛО =a1:ПАДЕЖ =a1:РОД =a1:ОДУШ } 
}
: links
{
 a1.{
     <PREFIX_CONJUNCTION>conj1
     <RIGHT_LOGIC_ITEM>comma.<NEXT_COLLOCATION_ITEM>conj2.<NEXT_ADJECTIVE>a2
    }
}


// И то и другое я с удовольствием выполнил.
// ^^^^^^^^^^^^^
pattern ГруппаПрил_Голова
{
 conj1=ЛогичСоюз2
 a1=ГруппаПрил_Голова : export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }
 conj2=ЛогичСоюз2
 a2=ГруппаПрил2{ =a1:ЧИСЛО =a1:ПАДЕЖ =a1:РОД =a1:ОДУШ } 
}
: links
{
 a1.{
     <PREFIX_CONJUNCTION>conj1
     <RIGHT_LOGIC_ITEM>conj2.<NEXT_ADJECTIVE>a2
    }
}


// -------------------------------------------------------------

patterns ПритяжЧастица export { node:root_node }

pattern ПритяжЧастица
{
 a=ПРИТЯЖ_ЧАСТИЦА:*{} : export { node:root_node }
}

// ее-то голова уже видна
pattern ПритяжЧастица
{
 a=ПРИТЯЖ_ЧАСТИЦА:*{} : export { node:root_node }
 t='-'
 p=частица:то{}
} : links { a.<POSTFIX_PARTICLE>t.<NEXT_COLLOCATION_ITEM>p }

pattern ПритяжЧастица
{
 a=ПРИТЯЖ_ЧАСТИЦА:*{} : export { node:root_node }
 t='-'
 p=частица:ка{}
} : links { a.<POSTFIX_PARTICLE>t.<NEXT_COLLOCATION_ITEM>p }


pattern ПритяжЧастица
{
 a=ПРИТЯЖ_ЧАСТИЦА:*{} : export { node:root_node }
 p=частица:же{}
} : links { a.<POSTFIX_PARTICLE>p }

pattern ПритяжЧастица
{
 a=ПРИТЯЖ_ЧАСТИЦА:*{} : export { node:root_node }
 p=частица:бы{}
} : links { a.<POSTFIX_PARTICLE>p }

pattern ПритяжЧастица
{
 a=ПРИТЯЖ_ЧАСТИЦА:*{} : export { node:root_node }
 p=частица:ли{}
} : links { a.<POSTFIX_PARTICLE>p }



pattern ГруппаПрил_Голова export { (РОД) (ПАДЕЖ) (ЧИСЛО) (ОДУШ) node:root_node }
{
 ПритяжЧастица:export { node:root_node }
}


// -------------------------------------------------------------

patterns ГруппаПрил_Хвост export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }

pattern ГруппаПрил_Хвост
{
 ГруппаПрил1 : export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }
}

pattern ГруппаПрил_Хвост
{
 СуперлативСПредлДоп:export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}

pattern ГруппаПрил_Хвост
{
 ПричОборот2:export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}

// В некоторых случаях предложный паттерн с семантикой атрибута может 
// участвовать в составе составной группы прилагательного:
// Руки у него были тонкие, изящные, с длинными пальцами.
//                                   ^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил_Хвост export { (РОД) ПАДЕЖ (ЧИСЛО) (ОДУШ) node:root_node }
{
 p=предлог:с{}:export { ПАДЕЖ:ИМ node:root_node }
 n=ГруппаСущ4{ падеж:твор }
} : links { p.<OBJECT>n }
  : ngrams { -2 }

// Добрая, без тени сарказма улыбка
//         ^^^^^^^^^^^^^^^^^
pattern ГруппаПрил_Хвост export { (РОД) ПАДЕЖ (ЧИСЛО) (ОДУШ) node:root_node }
{
 p=предлог:без{}:export { ПАДЕЖ:ИМ node:root_node }
 n=ГруппаСущ4{ падеж:род }
} : links { p.<OBJECT>n }
  : ngrams { -2 }

// Руки были сильные, загорелые, в шрамах и ссадинах
//                               ^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил_Хвост export { (РОД) ПАДЕЖ (ЧИСЛО) (ОДУШ) node:root_node }
{
 p=предлог:в{}:export { ПАДЕЖ:ИМ node:root_node }
 n=ГруппаСущ4{ падеж:предл }
} : links { p.<OBJECT>n }
  : ngrams { -2 }



// Любая ее идея провалится
// ^^^^^^^^
pattern ГруппаПрил_Хвост export { (РОД) (ПАДЕЖ) (ЧИСЛО) (ОДУШ) node:root_node }
{
 ПритяжЧастица : export { node:root_node }
}


// -------------------------------------------------------------


patterns ГруппаПрил_Восх { bottomup } export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }

pattern ГруппаПрил_Восх
{
 ГруппаПрил_Голова:export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ } 
}

tree_scorers ВалентностьПрил2 // проверка сочетаемости 2 прилагательных


// -------------------------------------------------------------

patterns СоединПрилМнож1 export { node:root_node }

pattern СоединПрилМнож1
{
 ',' : export { node:root_node }
}


pattern СоединПрилМнож1
{
 ЛогичСоюз : export { node:root_node }
}


// большой, тупой, но мой нож
//               ^^^^
pattern СоединПрилМнож1
{
 comma=',' : export { node:root_node }
 conj=ПротивитСоюз
} : links { comma.<NEXT_COLLOCATION_ITEM>conj }


collocation_set СоединДляПрилаг=
{
 { хотя и },
 { хотя в то же время и },
 { хотя в то же время },
 { хотя в это же время и },
 { хотя в это же время },
 { хотя с другой стороны },
 { хотя с другой стороны и },
 { пусть и },
 { но в то же время },
 { но в это же время },
 { но в то же самое время },
 { но в это же самое время },
 { но вдобавок к этому },
 { но вдобавок к этому еще и },
 { но вдобавок к этому и },
 { да к тому же },
 { да к тому же еще и },
 { но и },
 { но еще и },
 { да плюс к этому },
 { но плюс к этому },
 { а плюс к этому },
 { и плюс к этому },
 { и еще },
 { а еще },
 { да еще },
 { ну еще },
 { ну и еще },
 { ну а еще },
 { ну да еще },
 { а еще и },
 { ну еще и },
 { ну и еще и },
 { и плюс к этому еще и },
 { а плюс к этому еще и },
 { да плюс к этому еще и },
 { ну плюс к этому еще и },
 { ну и плюс к этому еще и },
 { ну а плюс к этому еще и },
 { ну да плюс к этому еще и },
 { и плюс к этому еще },
 { а плюс к этому еще },
 { да плюс к этому еще },
 { но плюс к этому еще },
 { ну и плюс к этому еще },
 { ну а плюс к этому еще },
 { ну да плюс к этому еще },
 { но к тому же },
 { и к тому же },
 { а к тому же },
 { ну и к тому же },
 { ну а к тому же },
 { ну да к тому же },
 { хотя может быть },
 { хотя иногда может быть },
 { хотя может быть и },
 { хотя иногда может быть и }
}

// пюре было вкусное, а еще и полезное
//                  ^^^^^^^^^
pattern СоединПрилМнож1
{
 comma=',' : export { node:root_node }
 conj=СоединДляПрилаг
} : links { comma.<NEXT_COLLOCATION_ITEM>conj }


// ---------------------------------------------------------

pattern ГруппаПрил_Восх
{
 a1=ГруппаПрил_Восх : export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }
 junc=СоединПрилМнож1
 a2=ГруппаПрил_Хвост{ =a1:ЧИСЛО =a1:ПАДЕЖ =a1:РОД =a1:ОДУШ } 
}
: links { a1.<NEXT_ADJECTIVE>junc.<NEXT_COLLOCATION_ITEM>a2 }
: ngrams { ВалентностьПрил2(a1) }



// большой, тупой, но всё же мой нож
//               ^^^^^^^^^^^
pattern ГруппаПрил_Восх
{
 a1=ГруппаПрил_Восх : export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }
 comma=','
 conj=ПротивитСоюз
 adv=ГруппаНареч1
 a2=ГруппаПрил_Хвост{ =a1:ЧИСЛО =a1:ПАДЕЖ =a1:РОД =a1:ОДУШ } 
}
: links
{
 a1.<NEXT_ADJECTIVE>comma.
    <NEXT_COLLOCATION_ITEM>conj.
    <NEXT_COLLOCATION_ITEM>a2.
    <ATTRIBUTE>adv
}
: ngrams { ВалентностьПрил2(a1) }


// удобная, да еще и дешевая машинка
//        ^^^^^^^^^^
pattern ГруппаПрил_Восх
{
 a1=ГруппаПрил_Восх : export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }
 comma=','
 conj=ЛогичСоюз
 adv=ГруппаНареч1
 a2=ГруппаПрил_Хвост{ =a1:ЧИСЛО =a1:ПАДЕЖ =a1:РОД =a1:ОДУШ } 
}
: links
{
 a1.<NEXT_ADJECTIVE>comma.
    <NEXT_COLLOCATION_ITEM>conj.
    <NEXT_COLLOCATION_ITEM>a2.
    <ATTRIBUTE>adv
}
: ngrams { ВалентностьПрил2(a1) }



wordentry_set ЗапретПрилГолова=прилагательное:{ самый }

wordentry_set ПритяжЧастицы=ПРИТЯЖ_ЧАСТИЦА:{ ее, его, их }

// Прилагательные могут соединяться без дополнительной пунктуации. Добавим небольшой
// штраф.
// Роботизированный российский грузовой космический корабль пристыковался к станции
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил_Восх
{
 a1=ГруппаПрил_Восх{ ~ЗапретПрилГолова } : export { node:root_node }
 a2=ГруппаПрил_Хвост{ ~ПритяжЧастицы =a1:ЧИСЛО =a1:ПАДЕЖ =a1:РОД =a1:ОДУШ } : export { РОД ПАДЕЖ ЧИСЛО ОДУШ }
}
: links { a1.<NEXT_ADJECTIVE>a2 }
: ngrams
{
 -1 // небольшой штраф, чтобы стимулировать связывание каждого прилагательного с атрибутируемым объектом
 ВалентностьПрил2(a1)
}


// Мы предлагаем дословный его перевод.
//               ^^^^^^^^^^^^^
pattern ГруппаПрил_Восх
{
 a1=ГруппаПрил_Восх{ ~ЗапретПрилГолова } : export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 a2=ГруппаПрил_Хвост{ ПритяжЧастицы }
}
: links { a1.<NEXT_ADJECTIVE>a2 }
: ngrams
{
 ВалентностьПрил2(a1)
}




// ----------------------------------------------------------


// С частицами перечисления:
// по тематическому, жанровому и т.п. признаку
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// Вещество может быть красным, зеленым и т.д.
//                                      ^^^^^^
// по тематическому, жанровому, идейно-художественному и т.п. признаку
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил_Восх
{
 a1=ГруппаПрил_Восх : export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }
 etc=ЗамыкательПеречисления
} : links { a1.<NEXT_COLLOCATION_ITEM>etc }

// ----------------------------------------------------------


collocation_set НеТолькоНоИ =
{
 { но вдобавок к этому },
 { но вдобавок к этому и },
 { но вдобавок к этому еще и },
 { но },
 { но к тому же },
 { но к тому же еще и },
 { но еще и },
 { но вдобавок и },
 { но плюс к этому },
 { но плюс к этому и },
 { но плюс к этому еще и }
}

wordentry_set ГоловаНеТолькоНо=наречие:{ только, просто }


// пюре было не только вкусное, но к тому же полезное
//           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаПрил_Восх
{
 ne=частица:не{}
 mod1=ГруппаНареч1{ГоловаНеТолькоНо}
 a1=ГруппаПрил_Восх : export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }
 comma=_запятая
 mod2=НеТолькоНоИ
 a2=ГруппаПрил_Хвост{ =a1:ЧИСЛО =a1:ПАДЕЖ =a1:РОД =a1:ОДУШ } 
} : links
{
 a1.{
      <ATTRIBUTE>mod1.<NEGATION_PARTICLE>ne
      <RIGHT_LOGIC_ITEM>comma.<NEXT_COLLOCATION_ITEM>a2.<ATTRIBUTE>mod2
     }
}



// -------------------------------------------------------------

pattern ГруппаПрил2
{
 ГруппаПрил_Восх:export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ } 
}


// она показалась мне не такой и высокой
//                    ^^^^^^^^^^^^^^^^^^
// он оказался не таким уж и быстрым
//             ^^^^^^^^^^^^^^^^^^^^^
wordentry_set ПрилКакМодиф={ прилагательное:такой{} }
pattern ГруппаПрил2
{
 a1=ГруппаПрил_Восх{ ПрилКакМодиф } : export { node:root_node РОД ПАДЕЖ ЧИСЛО ОДУШ }
 p=частица:и{}
 a2=ГруппаПрил2{ =a1:ЧИСЛО =a1:ПАДЕЖ =a1:РОД =a1:ОДУШ } 
}
: links { a1.{ <POSTFIX_PARTICLE>p <NEXT_ADJECTIVE>a2 } }
: ngrams { 2 }



// В армию будут брать «новых русских»
//                     ^^^^^^^^^^^^^^^
pattern ГруппаПрил2
{
 q1=ОткрывающаяКавычка
 a=ГруппаПрил2:export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 q2=ЗакрывающаяКавычка
} : links
{
 a.{
    <PREPEND_QUOTE>q1
    <APPEND_QUOTE>q2
   }
}



// -------------------------------------------------------------
