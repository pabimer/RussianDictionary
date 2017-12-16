﻿// элементарный глагол

// ------------------------------

//wordentry_set БытьГлагол = { глагол:быть{} }

patterns Гл0 export { ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }

pattern Гл0
{
 глагол:*{} : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
}

// Грипп «закрыл» школы города
//       ^^^^^^^^
pattern Гл0
{
 q1=ОткрывающаяКавычка
 v=Гл0 : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
 q2=ЗакрывающаяКавычка
} : links
{
 v.{
    <PREPEND_QUOTE>q1
    <APPEND_QUOTE>q2
   }
}

// -------------------------------------------------------

patterns ГлСПрефиксом export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }

pattern ГлСПрефиксом
{
 Гл0 : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
}

// Грипп «закрыл» школы города
//       ^^^^^^^^
pattern ГлСПрефиксом
{
 q1=ОткрывающаяКавычка
 v=Гл0 : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
 q2=ЗакрывающаяКавычка
} : links
{
 v.{
    <PREPEND_QUOTE>q1
    <APPEND_QUOTE>q2
   }
}



// Появление родительной валентности у непереходного глагола
// в прошедшем времени в ср.роде ед.ч.:
// Однако этого не произошло.
//        ^^^^^^^^^^^^^^^^^^
pattern ГлСПрефиксом export { ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД (МОДАЛЬНЫЙ) ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
{
 n=частица:не{}
 v=Гл0{ ~ПАДЕЖ:ВИН ВРЕМЯ:ПРОШЕДШЕЕ РОД:СР ЧИСЛО:ЕД } : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:РОД node:root_node }
}
: links { v.<NEGATION_PARTICLE>n }
: ngrams { -5 }

// Но этого и не требовалось.
//          ^^^^^^^^^^^^^^^^
pattern ГлСПрефиксом export { ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД (МОДАЛЬНЫЙ) ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
{
 p0=частица:и{}
 n=частица:не{}
 v=Гл0{ ~ПАДЕЖ:ВИН ВРЕМЯ:ПРОШЕДШЕЕ РОД:СР ЧИСЛО:ЕД } : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:РОД node:root_node }
}
: links
{
 v.{
    <PREFIX_PARTICLE>p0
    <NEGATION_PARTICLE>n
   }
}
: ngrams { -5 }


// не произойдет ли аварии?
// ^^^^^^^^^^^^^^^^
pattern ГлСПрефиксом export { ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД (МОДАЛЬНЫЙ) ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
{
 n=частица:не{}
 v=Гл0{ ~ПАДЕЖ:ВИН ~ВРЕМЯ:ПРОШЕДШЕЕ ЛИЦО:3 ЧИСЛО:ЕД } : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:РОД node:root_node }
}
: links { v.<NEGATION_PARTICLE>n }
: ngrams { -5 }




// Для глагола БЫТЬ частица НЕ порождает родительную валентность:
//
// - То есть объединения не будет?
//                       ^^^^^^^^
wordentry_set БытьДляРодВал = глагол:{ быть }
pattern ГлСПрефиксом export { ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД (МОДАЛЬНЫЙ) ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
{
 n=частица:не{}
 v=Гл0{ БытьДляРодВал } : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:РОД node:root_node }
}
: links { v.<NEGATION_PARTICLE>n }
: ngrams { 1 }




// В качестве таких компонент как раз и выступают электромагнитные потенциалы
//                                    ^^^^^^^^^^^
pattern ГлСПрефиксом
{
 p=частица:и{}
 v=Гл0 : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
} : links { v.<PREFIX_PARTICLE>p }
  : ngrams { -1 }


// А это чего-нибудь да стоит.
//                   ^^^^^^^^
pattern ГлСПрефиксом
{
 p=частица:да{}
 v=Гл0 : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
} : links { v.<PREFIX_PARTICLE>p }
  : ngrams { -1 }


// Частица ВСЁ придает оттенок продолжающегося действия:
// А он всё пел гимн.
//      ^^^^^^^
pattern ГлСПрефиксом
{
 p=частица:все{}
 v=Гл0{ вид:несоверш ПАДЕЖ:ВИН } : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
} : links { v.<PREFIX_PARTICLE>p }
  : ngrams { -4 }


