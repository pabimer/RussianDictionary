﻿
// В русском языке глаголы в прошедшем времени не изменяются по лицам.
//                                                           ^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:по{}.существительное:лицо{ одуш:неодуш } }
  then 1
}


// Правительство работает без оглядки на какое-то второе лицо.
//                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:без{}.'оглядки'.предлог:на{}.*:*{ падеж:вин } }
  then 10
}



// Он робко заглянул мне в лицо.
//                       ^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.существительное:лицо{ одуш:неодуш } }
  then 1
}


// Расплываться на жаре
//              ^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.'жаре'{ род:муж } }
  then -2
}


// Он должен повторить свои показания в присутствии свидетелей
//                                    ^^^^^^^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.существительное:присутствие{ падеж:предл число:ед }.*:*{ падеж:род } }
  then 1
}


// Судно качает во все стороны.
//                 ^^^^^^^^^^^

tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.существительное:*{падеж:вин число:мн}.'все'{class:прилагательное} }
  then 1
}


// Чтобы предотвратить отщепление существительного и распознавание МИМО в качестве наречия:
// Автомобиль пронёсся мимо дома.
//                     ^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:мимо{}.существительное:*{ падеж:род } }
  then 1
}



// Чтобы предотвратить отщепление существительного и распознавание НАПРОТИВ в качестве наречия:
// Дерево стоит напротив дома.
//              ^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:напротив{}.существительное:*{ падеж:род } }
  then 1
}




// Чтобы не допустить отщепления ДОМА от ВО ДВОРЕ:
// кошки не видели ни одной мышки во дворе дома
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.'дворе'.'дома' }
  then 1
}


// Запрещаем связывание местоимения ЕЁ с предлогом НА:
// Мы с подозрением смотрим на её поступки.
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.'ее'{class:местоимение} }
  then -1
}


// Подавим распознавание слова ПАРОК в контексте
// в нашем парке заливаются соловьи
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.существительное:парок{} }
  then -1
}





// Латвия соболезнует Франции в связи с гибелью людей.
//                            ^^^^^^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в связи с{}.существительное:*{ падеж:твор одуш:неодуш } }
  then 1
}


// Шла Женя по шоссе и сосала сушку
//          ^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:по{}.'шоссе'{падеж:дат число:ед} }
  then 1
}




// я-то сплю на кровати
//           ^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.'кровати'{падеж:предл число:ед} }
  then 1
}




// Отдохните, друзья, в тени старого дуба!
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.'тени'{ ПАДЕЖ:МЕСТ число:ед } }
  then 1
}


// кошки думали о работе, о друзьях, о семье и о домашних животных
//                                             ^^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:о{}.'животных'{ ПАДЕЖ:ПРЕДЛ } }
  then 1
}



// Во власти наваждения
// ^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { 'во'.'власти'{падеж:предл} }
  then 1
}

// дракон смотрит вслед человеку.
//                ^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:вслед{}.существительное:*{ падеж:дат одуш:одуш } }
  then 2
}


// Женя пошел навстречу ей.
//            ^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:навстречу{}.*:*{ падеж:дат } }
  then 1
}


// проорать на всё село
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.местоим_сущ:все{падеж:вин} }
  then -1
}


// застегнуть на все пуговицы
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.'пуговицы'.'все' }
  then 2
}



// Майкл махнул вытянутой рукой поверх голов.
//                              ^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:поверх{}.существительное:голова{ падеж:род } }
  then 2
}


// ловушка занимала около двадцати ярдов.
//                  ^^^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:около{}.*:*{ падеж:род } }
  then 2
}


// Будем считать, что сочетание предлогов с вариантами ЛЕТО более часты, чем с ЛЁТ
// певица, поющая о лете
//                ^^^^^^
tree_scorer ВалентностьПредлога language=Russian generic
{
 if context { предлог:*{}.существительное:лето{} }
  then 2
}


// Устойчивый оборот ЗА СЧЕТ ....
// оборудовать за счет предприятия
//             ^^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:за{}.существительное:счет{ падеж:вин }.*:*{ падеж:род } }
  then 5
}


// Для названий дней недели в сочетании с предлогом В предпочтем предложный падеж:
// Мы надеемся, что в воскресенье будет хорошая погода.
//                  ^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.ДеньНедели{ падеж:предл } }
  then 2
}

