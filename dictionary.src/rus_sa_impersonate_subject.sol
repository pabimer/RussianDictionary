﻿
patterns БезличПодлежащее export { ПАДЕЖ node:root_node }


// старой волчице хотелось есть
pattern БезличПодлежащее
{
 ГруппаСущ4:export { ПАДЕЖ node:root_node }
}

// нам хотелось есть
pattern БезличПодлежащее
{
 местоимение:я{}:export { ПАДЕЖ node:root_node }
}

// тебе самому случалось такое делать?
// ^^^^^^^^^^^
pattern БезличПодлежащее
{
 p=местоимение:я{}:export { ПАДЕЖ node:root_node }
 a=прилагательное:сам{}
} : links { p.<ATTRIBUTE>a }


// ЧАСТИЦА "ВОТ" СЛЕВА ОТ МЕСТОИМЕНИЯ:
// а вот тебе стоит уехать отсюда
pattern БезличПодлежащее
{
 p=частица:вот{}
 n=местоимение:я{}:export { ПАДЕЖ node:root_node }
} : links { n.<PREFIX_PARTICLE>p }



// поэтому нам бы хотелось узнать о ней как можно больше.
//         ^^^^^^
pattern БезличПодлежащее
{
 n=местоимение:я{}:export { ПАДЕЖ node:root_node }
 p=ЧастицаБы
} : links { n.<POSTFIX_PARTICLE>p }

// нам же хотелось отдохнуть
// ^^^^^^
pattern БезличПодлежащее
{
 n=местоимение:я{}:export { ПАДЕЖ node:root_node }
 p=частица:же{}
} : links { n.<POSTFIX_PARTICLE>p }


// кому хочется есть
pattern БезличПодлежащее
{
 местоим_сущ:кто{}:export { ПАДЕЖ node:root_node }
}


// очень мало кому удавалось преодолеть этот страх
// ^^^^^^^^^^^^^^^
pattern БезличПодлежащее
{
 a=ГруппаНареч1{ МногоМалоНаречие }
 n=местоим_сущ:кто{} : export { ПАДЕЖ node:root_node }
} : links { n.<ATTRIBUTE>a }
  : ngrams { 4 }



// никому не хочется есть
pattern БезличПодлежащее
{
 местоим_сущ:никто{}:export { ПАДЕЖ node:root_node }
}

// кому-то захотелось поиграть
pattern БезличПодлежащее
{
 местоим_сущ:кто-то{}:export { ПАДЕЖ node:root_node }
}

// кое-кому захотелось поиграть
pattern БезличПодлежащее
{
 местоим_сущ:кое-кто{}:export { ПАДЕЖ node:root_node }
}

// всем нужно спать
pattern БезличПодлежащее
{
 прилагательное:весь{ падеж:дат число:мн }:export { ПАДЕЖ node:root_node }
}


patterns БезличПодлежащее_Я export { ПАДЕЖ node:root_node }

pattern БезличПодлежащее_Я
{
 n=местоимение:я{ падеж:дат }:export { ПАДЕЖ node:root_node }
}

// нам бы всем пришлось улыбаться друг другу.
// ^^^^^^^^^^^
pattern БезличПодлежащее_Я
{
 n=местоимение:я{ падеж:дат }:export { ПАДЕЖ node:root_node }
 p=ЧастицаБы
} : links { n.<POSTFIX_PARTICLE>p }

pattern БезличПодлежащее_Я
{
 n=местоимение:я{ падеж:дат }:export { ПАДЕЖ node:root_node }
 p=частица:же{}
} : links { n.<POSTFIX_PARTICLE>p }


// им всем вдруг стало страшно
pattern БезличПодлежащее
{
 n=БезличПодлежащее_Я:export { ПАДЕЖ node:root_node }
 a=прилагательное:весь{ падеж:дат число:мн }
} : links { n.<ATTRIBUTE>a }



// всем им нужна дверь.
// ^^^^^^^
pattern БезличПодлежащее
{
 a=прилагательное:весь{ число:мн падеж:дат }
 n=местоимение:я{ число:мн падеж:дат } : export{ ПАДЕЖ node:root_node }
} : links { n.<ATTRIBUTE>a }
  : ngrams { 1 }


// нам обоим нужен отдых.
// ^^^^^^^^^
pattern БезличПодлежащее
{
 n=местоимение:я{ число:мн падеж:дат } : export{ ПАДЕЖ node:root_node }
 a=прилагательное:оба{ число:мн падеж:дат }
} : links { n.<ATTRIBUTE>a }
  : ngrams { 1 }


// каждому хочется сделать великое открытие.
// ^^^^^^^
pattern БезличПодлежащее
{
 a=прилагательное:*{ падеж:дат число:ед род:муж ~краткий степень:атриб } : export{ ПАДЕЖ node:root_node }
} : ngrams { -3 }


// собаку можно научить этому же
//                      ^^^^^^^^
pattern БезличПодлежащее
{
 a=прилагательное:*{ падеж:дат число:ед род:муж ~краткий степень:атриб } : export{ ПАДЕЖ node:root_node }
 p=частица:же{}
} : links { a.<POSTFIX_PARTICLE>p }
  : ngrams { -3 }

// --------------------------------------------------------