// Частица ВСЁ с непереходными глаголами почти не вызывает коллизий:
//
// Студенты  все  хихикали,  все перекликались у  Вари под окнами.
//           ^^^             ^^^
// Новости всё не появлялись
//         ^^^^^^^^^^^^^^^^^
// Ты все врешь, врешь!
//    ^^^^^^^^^
pattern ГлСПрефиксом
{
 p=частица:все{}
 v=Гл0{ вид:несоверш ~ПАДЕЖ:ВИН } : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
}
: links { v.<PREFIX_PARTICLE>p }
: ngrams { -1 }


// Но она все не шла.
//        ^^^^^^^^^^
pattern ГлСПрефиксом
{
 p=частица:все{}
 n=частица:не{}
 v=Гл0{ вид:несоверш ~ПАДЕЖ:ВИН } : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
}
: links { v.{ <PREFIX_PARTICLE>p <NEGATION_PARTICLE>n } }
: ngrams { -1 }



// куда бы ни уехал человек
//         ^^^^^^^^
pattern ГлСПрефиксом
{
 p=частица:ни{}
 v=Гл0 : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
} : links { v.<NEGATION_PARTICLE>p }

// Частица ВОТ перед глаголом - можно вообще игнорировать:
// я вот написал о них целую книгу
pattern ГлСПрефиксом
{
 p=частица:вот{}
 v=Гл0 : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
} : links { v.<PREFIX_PARTICLE>p }



// для непереходных глаголов частица НЕ ведет себя как обычная частица:
//
// не смеялся
pattern ГлСПрефиксом
{
 n=частица:не{}
 v=Гл0{ ~ПАДЕЖ:ВИН } : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
} : links { v.<NEGATION_PARTICLE>n }

// отрицание меняет падежную валентность глагола,
// вместо винительного падежа глагол присоединяет родительный:
//
// никакой утечки не вижу
// не видел ни одной кошки
pattern ГлСПрефиксом
{
 n=частица:не{}
 v=Гл0{ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:ВИН } : export { ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД ПЕРЕХОДНОСТЬ ПАДЕЖ МОДАЛЬНЫЙ @add(ПАДЕЖ:РОД) node:root_node }
} : links { v.<NEGATION_PARTICLE>n }


// За что русские предприниматели "не любят" Русскую общину Латвии.
//                                ^^^^^^^^^^
pattern ГлСПрефиксом
{
 q1=ОткрывающаяКавычка
 v=ГлСПрефиксом : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
 q2=ЗакрывающаяКавычка
} : links
{
 v.{
    <PREPEND_QUOTE>q1
    <APPEND_QUOTE>q2
   }
}


// Я даже и не открывал книги
//        ^^^^^^^^^^^^^
pattern ГлСПрефиксом
{
 x=частица:и{}
 n=частица:не{}
 v=Гл0 : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
} : links
{
 v.{
    <NEGATION_PARTICLE>n
    <PREFIX_PARTICLE>x
   }
}

// Студент так и не смог ответить на вопросы
//         ^^^^^^^^^^^^^
pattern ГлСПрефиксом
{
 x1=наречие:так{}
 x2=союз:и{}
 n=частица:не{}
 v=Гл0 : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
} : links
{
 v.{
    <NEGATION_PARTICLE>n.<ATTRIBUTE>x1.<NEXT_COLLOCATION_ITEM>x2
   }
}

patterns ПрефиксДляГлагола export { node:root_node }
pattern ПрефиксДляГлагола
{
 p=частица:ну{} : export { node:root_node }
}

// Вася, ну-ка стань сюда.
//       ^^^^^
pattern ПрефиксДляГлагола
{
 p=частица:ну{} : export { node:root_node }
 t='-'
 p2=частица:ка{}
} : links { p.<POSTFIX_PARTICLE>t.<NEXT_COLLOCATION_ITEM>p2 }

pattern ГлСПрефиксом
{
 p=ПрефиксДляГлагола
 v=Гл0 : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
} : links
{
 v.<PREFIX_PARTICLE>p
}


// Частица "во":
//
// - Во дает!
pattern ГлСПрефиксом
{
 n=частица:во{}
 v=Гл0{ ВРЕМЯ:НАСТОЯЩЕЕ НАКЛОНЕНИЕ:ИЗЪЯВ } : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
}
: links { v.<PREFIX_PARTICLE>n }
: ngrams { -4 }



// Любые частицы прикрепляем к глаголу с большим штрафом
pattern ГлСПрефиксом
{
 n=частица:*{}
 v=Гл0 : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
}
: links { v.<PREFIX_PARTICLE>n }
: ngrams { -10 }


