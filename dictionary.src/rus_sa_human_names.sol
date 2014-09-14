﻿// NAMED ENTRY RECOGNITION - обработка ФИО

// ---------------------------------------------------------------------------------
// Паттерны для распознавания ФИО
// Обратите внимание, что для этих паттернов указывается язык { language=Russian },
// чтобы раскрылись подстановочные цепочки типа \@А
// ---------------------------------------------------------------------------------


// ИМЕНА - обратите внимание, что именем может быть практически любая фонетически
// приемлемая цепочка букв, даже если она в других контекстах является грамматической
// формой существительного:
//
// Синяка удивленно хмыкнул
// ^^^^^^

patterns ФИО_Имя0 { language=Russian } export { node:root_node ПАДЕЖ РОД }

// Если имя известно системе как существительное, входящее в класс "имён":
//
// Отдай его Алисе Селезнёвой!
//           ^^^^^
pattern ФИО_Имя0
{
 существительное:*{ ОДУШ:ОДУШ <в_класс>СУЩЕСТВИТЕЛЬНОЕ:ИМЯ{} CHARCASING:FirstCapitalized }:export { node:root_node ПАДЕЖ РОД }
} : ngrams { 2 }


// -----------------------------------------------------------------------------
// Слово с большой буквы считаем фамилией или именем, с небольшим штрафом
// Эвристика - женские имена обычно заканчиваются на -а, мужские - на согласную.
// -----------------------------------------------------------------------------

// Янура ответила слабой улыбкой.
// ^^^^^
pattern ФИО_Имя0
{
 @regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+[аои]") : export { РОД:ЖЕН ПАДЕЖ:ИМ node:root_node }
} : ngrams { -5 }

// Калинов осторожно обнял жену.
// ^^^^^^^
pattern ФИО_Имя0
{
 @regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+[\\@бьй]") : export { РОД:МУЖ ПАДЕЖ:ИМ node:root_node }
} : ngrams { -5 }


// Но не всегда можно полагаться на последнюю букву при распознавании рода.
// Поэтому допускаем с дополнительным штрафом и другие варианты

// Синяка растерянно пожал плечами.
// ^^^^^^
pattern ФИО_Имя0
{
 @regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+[аои]") : export { РОД:МУЖ ПАДЕЖ:ИМ node:root_node }
} : ngrams { -6 }

// Джудиет рассматривала платье.
// ^^^^^^^
pattern ФИО_Имя0
{
 @regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+[\\@бьй]") : export { РОД:ЖЕН ПАДЕЖ:ИМ node:root_node }
} : ngrams { -6 }



// Произвольная цепочка букв, начинающаяся с большой буквы.
pattern ФИО_Имя0 export { node:root_node ПАДЕЖ (РОД) }
{
 @regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+"):export { node:root_node ПАДЕЖ }
} : ngrams { -6 }

// ---------------------------------------------------

patterns ФИО_Имя { language=Russian } export { node:root_node ПАДЕЖ РОД }

pattern ФИО_Имя
{
 ФИО_Имя0 : export { node:root_node ПАДЕЖ РОД }
}


// Валерий-то Николаевич опаздывает!
// ^^^^^^^^^^^^^^^^^^^^^
pattern ФИО_Имя
{
 n=ФИО_Имя0 : export { node:root_node ПАДЕЖ РОД }
 t='-'
 p=частица:то{}
} : links { n.<POSTFIX_PARTICLE>t.<NEXT_COLLOCATION_ITEM>p }


// Валерий же Николаевич снова опоздал.
// ^^^^^^^^^^
pattern ФИО_Имя
{
 n=ФИО_Имя0 : export { node:root_node ПАДЕЖ РОД }
 p=частица:же{}
} : links { n.<POSTFIX_PARTICLE>p }


// не Виктор ли Степанович приходил?
//    ^^^^^^^^^
pattern ФИО_Имя
{
 n=ФИО_Имя0 : export { node:root_node ПАДЕЖ РОД }
 p=частица:ли{}
} : links { n.<POSTFIX_PARTICLE>p }

// -------------------------------------------------------


// -----------------------------------------------

patterns ФИО_Фамилия { language=Russian } export { node:root_node ПАДЕЖ }

// Если слово занесено в лексикон как "существительное" и в тезаурус как "фамилия":
//
// Дмитрий Константинов принял присягу
//         ^^^^^^^^^^^^
pattern ФИО_Фамилия
{
 существительное:*{ ОДУШ:ОДУШ <в_класс>СУЩЕСТВИТЕЛЬНОЕ:ФАМИЛИЯ{} CHARCASING:FirstCapitalized }:export { node:root_node ПАДЕЖ }
} : ngrams { 1 }


