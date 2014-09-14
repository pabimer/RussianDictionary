﻿// Восходяще-нисходящая сборка союзного именного паттерна.
// Число определяется как число первого элемента перечисления.

// +++++++++++++++++++++++++++++++++++++++++++++

patterns ЛогичЭлементСущ export { KEYFEATURE_REQUIRED РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }

pattern ЛогичЭлементСущ
{
 n=СущОбращение:export{ KEYFEATURE_REQUIRED:0 РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}

pattern ЛогичЭлементСущ
{
 n=СущСПредложДоп:export{ KEYFEATURE_REQUIRED:0 РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}

// одно кофе и один бутерброд с сыром 
pattern ЛогичЭлементСущ
{
 ЧислСущ:export{ KEYFEATURE_REQUIRED:0 РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}

// нож с пилой, разрезающий гвозди
pattern ЛогичЭлементСущ
{
 СущСПричОборотом:export{ KEYFEATURE_REQUIRED:0 РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}

// Локатив и предложный могут смешиваться в союзном паттерне:
// На лбу и щеке.
// На лбу, носу и щеке проступало черное пятно кровоподтека.
pattern ЛогичЭлементСущ
{
 n=СущСПредложДоп{ ПАДЕЖ:МЕСТ }:export{ KEYFEATURE_REQUIRED:0 РОД ПАДЕЖ:ПРЕДЛ ЧИСЛО ОДУШ node:root_node }
}

// Это сделал не он, а его помощник
//               ^^
pattern ЛогичЭлементСущ export { (KEYFEATURE_REQUIRED) РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
{
 n=ГруппаМест:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}


// к себе и другим
//   ^^^^
pattern ЛогичЭлементСущ export { (KEYFEATURE_REQUIRED) РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
{
 n=местоим_сущ:себя{} : export { РОД ПАДЕЖ ЧИСЛО ОДУШ:ОДУШ node:root_node }
}

// к себе и другим
//          ^^^^^^
pattern ЛогичЭлементСущ export { (KEYFEATURE_REQUIRED) РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
{
 n=ГруппаПрил1 : export { РОД ПАДЕЖ ЧИСЛО ОДУШ:ОДУШ node:root_node }
} : ngrams { -9 }


// ---------------------------------------------------------

patterns ГруппаСущВосх { bottomup } export { KEYFEATURE_REQUIRED РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }

pattern ГруппаСущВосх
{
 ЛогичЭлементСущ:export{ KEYFEATURE_REQUIRED РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}

pattern ГруппаСущВосх
{
 n1=ГруппаСущВосх:export{ KEYFEATURE_REQUIRED РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 comma=','
 n2=ЛогичЭлементСущ{ =n1:Падеж }:export { +KEYFEATURE_REQUIRED }
}
: links { n1.<RIGHT_LOGIC_ITEM>comma.<NEXT_COLLOCATION_ITEM>n2 }


// Стрекозы и бабочки греются на солнышке
// ^^^^^^^^^^^^^^^^^^
pattern ГруппаСущВосх
{
 n1=ГруппаСущВосх:export { KEYFEATURE_REQUIRED РОД ПАДЕЖ ОДУШ ЧИСЛО node:root_node }
 conj=ЛогичСоюз
 n2=ЛогичЭлементСущ{ =n1:ПАДЕЖ }:export{ +KEYFEATURE_REQUIRED }
}
: links { n1.<RIGHT_LOGIC_ITEM>conj.<NEXT_COLLOCATION_ITEM>n2 }
: ngrams { 1 }


wordentry_set НаречВперечисл=наречие:{
"хотя бы",
"еще",
просто // Ты видел город или просто место?
}

// Ты видел город или просто место?
//          ^^^^^^^^^^^^^^^^^^^^^^
// Возьми револьвер или хотя бы нож.
//        ^^^^^^^^^^^^^^^^^^^^^^^^^
// России, США и еще Гондурасу
pattern ГруппаСущВосх
{
 noun=ГруппаСущВосх:export{ KEYFEATURE_REQUIRED РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 conj=ЛогичСоюз
 adv=НаречВперечисл
 n2=ЛогичЭлементСущ{ =Noun:Падеж } : export { +KEYFEATURE_REQUIRED }
} : links
{
 noun.<RIGHT_LOGIC_ITEM>conj.
       <NEXT_COLLOCATION_ITEM>n2.
        <ATTRIBUTE>adv
}






// кошки, и собаки, и утки живут в деревне дружно
// ^^^^^^^^^^^^^^^^^^^^^^^
// кошки, или собаки, или утки
// кошки, либо собаки, либо утки
pattern ГруппаСущВосх
{
 noun=ГруппаСущВосх:export{ KEYFEATURE_REQUIRED РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 comma1=','
 conj1=ЛогичСоюз
 n2=ЛогичЭлементСущ{ =Noun:Падеж } : export { +KEYFEATURE_REQUIRED }
} : links
{
 noun.<RIGHT_LOGIC_ITEM>comma1.
       <NEXT_COLLOCATION_ITEM>conj1.
        <NEXT_COLLOCATION_ITEM>n2
}



// мальчик рисует птичек, кошечек и т.д.
//                ^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаСущВосх
{
 noun=ГруппаСущВосх:export{ KEYFEATURE_REQUIRED РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 etc=ЗамыкательПеречисления
} : links { noun.<RIGHT_LOGIC_ITEM>etc }



// он захватил в плен группу очень странных созданий, а также  женщину  исключительной  красоты
//                    ^^^^^^ .......................^^^^^^^^^.........
pattern ГруппаСущВосх
{
 noun=ГруппаСущВосх:export{ KEYFEATURE_REQUIRED РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 comma=','
 conj2=союз:а{}
 adv=наречие:также{}
 n2=ЛогичЭлементСущ{ =Noun:Падеж } : export { +KEYFEATURE_REQUIRED }
} : links
{
 noun.{
       <RIGHT_LOGIC_ITEM>comma.
        <NEXT_COLLOCATION_ITEM>conj2.
         <NEXT_COLLOCATION_ITEM>adv.
          <OBJECT>n2
      }
}




// Это была кошка, а не собака
//          ^^^^^^^^^^^^^^^^^^
pattern ГруппаСущВосх
{
 noun=ГруппаСущВосх:export{ KEYFEATURE_REQUIRED РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 comma=','
 conj=союз:а{}
 p=частица:не{}
 n2=ЛогичЭлементСущ{ =Noun:Падеж }:export { +KEYFEATURE_REQUIRED }
} : links
{
 noun.
  <RIGHT_LOGIC_ITEM>comma.
   <NEXT_COLLOCATION_ITEM>conj.
    <NEXT_COLLOCATION_ITEM>p.
     <NEXT_COLLOCATION_ITEM>n2
}


// кошка, но не собака
pattern ГруппаСущВосх
{
 noun=ГруппаСущВосх:export{ KEYFEATURE_REQUIRED РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 comma=','
 conj=союз:но{}
 n=частица:не{}
 n2=ЛогичЭлементСущ{ =Noun:Падеж } : export { +KEYFEATURE_REQUIRED }
} : links
{
 noun.<RIGHT_LOGIC_ITEM>comma.
       <RIGHT_LOGIC_ITEM>conj.
        <NEXT_COLLOCATION_ITEM>n2.
         <NEGATION_PARTICLE>n
}


// -----------------------------------------------------


// к этому человеку
//   ^^^^^^^^^^^^^^
pattern ГруппаСущ4
{
 n=ГруппаСущВосх{ KEYFEATURE_REQUIRED:0 }:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
} : ngrams { ВалентностьСущ(n) }


// от нее остался только маленький камень
//                ^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаСущ4
{
 p=ЧастМодифСущ
 n=ГруппаСущ4 : export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
}
: links { n.<PREFIX_PARTICLE>p }
//: ngrams { -1 }


// К нам пришел заказчик с «проектом мечты»
//                         ^^^^^^^^^^^^^^^^
pattern ГруппаСущ4
{
 q1=ОткрывающаяКавычка
 n=ГруппаСущ4 : export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 q2=ЗакрывающаяКавычка
} : links
{
 n.{
    <PREPEND_QUOTE>q1
    <APPEND_QUOTE>q2
   }
}



// -----------------------------------------------------



// Это была не кошка, а собака
//          ^^^^^^^^^^^^^^^^^^
// Это была не кошка, но собака
//          ^^^^^^^^^^^^^^^^^^^
pattern ГруппаСущ4
{
 n=частица:не{}
 noun=ГруппаСущВосх:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 comma=','
 conj=ПротивитСоюз
 n2=ГруппаСущВосх{ =Noun:Падеж }
} : links
{
 noun.{
       <NEGATION_PARTICLE>n
       <RIGHT_LOGIC_ITEM>comma.
        <NEXT_COLLOCATION_ITEM>conj.
         <NEXT_COLLOCATION_ITEM>n2
      }
}
: ngrams { 2 }


// не только конкуренты , но и смежники высказали недоумение
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// ими могут интересоваться не только конкуренты , но и компании в многочисленных смежных отраслях
//                          ^^^^^^^^^ .....      ^^^^^^ ...
pattern ГруппаСущ4
{
 n=частица:не{}
 adv=наречие:только{}
 noun=ГруппаСущВосх:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 comma=','
 conj1=союз:но{}
 conj2=союз:и{}
 n2=ГруппаСущВосх{ =Noun:Падеж }
} : links
{
 noun.{
       <PREFIX_CONJUNCTION>adv.<NEGATION_PARTICLE>n
       <RIGHT_LOGIC_ITEM>comma.
         <RIGHT_LOGIC_ITEM>conj1.
          <RIGHT_LOGIC_ITEM>conj2.
           <NEXT_COLLOCATION_ITEM>n2
      }
}
: ngrams { 2 }


// Как рыцари, так и слуги стояли в грязи
// ^^^^^^^^^^^^^^^^^^^^^^^
// Как вьетнамцы, так и китайцы в древности считали их двумя первичными природными силами (КАК ..., ТАК И ...)
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаСущ4
{ 
 w1=союз:как{}
 noun=ГруппаСущВосх:export{ РОД ПАДЕЖ ЧИСЛО:МН ОДУШ node:root_node }
 comma=','
 w2=союз:так{}
 w3=союз:и{}
 n2=ГруппаСущВосх{ =Noun:Падеж }
} : links
{
 noun.{
       <PREFIX_CONJUNCTION>w1
       <RIGHT_LOGIC_ITEM>comma.
       <NEXT_COLLOCATION_ITEM>w2.
        <NEXT_COLLOCATION_ITEM>w3.
         <NEXT_COLLOCATION_ITEM>n2
      }
}
: ngrams { 10 }



// Это сделал не он, а его помощники
pattern ГруппаСущ4
{ 
 n=частица:не{}
 noun=ГруппаСущВосх:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 comma=','
 w2=СоединДляПрилаг
 n2=ГруппаСущВосх{ =Noun:Падеж }
} : links
{
 noun.{
       <NEGATION_PARTICLE>n
       <RIGHT_LOGIC_ITEM>comma.
        <NEXT_COLLOCATION_ITEM>w2.
         <NEXT_COLLOCATION_ITEM>n2
      }
}
: ngrams { 4 }




// И воробьи, и синицы, и снегири прилетали сюда
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// Тут появляются иногда кошки, иногда собаки
//                ^^^^^^^^^^^^^^^^^^^^^^^^^^^
// На окраине появлялись то кошки, то собаки
//                       ^^^^^^^^^^^^^^^^^^^
pattern ГруппаСущ4
{
 conj1=СоединПарнСоюз
 noun=ГруппаСущВосх:export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 comma=','
 conj2=СоединПарнСоюз
 n2=ГруппаСущВосх{ =Noun:Падеж }
} : links
{
 noun.{
       <PREFIX_CONJUNCTION>conj1
       <RIGHT_LOGIC_ITEM>comma.
        <NEXT_COLLOCATION_ITEM>conj2.
         <OBJECT>n2
      }
}





// сначала кошка, затем собака
pattern ГруппаСущ4
{
 adv1=наречие:сначала{}
 @mark(ГруппаСущВосх,Noun):export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 comma=','
 adv2=наречие:затем{}
 n2=ГруппаСущВосх{ =Noun:Падеж }
} : links
{
 noun.{
       <PREFIX_PARTICLE>adv1
       <RIGHT_LOGIC_ITEM>comma.
        <NEXT_COLLOCATION_ITEM>adv2.
         <NEXT_COLLOCATION_ITEM>n2
      }
}


// ни кошка, ни собака, ни мышка
// или кошки, или собаки, или утки
// либо кошки, либо собаки, либо утки
// то кошка, то собака, то мышка
// и кошки, и собаки, и утки
// иногда кошки, иногда собаки, иногда утки
pattern ГруппаСущ4
{
 conj1=СоединПарнСоюз
 @mark(ГруппаСущВосх,Noun):export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 comma1=','
 conj2=СоединПарнСоюз
 n2=ГруппаСущВосх{ =Noun:Падеж }
 comma2=','
 conj3=СоединПарнСоюз
 n3=ГруппаСущВосх{ =Noun:Падеж }
} : links
{
 noun.{
       <PREFIX_CONJUNCTION>conj1
       <RIGHT_LOGIC_ITEM>comma1.
        <NEXT_COLLOCATION_ITEM>conj2.
         <NEXT_COLLOCATION_ITEM>n2.
          <RIGHT_LOGIC_ITEM>comma2.
           <NEXT_COLLOCATION_ITEM>conj3.
            <NEXT_COLLOCATION_ITEM>n3
      }
}


// сначала кошки, затем собаки, наконец утки
pattern ГруппаСущ4
{
 adv1=наречие:сначала{}
 @mark(ГруппаСущВосх,Noun):export{ РОД ПАДЕЖ ЧИСЛО ОДУШ node:root_node }
 comma1=','
 adv2=наречие:затем{}
 n2=ГруппаСущВосх{ =Noun:Падеж }
 comma2=','
 adv3=наречие:наконец{}
 n3=ГруппаСущВосх{ =Noun:Падеж }
} : links
{
 noun.{
       <PREFIX_CONJUNCTION>adv1
       <RIGHT_LOGIC_ITEM>comma1.
        <NEXT_COLLOCATION_ITEM>n2.{
              <PREFIX_CONJUNCTION>adv2
              <RIGHT_LOGIC_ITEM>comma2.
               <NEXT_COLLOCATION_ITEM>n3.
                <PREFIX_CONJUNCTION>adv3
             }
      }
}


// но нам много чего говорят.
//        ^^^^^^^^^^
pattern ГруппаСущ4
{
 adv=наречие:много{}
 n='чего' : export{ РОД:СР ПАДЕЖ:ВИН ЧИСЛО:ЕД ОДУШ:НЕОДУШ node:root_node }
}
: links { n.<ATTRIBUTE>adv }
: ngrams { 5 }


// мы уже знаем почти все!
//              ^^^^^^^^^
// у них почти все получилось.
//       ^^^^^^^^^
pattern ГруппаСущ4
{
 adv=наречие:почти{}
 n=местоим_сущ:всё{} : export{ РОД:СР ПАДЕЖ ЧИСЛО:ЕД ОДУШ:НЕОДУШ node:root_node }
}
: links { n.<ATTRIBUTE>adv }
: ngrams { 3 }


// кому именно вы рассказывали?
// ^^^^^^^^^^^
pattern ГруппаСущ4
{
 n=УказМестКтоЧто : export{ РОД ПАДЕЖ ЧИСЛО:ЕД ОДУШ node:root_node }
 adv=наречие:именно{}
}
: links { n.<ATTRIBUTE>adv }
: ngrams { 3 }



// ему много чего снилось.
//     ^^^^^^^^^^
pattern ГруппаСущ4
{
 adv=наречие:много{}
 n='чего' : export{ РОД:СР ПАДЕЖ:ИМ ЧИСЛО:ЕД ОДУШ:НЕОДУШ node:root_node }
}
: links { n.<ATTRIBUTE>adv }
: ngrams { 5 }


// ---------------------------------------------

// ученый обвел кругом все три.
//                     ^^^^^^^
pattern СущСРодДоп
{
 a=ГруппаПрил1{ ~падеж:им число:мн } : export { ПАДЕЖ ОДУШ РОД }
 n=ГруппаЧисл{ =a:ПАДЕЖ } : export { ЧИСЛО:МН node:root_node }
}
: links { n.<ATTRIBUTE>a }

/*
// наконец она повернулась к двум остальным. 
//                           ^^^^^^^^^^^^^^
pattern СущСРодДоп
{
 n=ГруппаЧисл : export { ЧИСЛО:МН node:root_node }
 a=прилагательное:*{ =n:падеж число:мн } : export { ПАДЕЖ ОДУШ РОД }
}
: links { n.<ATTRIBUTE>a }
: ngrams { -1 }
*/
// ---------------------------------------------

// Полное перечисление со словом НИЧЕГО:
//
// В доме не было ничего - ни еды, ни белья, ни одежды, ни мыла...
//                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ГруппаСущ4
{
 n=местоим_сущ:ничто{ падеж:род } : export{ РОД:СР ПАДЕЖ ЧИСЛО:ЕД ОДУШ:НЕОДУШ node:root_node }
 p=пунктуатор:*{}
 nx=ГруппаСущ4{ ПАДЕЖ:РОД }
}
: links { n.<DETAILS>p.<NEXT_COLLOCATION_ITEM>nx }
: ngrams { 1 }