// Будем считать, что в подавляющем большинстве случаев НА ПОЛУ интерпретируется как "ПОЛ(муж.р.)"
// она устроилась на полу. Для поднятия конкретного случая употребления ПОЛА(жен.р.) надо
// использовать tree scorer и ngram.
tree_scorer ВалентностьПредлога language=Russian
{
 if context { 'на'.'полу'{ род:муж } }
  then 1
}




// Понизим вероятность появления ГОРЯ в паттерне с НА:
// Возле леса на горе стоял старый деревянный дом.
//            ^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.существительное:гора{ падеж:предл } }
  then 1
}




// послал при помощи магии.
//        ^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:при{}.'помощи'.*:*{ падеж:род } }
  then 1
}




// она еще раз посмотрела вокруг себя.
//                        ^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:вокруг{}.*:*{ падеж:род ~БылиКакСущ } }
  then 1
}



// стрела прошла мимо цели.
//               ^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:мимо{}.*:*{ падеж:род } }
  then 1
}


// они ищут вдоль стены.
//          ^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:вдоль{}.существительное:*{ падеж:род } }
  then 1
}


// после начала битвы прошли считанные секунды.
// ^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:после{}.существительное:*{ падеж:род одуш:неодуш } }
  then 2
}



// к кому еще обратиться?
// ^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:к{}.'кому'{ class:местоим_сущ } }
  then 1
}


// Обычно в данном случае используется форма 'нее':
// мышцы играли под ее кожей.
//              ~~~~~~
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:под{}.'ее'{ class:местоимение } }
  then -10
}




// После ЗА должна употребляться форма НЕГО:
// за его спиной поднялись языки пламени.
// ^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:за{}.'его'{ class:местоимение падеж:вин } }
  then -100
}

// Под его глазами легли морщины.
// ~~~~~~~
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:под{}.'его'{ class:местоимение падеж:твор } }
  then -100
}



// если после ПОСРЕДИ идет род. падеж, то это скорее всего предлог:
// отца нашли посреди комнаты
//            ^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:посреди{}.*:*{ падеж:род } }
  then 5
}


// наперерез Сашке бросился Витька
// ^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{ if context { предлог:наперерез{}.*:*{ падеж:дат } } then 2 }



// путь занял около недели
//            ^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:около{}.*:*{ падеж:род } }
  then 5
}



// тебя использовали во время войны?
//                   ^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.существительное:время{ падеж:вин число:ед }.*:*{ падеж:род } }
  then 5
}


// При виде игрока издаёт характерный звук, напоминающий икоту.
// ^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:при{}.существительное:вид{}.*:*{ падеж:род } }
  then 3
}


// к кому ты шел?
// ^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{ if context { предлог:к{}.'кому'{ class:местоимение } } then 2 }


// о ком ты говоришь?
// ^^^^^
tree_scorer ВалентностьПредлога language=Russian
{ if context { предлог:о{}.'ком'{ class:местоимение } } then 2 }




// со стороны солнечного излучения
// ^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{ if context { 'со'.'стороны'{ число:ед } } then 2 }

// красивый вид на море
//              ^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{ if context { 'на'.'море'{ род:ср } } then 2 }



// лежать на спине
//        ^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{ if context { 'на'.'спине'{ род:жен } } then 2 }




// он ловит страусов с помощью лассо
//                   ^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{ if context { предлог:с помощью{}.существительное:*{ падеж:род } } then 4 }


/*
// к тому же это совершенно невероятно
// ^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:к{}.'тому'{ class:местоим_сущ }.частица:же{} } then 4
}
*/


// Любовь с риском для жизни
//        ^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:с{}.'риском'{}.предлог:для{} } then 5
}

// о переходе на ее сторону
//            ^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.'ее'{ class:местоимение } } then -10
}

tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.'его'{ class:местоимение } } then -10
}

tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.'их'{ class:местоимение } } then -10
}

// С точки зрения банальной эрудиции
// ^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:с{}.'точки'{ ПАДЕЖ:ВИН } } then -10
}


// Предпочитаем вариант ДНО:
// На ее дне вы видите несколько десятков углублений.
// ^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.'дне'{ род:муж } } then -5
}