// Встретил Алексея Ворона
//                  ^^^^^^
pattern ФИО_Фамилия
{
 существительное:*{ CharCasing:FirstCapitalized } : export { node:root_node ПАДЕЖ }
}

// Поговорите с Алексеем Ничипоренковым
//                       ^^^^^^^^^^^^^^
pattern ФИО_Фамилия
{
 прилагательное:*{ CharCasing:FirstCapitalized } : export { node:root_node ПАДЕЖ }
}


// Джордж Вашингтон был первым президентом США
//        ^^^^^^^^^
pattern ФИО_Фамилия export { node:root_node (ПАДЕЖ) }
{
 @regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+") : export { node:root_node }
} : ngrams { -2 }


// ---------------------------------------------------

patterns ФИО_Отчество { language=Russian } export { node:root_node ПАДЕЖ }

pattern ФИО_Отчество
{
 существительное:*{ CharCasing:FirstCapitalized ОДУШ:ОДУШ } : export { node:root_node ПАДЕЖ }
} : ngrams { 1 }

pattern ФИО_Отчество export { node:root_node (ПАДЕЖ) }
{
 @regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+") : export { node:root_node }
} : ngrams { -1 }



// ---------------------------------------------------

patterns ФИО { language=Russian } export { node:root_node ПАДЕЖ РОД }

// А.С.Пушкин
pattern ФИО
{
 @regex_strict("[\\@А\\@Б]\\.[\\@А\\@Б]\\.[\\@А\\@БЙ][\\@а\\@б\\@й]+"):export { node:root_node ПАДЕЖ РОД }
}

// В.Чуров опроверг комментарии о переименовании Волгограда
// ^^^^^^^
pattern ФИО
{
 @regex_strict("[\\@А\\@Б]\\.[\\@А\\@БЙ][\\@а\\@б\\@й]+"):export { node:root_node ПАДЕЖ РОД }
}

/*
// Михаил Сергеевич Горбачов был президентом СССР
// ^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ФИО
{
 n1=ФИО_Имя : export { node:root_node ПАДЕЖ }
 n2=@regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+")
 n3=@regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+")
} : links { n1.<RIGHT_NAME>n2.<RIGHT_NAME>n3 }
*/


/*
 // Джордж Вашингтон был первым президентом США
 // ^^^^^^^^^^^^^^^^
 pattern ФИО
 {
  n1=ФИО_Имя : export { node:root_node ПАДЕЖ }
  n2=@regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+")
 }
 : links { n1.<RIGHT_NAME>n2 }
 : ngrams { -1 }
*/

// Валерий Иванов сдал экзамены
// ^^^^^^^^^^^^^^
// Экзамены сданы Валерием Ивановым
//                ^^^^^^^^^^^^^^^^^
pattern ФИО
{
 n1=ФИО_Имя : export { node:root_node ПАДЕЖ РОД }
 n2=ФИО_Фамилия{ =n1:ПАДЕЖ }
}
: links { n1.<RIGHT_NAME>n2 }
: ngrams { 1 }


// Михаил Сергеевич Горбачов был президентом СССР
// ^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ФИО
{
 n1=ФИО_Имя : export { node:root_node ПАДЕЖ РОД }
 n2=ФИО_Фамилия{ =n1:ПАДЕЖ }
 n3=ФИО_Отчество{ =n1:ПАДЕЖ }
} : links { n1.<RIGHT_NAME>n2.<RIGHT_NAME>n3 }


// Михаил Сергеевич был президентом СССР
// ^^^^^^^^^^^^^^^^
pattern ФИО
{
 n1=ФИО_Имя : export { node:root_node ПАДЕЖ РОД }
 n3=ФИО_Отчество{ =n1:ПАДЕЖ }
} : links { n1.<RIGHT_NAME>n3 }


// ==============================================================

// К доске вызвали Наташу Петрову.
pattern СущСРодДоп export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
{
 ФИО : export { РОД ПАДЕЖ ЧИСЛО:ЕД ОДУШ:ОДУШ node:root_node }
}


pattern СущСРодДоп export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
{
 ФИО_Имя : export { РОД ПАДЕЖ ЧИСЛО:ЕД ОДУШ:ОДУШ node:root_node }
} : ngrams { -1 }


// ------------------------------------------------------------------


// Группа существительного с ФИО:
//
// Краткая биография А.С.Пушкина
//         ^^^^^^^^^^^^^^^^^^^^^
pattern СущСРодДоп
{
 n1=ГруппаСущ1:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 n2=ФИО{ ПАДЕЖ:РОД }
}
: links { n1.<RIGHT_GENITIVE_OBJECT>n2 }