// -----------------------------------------------------------------

wordentry_set ГлагПостфикс0 = { частица:же{}, частица:ли{}, частица:бы{}, частица:б{} }

patterns ГлагПостфикс export { node:root_node  }

pattern ГлагПостфикс
{
 ГлагПостфикс0 : export { node:root_node  }
}

pattern ГлагПостфикс
{
 частица:*{} : export { node:root_node  }
} : ngrams { -10 }


// Пойдём-ка мы домой
//       ^^^
pattern ГлагПостфикс
{
 t='-' : export { node:root_node  }
 p=частица:ка{}
} : links { t.<NEXT_COLLOCATION_ITEM>p }


// Отчего умер-то?
//        ^^^^^^^
pattern ГлагПостфикс
{
 t='-' : export { node:root_node  }
 p=частица:то{}
}
: links { t.<NEXT_COLLOCATION_ITEM>p }

// Глянь-кось, шуба ожила!
//      ^^^^^
pattern ГлагПостфикс
{
 t='-' : export { node:root_node  }
 p=частица:кось{}
}
: links { t.<NEXT_COLLOCATION_ITEM>p }


// Они добавили-таки ложку дегтя в бочку меда.
//             ^^^^^
pattern ГлагПостфикс
{
 t='-' : export { node:root_node  }
 p=частица:таки{}
}
: links { t.<NEXT_COLLOCATION_ITEM>p }


// --------------------------------------------------------

patterns ГлСПостфиксом export { ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }

pattern ГлСПостфиксом
{
 ГлСПрефиксом : export { ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
}

pattern ГлСПостфиксом
{
 q1=ОткрывающаяКавычка
 v=ГлСПостфиксом : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
 q2=ЗакрывающаяКавычка
} : links
{
 v.{
    <PREPEND_QUOTE>q1
    <APPEND_QUOTE>q2
   }
}


pattern ГлСПостфиксом
{
 v=ГлСПрефиксом : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
 p=ГлагПостфикс
}
: links { v.<POSTFIX_PARTICLE>p }
: ngrams { 1 }





// Постфикс ВСЁ придает оттенок продолжающегося действия, хотя употребляется очень редко:
// Беги все садами.
//      ^^^
pattern ГлСПрефиксом
{
 v=Гл0{ вид:несоверш ПАДЕЖ:ВИН } : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
 p=частица:всё{}
} : links { v.<POSTFIX_PARTICLE>p }
  : ngrams { -5 }


pattern ГлСПрефиксом
{
 v=Гл0{ вид:несоверш ~ПАДЕЖ:ВИН } : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
 p=частица:всё{}
}
: links { v.<POSTFIX_PARTICLE>p }
: ngrams { -1 }


// -----------------------------------------------------------------


patterns Гл1 export { ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }

pattern Гл1
{
 v=ГлСПостфиксом : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
}

// ты ищи-ищи!
//    ^^^^^^^
pattern Гл1
{
 v=глагол:*{} : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
 t='-'
 v2=глагол:*{ =v:НАКЛОНЕНИЕ =v:ВИД =v:ВРЕМЯ =v:ЛИЦО =v:ЧИСЛО }
} : links { v.<RIGHT_LOGIC_ITEM>t.<NEXT_COLLOCATION_ITEM>v2 }


// Дефолтное правило - разрешаем любым наречиям модифицировать глагол.
// Таким образом, будут связываться даже такие конструкции:
// Я гораздо устал.
//   ~~~~~~~ ~~~~~
pattern Гл1
{
 mod=наречие:*{}
 v=ГлСПостфиксом : export{ ТИП_ГЛАГОЛА ВИД ВРЕМЯ ЛИЦО ЧИСЛО НАКЛОНЕНИЕ РОД МОДАЛЬНЫЙ ПЕРЕХОДНОСТЬ ПАДЕЖ node:root_node }
}
: links { v.<ATTRIBUTE>mod }
: ngrams { -10 }

// -----------------------------------------------------------------------------



patterns СвязочныйГлагол export { node:root_node НАКЛОНЕНИЕ ЛИЦО ЧИСЛО РОД ВРЕМЯ }

pattern СвязочныйГлагол
{
 Гл1{ ТИП_ГЛАГОЛА:СВЯЗОЧН } : export { node:root_node НАКЛОНЕНИЕ ЛИЦО ЧИСЛО РОД ВРЕМЯ }
}