// этот росток дал обильный урожай в виде Стандартной модели элементарных частиц
//                                 ^^^^^^^^^^^^^^^^^^^^^^^^^...
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.'виде'.существительное:*{ падеж:род } } then 2
}


tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.'форме'.существительное:*{ падеж:род } } then 2
}

// ---------------------
// Темпы роста российской экономики не поднимутся выше 3%
//                                                ^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:выше{}.num_word:*{} } then 7
}


tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:ниже{}.num_word:*{} } then 7
}


// +++++++++++++++++++++++++++++++++
/*
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:навстречу{}.'другу'.'друг' } then 10
}
*/

// белый пес бросился ей навстречу.
//           ^^^^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { послелог:навстречу{}.*:*{ падеж:дат } } then 1
}


// офицер глядел им вслед.
//        ^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { послелог:вслед{}.*:*{ падеж:дат } } then 1
}

// Человек упал лицом вниз
//              ^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { послелог:вниз{}.'лицом' } then 3
}


// землянин осторожно перевернул труп лицом вверх.
//                                    ^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { послелог:вверх{}.'лицом' } then 1
}

// ++++++++++++++++++++++++++++++++++

// сегодня нельзя оставаться в стороне от главных позитивных направлений динамики в окружающем мире
//                           ^^^^^^^^^^^^ ...
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.'стороне'.предлог:от{} } then 5
}

// ------------------------------------------

// вспомни с точностью до минуты
//         ^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:с{}.'точностью'.предлог:до{} } then 5
}

// ----------------------------------

// Она всегда держалась на виду у взрослых
//                      ^^^^^^^^^ ...
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.'виду'.предлог:у{} } then 5
}

// --------------------------------------

// Подавим присоединение прилагательных ЕГО, ЕЕ, ИХ к предлогам
// под его началом была одна  из  двух компаний, контролирующих продажу бензина по городу и области

tree_scorer ВалентностьПредлога language=Russian generic
{
 if context { предлог:*{}.ЕгоЕеИх } then -10
}


// --------------------------------------

// мы сдадим работу после того, как все проверки будут закончены
//                  ^^^^^^^^^^^^^^^ ...
// мы сдаем работу по мере того, как тесты успешно завершаются
//                 ^^^^^^^^^^^^^^^^^ ...

wordentry_set ПредлоДля_То_Как=
{
 предлог:перед{},
 предлог:после{},
 предлог:по мере{},
 предлог:от{}
}

tree_scorer ВалентностьПредлога language=Russian
{
 if context { ПредлоДля_То_Как.местоим_сущ:то{}.{ ',' <SUBORDINATE_CLAUSE>*:*{} } } then 5
}


// ------------------------------------------------

// Дать банкет в честь кого-нибудь
//             ^^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.'честь'.*:*{ падеж:род } } then 2
}


// ------------------------------------------------
// В возрасте 31 года он защищает в своем любимом Гарварде диссертацию по экономике.
// ^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.'возрасте'.<RIGHT_GENITIVE_OBJECT>существительное:год{ падеж:род } } then 3
}


// На сегодня с меня хватит.
// ^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.'сегодня' } then 10
}

// ----------------------------------------------

// По отношению к марту прошлого года инфляция ускорилась до 22,5%.
// ^^^^^^^^^^^^^^ ...
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:по{}.'отношению'.'к' } then 5
}

// -----------------------------------------------

// спекуляция денежными бумагами в расчете на курсовые колебания
//                               ^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.'расчете'.'на'.*:*{ падеж:вин } } then 5
}

// -------------------------------------------------

// Отрицательные местоимения обычно неоходно участвуют в предложной конструкции:
// Позади никого не было.
// ~~~~~~ ~~~~~~
tree_scorer ВалентностьПредлога language=Russian generic
{
 if context { предлог:*{}.ОтрицМестоим } then -2
}

// И что же вы в связи с этим задумали?
//             ^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.'связи'{ падеж:вин }.предлог:с{} } then -1
}

// Он завернул к нам по пути на работу.
//                   ^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:по{}.'пути'{ падеж:вин }.предлог:на{} } then -1
}


// Трагедия произошла около недели назад.
//                    ^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { послелог:назад{}.{ существительное:*{ падеж:вин одуш:неодуш } наречие:около{} } }
  then 1
}


// Настрекотала ему с три короба!
//                  ^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { 'с'.'короба'.'три' } then 5
}