// Аппозитивная конструкция:
//
// Экс-капитан "Спартака" Дмитрий Аленичев станет тренером
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern СущСРодДоп
{
 n1=ГруппаСущ1{ ОДУШ:ОДУШ ЧИСЛО:ЕД /*<в_класс>СУЩЕСТВИТЕЛЬНОЕ:ПРОФЕССИЯ{}*/ }:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 gen=РодОбъект
 n2=ФИО{ =n1:ПАДЕЖ }
}
: links { n1.{ <RIGHT_GENITIVE_OBJECT>gen <CONOUN>n2 } }
: ngrams { 1 }


// Австрийский парашютист Феликс Баумгартнер стал обладателем сразу трех мировых рекордов
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern СущСРодДоп
{
 n1=ГруппаСущ1{ ОДУШ:ОДУШ ЧИСЛО:ЕД /*<в_класс>СУЩЕСТВИТЕЛЬНОЕ:ПРОФЕССИЯ{}*/ }:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 n2=ФИО{ =n1:ПАДЕЖ }
}
: links { n1.<CONOUN>n2 }
: ngrams { 1 }



// В некоторых случаях имена могут некорректно распознаваться как неодушевленные:
// Сказка о мирном рыцаре Эддингтоне
//          ^^^^^^^^^^^^^^^^^^^^^^^^
pattern СущСРодДоп
{
 n1=ГруппаСущ1{ одуш:одуш число:ед }:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 n2=ФИО_Имя
}
: ngrams { -2 }
: links { n1.<RIGHT_NAME>n2 }

// ------------------------------------

// предложный паттерн с ФИО:
//
// у А.С.Пушкина
pattern ПредлогИСущ
{
 prepos=предлог:*{}:export{ node:prepos node:root_node }
 n=ФИО:export{ node:root_node->n2 }
} : links { prepos.<OBJECT>n }
: ngrams
{
 ВалентностьПредлога(prepos)
}



// -----------------------------------


// А.С.Пушкин - великий поэт
pattern ПредикатСвязка
{
 sbj=ФИО
 v=ДефисКакСвязка : export { node:root_node }
 r=ГруппаСущ4{ ПАДЕЖ:ИМ ЧИСЛО:ЕД }
}:links
{
 v.{
    <SUBJECT>sbj
    <RHEMA>r
   }
}

// -----------------------------------

/*
// ?????
pattern ПодлежащИнв export { (РОД) ЧИСЛО node:root_node }
{
 ФИО:export{ ЧИСЛО:ЕД node:root_node }
}
*/


// ------------------------------------

/*
// ???
// Ты понимаешь, Владимир Сергеевич?
//               ^^^^^^^^^^^^^^^^^^
pattern ПолучательОбращения
{ 
 ФИО{ падеж:им } : export { node:root_node }
}
*/


// ------------------------------------


// Словосочетание из одушевленного существительного и 1-2-3 слов с большой буквы:
//
// Тетя Марина накормила щенка
//      ^^^^^^
// Мы посоветовались с тетей Мариной
//                     ^^^^^^^^^^^^^
// Мы переночуем у дяди Толи
//                 ^^^^^^^^^
// Мы пошли к тете Наташе.
//            ^^^^^^^^^^^
pattern СущОбращение
{
 n=существительное:*{ одуш:одуш число:ед }:export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 n2=ФИО_Имя{ =n:ПАДЕЖ }
} : links { n.<RIGHT_NAME>n2 }
//  : ngrams { -1 }


// студент Иван Петров
// купец Иван Силантьевич Гнездилин
pattern СущОбращение
{
 n=существительное:*{ одуш:одуш число:ед }:export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 n2=ФИО{ =n:ПАДЕЖ }
} : links { n.<RIGHT_NAME>n2 }
//  : ngrams { -1 }


/*
pattern СущОбращение
{
 n=существительное:*{ одуш:одуш число:ед }:export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 n2=@regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+")
 n3=@regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+")
 n4=@regex_strict("[\\@А\\@БЙ][\\@а\\@б\\@й]+")
} : links { n.<RIGHT_NAME>n2.<RIGHT_NAME>n3.<RIGHT_NAME>n4 }
  : ngrams { -1 }
*/

// Императоры Феодор и Христиан
pattern СущОбращение
{
 n=существительное:*{ одуш:одуш число:мн }:export { РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 n2=ФИО_Имя
 conj=союз:и{}
 n3=ФИО_Имя
} : links
{
 n.<RIGHT_NAME>n2.
    <RIGHT_LOGIC_ITEM>conj.
     <RIGHT_NAME>n3
}
  : ngrams { -1 }