// К тому времени стало темно.
// ^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { 'к'.'тому'{ class:прилагательное }.'времени' } then 10
}


// Вы,  в  большинстве своем взрослые сеньоры, пошли на поводу у честолюбивого  юнца
//                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { 'на'.'поводу'{ падеж:мест }.'у'.*:*{ падеж:род } } then 5
}


// Или в пылу своей свадьбы забудут о нас.
//     ^^^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { 'в'.'пылу'{ падеж:мест }.существительное:*{ падеж:род } } then 5
}


// мы столпились на краю испепеленного неизвестного мира.
//               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { 'на'.'краю'{ падеж:мест }.существительное:*{ падеж:род } } then 5
}

// От всей души.
// ^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { 'от'.'всей'.'души' } then 5
}

// Гуляли вдоль моря.
//        ^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { 'вдоль'.'моря' } then 1
}

// Летели вдоль побережья.
//        ^^^^^^^^^^^^^^^
// Ехали вдоль берега.
//       ^^^^^^^^^^^^
// Двигались вдоль реки.
//           ^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { 'вдоль'.существительное:*{ одуш:неодуш } } then 2
}

// Заглянули внутрь комнаты.
//           ^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { 'внутрь'.существительное:*{ одуш:неодуш } } then 2
}

// Со вчера осталось.
// ^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { 'со'.'вчера' } then 2
}


// В 1733 г. поступил в школу.
// ^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.существительное:"г."{ ПАДЕЖ:ПРЕДЛ }.NUM_WORD:*{} }
  then 2
}



// Это случилось в 1973 г.
//               ^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.NUM_WORD:*{}.существительное:"г."{ ~ПАДЕЖ:ПРЕДЛ } }
  then -1
}


tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.существительное:"г."{ ~ПАДЕЖ:ПРЕДЛ }.NUM_WORD:*{} }
  then -1
}


// От всей души.
// ^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:от{}.'души'.'всей' }
  then 4
}

// Во рту стало неприятно горько.
// ^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { "во".'рту' }
  then 4
}

// Одушевленный объект обычно не употребляется с "В РЕЗУЛЬТАТЕ"
// Заглонитель Ланс Оливер чуть не погиб в результате наплочения турма.
//                                       ^^^^^^^^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.'результате'.ОдушОбъект }
  then -10
}


// На душе полегчало...
// ^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { "на"."душе"{ РОД:МУЖ } }
  then -2
}


// к тому времени
tree_scorer ВалентностьПредлога language=Russian
{
 if context { "к"."времени"."тому" }
  then 2
}

// нащупать на дне
//          ^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.существительное:дно{ падеж:предл род:ср } }
  then 1
}

// Образоваться на дне
//              ^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.существительное:дно{ падеж:предл род:муж } }
  then -5
}



// Во главе буду я.
// ^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { "во".существительное:глава{ род:жен } }
  then 2
}


// выбор из двух зол
//       ^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { "из".'зол'.'двух' }
  then 5
}


// из чувства мести?
// ^^^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { "из".'чувства'.'мести' }
  then 5
}


// я присел в их тени
//          ^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { "в".'тени'{ ПАДЕЖ:МЕСТ } }
  then 5
}

// Теперь только под самый Новый год могу взять.
tree_scorer ВалентностьПредлога language=Russian
{
 if context { "под".'год'.'новый' }
  then 5
}


// Так было и на сей раз.
//            ^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.существительное:раз{ падеж:вин } }
  then 5
}

// Правительство работает без оглядки на какое-то второе лицо.
//                        ^^^^^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:без{}.'оглядки'.'на' }
  then 5
}


// В отеле работает небольшое количество русских.
// ^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.существительное:отел{ падеж:предл } }
  then -5
}

// На три части.
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.существительное:часть{} }
  then 5
}

// Нас берут в клещи
//           ^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:в{}.существительное:клещи{ падеж:им } }
  then -10
}

// Почти без дыма.
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:без{}.<ATTRIBUTE>наречие:почти{} }
  then 5
}


// Сегодня у нас на очереди соли Аммония.
//               ^^^^^^^^^^
tree_scorer ВалентностьПредлога language=Russian
{
 if context { предлог:на{}.'очереди'{} }
  then 5
}
