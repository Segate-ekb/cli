#Использовать delegate
#Использовать logos
#Использовать "./internal/lexer"
#Использовать "./internal/parser"
#Использовать "./internal/types"
#Использовать "./internal/tools"
#Использовать "./internal/path"

// Пользовательская строка использования текущей команды
Перем Спек Экспорт; // Строка
// (ЗАГОТОВКА) Содержит дополнительно подробное описания для справки по команде
Перем ПодробноеОписание Экспорт; // Строка

// Содержит экземпляр класс КонсольноеПриложения, для возможности получения экспортных свойств приложения
Перем Приложение Экспорт; // Класс КонсольноеПриложения
// Содержит входящий массив родителей текущей команды
// Устанавливается при выполнении команд родителей
Перем КомандыРодители Экспорт; // Массив классов КомандаПриложения

Перем Имя; // Строка
Перем Синонимы; // массив строк
Перем Описание; // Строка
Перем ВложенныеКоманды;  // Массив классов КомандаПриложения
Перем Опции; // Соответствие
Перем Аргументы; // Соответствие

Перем ОпцииИндекс; // Соответствие
Перем АргументыИндекс; // Соответствие

Перем КлассРеализации; // Объект

Перем НачальноеСостояние; // Класс Совпадение
Перем РефлекторПроверкиКоманд; // Класс Рефлектор

Перем ДействиеВыполнения; // Класс Делегат
Перем ДействиеПередВыполнением; // Класс Делегат
Перем ДействиеПослеВыполнения; // Класс Делегат

Перем Лог;

// Функция добавляет вложенную команду в текущую и возвращает экземпляр данной команды
//
// Параметры:
//   ИмяПодкоманды - строка - в строке допустимо задавать синоним через пробел, например "exec e"
//   ОписаниеПодкоманды - строка - описание команды для справки
//   КлассРеализацииПодкоманды - объект - класс, объект реализующий функции выполнения команды.
//                                     Так же используется, для автоматической настройки опций и параметров команды
//
// Возвращаемое значение:
//   Команда - объект -  класс КомандаПриложения
Функция ДобавитьПодкоманду(ИмяПодкоманды, ОписаниеПодкоманды, КлассРеализацииПодкоманды) Экспорт

	Подкоманда = Новый КомандаПриложения(ИмяПодкоманды, ОписаниеПодкоманды, КлассРеализацииПодкоманды, Приложение);

	Подкоманда = ВыполнитьОписаниеКоманды(КлассРеализацииПодкоманды, Подкоманда);
	ВложенныеКоманды.Добавить(Подкоманда);
	Возврат Подкоманда;

КонецФункции

// Функция добавляет вложенную команду в текущую и возвращает экземпляр данной команды
// Симноним метода <ДобавитьПодкоманду>
//
// Параметры:
//   ИмяПодкоманды - строка - в строке допустимо задавать синоним через пробел, например "exec e"
//   ОписаниеПодкоманды - строка - описание команды для справки
//   КлассРеализацииПодкоманды - объект - класс, объект реализующий функции выполнения команды.
//                                     Так же используется, для автоматической настройки опций и параметров команды
//
// Возвращаемое значение:
//   Команда - объект -  класс КомандаПриложения
Функция ДобавитьКоманду(ИмяПодкоманды, ОписаниеПодкоманды, КлассРеализацииПодкоманды) Экспорт

	Возврат ДобавитьПодкоманду(ИмяПодкоманды, ОписаниеПодкоманды, КлассРеализацииПодкоманды);

КонецФункции

// Функция массив вложенных команд, текущей команды
//
// Возвращаемое значение:
//  ВложенныеКоманды - массив - элементы класс КомандаПриложения
Функция ПолучитьПодкоманды() Экспорт

	Возврат ВложенныеКоманды;

КонецФункции

// Функция возвращает текущее имя команды
//
// Возвращаемое значение:
//   Имя - строка - имя текущей команды
Функция ПолучитьИмяКоманды() Экспорт
	Возврат Имя;
КонецФункции

// Функция массив синонимов команды
//
// Возвращаемое значение:
//  Синонимы - массив - элементы строка
Функция ПолучитьСинонимы() Экспорт
	Возврат Синонимы;
КонецФункции

// Функция возвращает описание команды
//
// Возвращаемое значение:
//  Описание - строка - описание текущей команды
Функция ПолучитьОписание() Экспорт
	Возврат Описание;
КонецФункции

// Функция возвращает значение опции по переданному имени/синониму опции
//
// Параметры:
//   ИмяОпции - строка - имя или синоним опции
//
// Возвращаемое значение:
//   Значение - Произвольный - полученное значение в результате чтения строки использования или переменных окружения
Функция ЗначениеОпции(Знач ИмяОпции) Экспорт

	ОпцияИндекса = ОпцияИзИндекса(ИмяОпции);
	
	Если ОпцияИндекса = Неопределено Тогда
		
		ЗначениеОпцииРодителя = ЗначениеОпцииКомандыРодителя(ИмяОпции);

		Если Не ЗначениеОпцииРодителя = Неопределено Тогда
			Возврат ЗначениеОпцииРодителя;
		КонецЕсли;

	КонецЕсли;
	
	Если ОпцияИндекса = Неопределено Тогда
	
		ВызватьИсключение СтрШаблон("Ошибка получение значения опции <%1>. 
		|Опция не найдена в индексе опций команды", ИмяОпции);

	КонецЕсли;

	Возврат ОпцияИндекса.Значение;

КонецФункции

// Функция возвращает значение аргумента по переданному имени аргумента
//
// Параметры:
//   ИмяАргумента - строка - имя аргумента
//
// Возвращаемое значение:
//   Значение - Произвольный - полученное значение в результате чтения строки использования или переменных окружения
Функция ЗначениеАргумента(Знач ИмяАргумента) Экспорт

	АргументИндекса = АргументИзИндекса(ИмяАргумента);

	Если АргументИндекса = Неопределено Тогда
		ЗначениеАргументаРодителя = ЗначениеАргументаКомандыРодителя(ИмяАргумента);

		Если Не ЗначениеАргументаРодителя = Неопределено Тогда
			Возврат ЗначениеАргументаРодителя;
		КонецЕсли;

	КонецЕсли;

	Если АргументИндекса = Неопределено Тогда
		ВызватьИсключение СтрШаблон("Ошибка получение значения аргумента <%1>.
		|Аргумент не найден в индексе аргументов команды", ИмяАргумента);
	КонецЕсли;

	Возврат АргументИндекса.Значение;

КонецФункции

// Функция возвращает значение опции команды родителя по переданному имени/синониму опции 
// Возвращает первое из совпадений или неопределенно в случае отсутствия опции
//
// Параметры:
//   ИмяОпции - строка - имя или синоним опции
//
// Возвращаемое значение:
//   Значение - Произвольный, Неопределенно - полученное значение в результате чтения строки использования или переменных окружения
//									или неопределенно в случае отсутствия в индексе указанной опции
Функция ЗначениеОпцииКомандыРодителя(Знач ИмяОпции) Экспорт

	Лог.Отладка("Ищю опцию <%1> для родителей", ИмяОпции);
		
	Для каждого РодительКоманды Из КомандыРодители Цикл
	
		Лог.Отладка(" --> Проверяю родителя <%1>", РодительКоманды.ПолучитьИмяКоманды());
	
		ОпцияРодителя = РодительКоманды.ОпцияИзИндекса(ИмяОпции);
		
		Если НЕ ОпцияРодителя = Неопределено Тогда
			Возврат ОпцияРодителя.Значение;
		КонецЕсли;

		ОпцияВышестоящегоРодителя = РодительКоманды.ЗначениеОпцииКомандыРодителя(ИмяОпции);

		Если НЕ ОпцияВышестоящегоРодителя = Неопределено Тогда
			Возврат ОпцияВышестоящегоРодителя.Значение;
		КонецЕсли;

	КонецЦикла;

	Возврат Неопределено;

КонецФункции

// Функция возвращает значение аргумента команды родителя по переданному имени аргумента
// Возвращает первое из совпадений или неопределенно в случае отсутствия аргумента
//
// Параметры:
//   ИмяАргумента - строка - имя аргумента
//
// Возвращаемое значение:
//   Значение - Произвольный, Неопределенно - полученное значение в результате чтения строки использования или переменных окружения
//									или неопределенно в случае отсутствия в индексе указанного аргумента
Функция ЗначениеАргументаКомандыРодителя(Знач ИмяАргумента) Экспорт

	Лог.Отладка("Ищю аргумент <%1> для родителей", ИмяАргумента);

	Для каждого РодительКоманды Из КомандыРодители Цикл

		Лог.Отладка(" --> Проверяю родителя <%1>", РодительКоманды.ПолучитьИмяКоманды());

		АргументРодителя = РодительКоманды.АргументИзИндекса(ИмяАргумента);

		Если НЕ АргументРодителя = Неопределено Тогда
			Возврат АргументРодителя.Значение;
		КонецЕсли;

		АргументВышестоящегоРодителя = РодительКоманды.ЗначениеАргументаКомандыРодителя(ИмяАргумента);

		Если НЕ АргументВышестоящегоРодителя = Неопределено Тогда
			Возврат АргументВышестоящегоРодителя.Значение;
		КонецЕсли;

	КонецЦикла;

	Возврат Неопределено;

КонецФункции

// Функция возвращает все параметры команды, для доступа к ним по синонимам
//
// Возвращаемое значение:
//   Параметры - Соответствие - содержит Соответствие
//      * Ключ - строка - имя или синоним опции/аргумента команды
//      * Значение - Произвольный -  полученное значение в результате чтения строки использования или переменных окружения
Функция ПараметрыКоманды() Экспорт

	ПКоманды = Новый Соответствие;

	Для каждого КлючЗначение Из ОпцииИндекс Цикл
		ПКоманды.Вставить(КлючЗначение.Ключ, КлючЗначение.Значение.Значение);
	КонецЦикла;

	Для каждого КлючЗначение Из АргументыИндекс Цикл
		ПКоманды.Вставить(КлючЗначение.Ключ, КлючЗначение.Значение.Значение);
	КонецЦикла;

	Возврат ПКоманды;

КонецФункции

// Предопределенная процедура ПередВыполнениемКоманды команды, если не задана процедура в классе.
// Содержит код определение необходимости вывода версии приложения
//
// Параметры:
//   Команда - Объект - Класс "КомандаПриложения"
//
Процедура ПередВыполнениемКоманды(Знач Команда) Экспорт
	Лог.Отладка("Выполнена стандартная обработка <ПередВыполнениемКоманды> для команды %1", Команда.ПолучитьИмяКоманды());
КонецПроцедуры

// Предопределенная процедура ПослеВыполненияКоманды команды, если не задана процедура в классе.
//
// Параметры:
//   Команда - Объект - Класс "КомандаПриложения"
//
Процедура ПослеВыполненияКоманды(Знач Команда) Экспорт
	Лог.Отладка("Выполнена стандартная обработка <ПослеВыполненияКоманды> для команды %1", Команда.ПолучитьИмяКоманды());
КонецПроцедуры

// Процедура выводит справку по команде в консоль
Процедура ВывестиСправку() Экспорт

	Представление = ?(КомандыРодители.Количество() > 0, "Команда", "Приложение");

	Сообщить(СтрШаблон("%1: %2
	| %3", Представление, СтрСоединить(Синонимы, ", "), ?(ПустаяСтрока(ПодробноеОписание), Описание, ПодробноеОписание)));
	Сообщить("");

	ПолныйПуть = Новый Массив;

	Для каждого Родитель Из КомандыРодители Цикл
		ПолныйПуть.Добавить(Родитель.ПолучитьИмяКоманды());
	КонецЦикла;
	ПолныйПуть.Добавить(СокрЛП(Имя));

	ПутьИспользования = СтрСоединить(ПолныйПуть, " ");
	СуффиксВложенныхКоманды = "";
	Если ВложенныеКоманды.Количество() > 0  Тогда

		СуффиксВложенныхКоманды = "КОМАНДА [аргументы...]";

	КонецЕсли;

	ШаблонСтрокиИспользования = "Строка запуска: %1 %2 %3";
	Сообщить(СтрШаблон(ШаблонСтрокиИспользования,
											ПутьИспользования,
											СокрЛП(Спек),
											СуффиксВложенныхКоманды));

	Сообщить("");

	ШаблонЗаголовкаНаименования = "%1:" + Символы.Таб;

	Если Аргументы.Количество() > 0 Тогда

		Сообщить(СтрШаблон(ШаблонЗаголовкаНаименования, "Аргументы"));

		ТаблицаАругментов = ТаблицаАргументовДляСправки();

		ВывестиТаблицуСправки(ТаблицаАругментов);

	КонецЕсли;

	Если Опции.Количество() > 0 Тогда

		Сообщить(СтрШаблон(ШаблонЗаголовкаНаименования, "Опции"));
		ТаблицаОпций = ТаблицаОпцийДляСправки();
		ВывестиТаблицуСправки(ТаблицаОпций);

	КонецЕсли;

	Если ВложенныеКоманды.Количество() > 0 Тогда

		Сообщить(СтрШаблон(ШаблонЗаголовкаНаименования, "Доступные команды"));

		МаксимальнаяДлинаКоманд = 0;

		Для каждого ВложеннаяКоманда Из ВложенныеКоманды Цикл
			НоваяДлина = СтрДлина(СтрСоединить(ВложеннаяКоманда.ПолучитьСинонимы(), ", "));
			МаксимальнаяДлинаКоманд = ?(НоваяДлина > МаксимальнаяДлинаКоманд, НоваяДлина, МаксимальнаяДлинаКоманд);
		КонецЦикла;

		ШаблонВложеннойКоманды = "  %1" + Символы.Таб + "%2";

		Для каждого ВложеннаяКоманда Из ВложенныеКоманды Цикл

			ПредставлениеВлКоманды = СтрСоединить(ВложеннаяКоманда.ПолучитьСинонимы(), ", ");
			ТекущаяДлина = СтрДлина(ПредставлениеВлКоманды);
			
			НаименованиеДляСправки = ДополнитьСтрокуПробелами(ПредставлениеВлКоманды, МаксимальнаяДлинаКоманд - ТекущаяДлина);
			ОписаниеДляСправки = ВложеннаяКоманда.ПолучитьОписание();
			Сообщить(СтрШаблон(ШаблонВложеннойКоманды, НаименованиеДляСправки, ОписаниеДляСправки));

		КонецЦикла;

		Сообщить("");

		Сообщить(СтрШаблон("Для вывода справки по доступным командам наберите: %1 КОМАНДА %2", ПутьИспользования, "--help"));

	КонецЕсли;

КонецПроцедуры

Процедура ВывестиТаблицуСправки(ТаблицаДанных)
	
	ДобавочнаяДлинаДополнения = 3;

	ШаблонНаименования =  "  %1"+ Символы.Таб + "%2";
	
	Для каждого СтрокаТаблицы Из ТаблицаДанных Цикл

		Сообщить(СтрШаблон(ШаблонНаименования, СтрокаТаблицы.Наименование, СтрокаТаблицы.Описание));

		Если Не ПустаяСтрока(СтрокаТаблицы.ДополнительноеОписание) Тогда
			
			СтрокаНаименования = СтрШаблон("  %2%1%", Символы.Таб, СтрокаТаблицы.Наименование);

			ДлинаДополнения = СтрДлина(СтрокаНаименования) + ДобавочнаяДлинаДополнения;
			МассивСтрок = СтрРазделить(СтрокаТаблицы.ДополнительноеОписание, Символы.ПС, Ложь);

			Для каждого СтрокаОписания Из МассивСтрок Цикл
				ДопОписаниеСтроки = ДополнитьСтрокуПробеламиДо(СтрокаОписания, ДлинаДополнения);
				Сообщить(ДопОписаниеСтроки);
			КонецЦикла;

		КонецЕсли;

	КонецЦикла;

	Сообщить("");

КонецПроцедуры

// Основная процедура запуска команды приложения
//
// Параметры:
//   АргументыCLI - Массив - Элементы <Строка>
//
Процедура Запуск(Знач АргументыCLI) Экспорт

	Если НужноВывестиСправку(АргументыCLI) Тогда
		ВывестиСправку();
		Возврат;
	КонецЕсли;

	ОчиститьАргументы(АргументыCLI);

	ПоследнийИндекс = ПолучитьОпцииИАргументы(АргументыCLI);

	Лог.Отладка("Количество входящих аргументов команды: %1", АргументыCLI.Количество());
	Лог.Отладка("Последний индекс аргументов команды: %1", ПоследнийИндекс);

	КонечныйИндексКоманды = ПоследнийИндекс;

	МассивАргументовКПарсингу = Новый Массив;

	Для ИИ = 0 По КонечныйИндексКоманды Цикл
		МассивАргументовКПарсингу.Добавить(АргументыCLI[ИИ]);
	КонецЦикла;

	Лог.Отладка("Читаю аргументы строки");
	ОшибкаЧтения = Не НачальноеСостояние.Прочитать(МассивАргументовКПарсингу);

	Если ОшибкаЧтения Тогда
		Лог.КритичнаяОшибка("Ошибка чтения параметров команды");
		ВывестиСправку();
		Возврат;
	КонецЕсли;

	ДействиеПередВыполнением.Исполнить(ЭтотОбъект);

	Если КонечныйИндексКоманды = АргументыCLI.ВГраница() Тогда

		Лог.Отладка("Выполняю полезную работу %1", Имя);
		ДействиеВыполнения.Исполнить(ЭтотОбъект);

		Возврат;
	КонецЕсли;

	ПервыйАргумент = АргументыCLI[КонечныйИндексКоманды + 1];

	Для каждого ВложеннаяКоманда Из ВложенныеКоманды Цикл

		Если ВложеннаяКоманда.ЭтоСинонимКоманды(ПервыйАргумент) Тогда

			АргументыПодкоманды = Новый Массив;
			СмещениеНачальногоИндекса = 2;

			НачальныйИндекс = КонечныйИндексКоманды + СмещениеНачальногоИндекса;

			Если НачальныйИндекс <= АргументыCLI.ВГраница() Тогда

				Для ИИ = НачальныйИндекс По АргументыCLI.ВГраница() Цикл
					АргументыПодкоманды.Добавить(АргументыCLI[ИИ]);
				КонецЦикла;

			КонецЕсли;

			ВложеннаяКоманда.НачалоЗапуска();
			ВложеннаяКоманда.Запуск(АргументыПодкоманды);

			ДействиеПослеВыполнения.Исполнить(ЭтотОбъект);

			Возврат;

		КонецЕсли;

	КонецЦикла;

	ДействиеПослеВыполнения.Исполнить(ЭтотОбъект);

	Если СтрНачинаетсяС(ПервыйАргумент, "-") Тогда
		ВывестиСправку();
		ВызватьИсключение "Не известная опция";

	КонецЕсли;

	ВывестиСправку();

	ВызватьИсключение "Вызвать исключение не корректное использование";

КонецПроцедуры

// Функция проверяет строку, что она является ли синонимом текущей команды
//
// Параметры:
//   СтрокаПроверки - строка - имя команды, для проверки
//
// Возвращаемое значение:
//   булево - истина. если это синоним или имя текущей команды, иначе ложь
Функция ЭтоСинонимКоманды(СтрокаПроверки) Экспорт
	Возврат Не Синонимы.Найти(СтрокаПроверки) = Неопределено;
КонецФункции

// Процедура подготавливает команды к запуску
// Формирует строку использования и
// настраивает парсер для выполнения парсинга входящих параметров
// Обязательно вызывается пред выполнением команды
Процедура НачалоЗапуска() Экспорт

	КомандыРодителиДляПодчиненной = Новый Массив;

	Для каждого КомандаРодитель Из КомандыРодители Цикл
		КомандыРодителиДляПодчиненной.Добавить(КомандаРодитель);
	КонецЦикла;

	КомандыРодителиДляПодчиненной.Добавить(ЭтотОбъект);

	Для каждого Подчиненнаякоманда Из ВложенныеКоманды Цикл
		Подчиненнаякоманда.КомандыРодители = КомандыРодителиДляПодчиненной;
	КонецЦикла;

	ДобавитьОпцииВИндекс();
	ДобавитьАргументыВИндекс();

	Лог.Отладка("Входящий спек: %1", Спек);

	Если ПустаяСтрока(Спек) Тогда

		Лог.Отладка("Количество опций строки: %1", Опции.Количество());
		Если Опции.Количество() > 0 Тогда
			Спек = "[ОПЦИИ] ";
		КонецЕсли;
		
		Если Аргументы.Количество() > 0 Тогда
			Спек = Спек + "-- ";
		КонецЕсли;

		Лог.Отладка("Количество аргументы строки: %1", Аргументы.Количество());
		Для каждого арг Из Аргументы Цикл
			
			ИмяАргумента = арг.Ключ.Имя;
			КлассАргумента = арг.Ключ;

			ДополнитьИмяАргументаМассива(ИмяАргумента, КлассАргумента);
			ДополнитьИмяАргументаНеобязательного(ИмяАргумента, КлассАргумента);
	
			Лог.Отладка("Добавляю аргумет <%1> в спек <%2>", ИмяАргумента, Спек);
			Спек = Спек + ИмяАргумента + " ";
		
		КонецЦикла;

	КонецЕсли;
	
	Лог.Отладка("Разбираю строку использования с помощью лексера");

	Лексер = Новый Лексер(Спек).Прочитать();
	Если Лексер.ЕстьОшибка() Тогда
		Лексер.ВывестиИнформациюОбОшибке();
		ВызватьИсключение "Ошибка разбора строки использования";
	КонецЕсли;

	ТокеныПарсера = Лексер.ПолучитьТокены();

	ПараметрыПарсера =  Новый Структура;
	ПараметрыПарсера.Вставить("Спек", Спек);
	ПараметрыПарсера.Вставить("Опции", Опции);
	ПараметрыПарсера.Вставить("Аргументы", Аргументы);
	ПараметрыПарсера.Вставить("ОпцииИндекс", ОпцииИндекс);
	ПараметрыПарсера.Вставить("АргументыИндекс", АргументыИндекс);

	Парсер = Новый Парсер(ТокеныПарсера, ПараметрыПарсера);
	НачальноеСостояние = парсер.Прочитать();

	ВывестиПутьПарсераВОтладке();

КонецПроцедуры

// Функция добавляет опцию команды и возвращает экземпляр данной опции
//
// Параметры:
//   Имя      - строка - имя опции, в строке допустимо задавать синоним через пробел, например "s some-opt"
//   Значение - строка - значение опции по умолчанию
//   Описание - объект - описание опции для справки.
//
// Возвращаемое значение:
//   ПараметрКоманды - Созданный параметр команды
//
// Дополнительно смотри справку по классу ПараметрКоманды
Функция Опция(Имя, Значение = "", Описание = "") Экспорт

	НоваяОпция = Новый ПараметрКоманды("опция", Имя, Значение, Описание);
	Опции.Вставить(НоваяОпция, НоваяОпция);

	Возврат НоваяОпция;

КонецФункции

// Функция добавляет аргумент команды и возвращает экземпляр данной аргумента
//
// Параметры:
//   Имя      - строка - имя аргумента, в строке допустимо использование только из БОЛЬШИХ латинских букв, например "ARG"
//   Значение - строка - значение аргумента по умолчанию
//   Описание - объект - описание аргумента для справки.
//
// Возвращаемое значение:
//   ПараметрКоманды - Созданный параметр команды
//
// Дополнительно смотри справку по классу ПараметрКоманды
Функция Аргумент(Имя, Значение = "", Описание = "") Экспорт

	НовыйАргумент = Новый ПараметрКоманды("аргумент", Имя, Значение, Описание);
	Аргументы.Вставить(НовыйАргумент, НовыйАргумент);

	Возврат НовыйАргумент;

КонецФункции

// Функция возвращает значение опции по переданному имени/синониму опции
//
// Параметры:
//   ИмяОпции - строка - имя или синоним опции
//
// Возвращаемое значение:
//   ПараметраКоманды, Неопределенно - класс опции, находящийся в индексе Опций команды
//										Неопределенно, в случае отсутствия в индексе опций с запрошенным именем 
Функция ОпцияИзИндекса(Знач ИмяОпции) Экспорт
	
	Если СтрНачинаетсяС(ИмяОпции, "-")
		Или СтрНачинаетсяС(ИмяОпции, "--") Тогда
		// Ничего не делаем переданы уже нормализированные опции
	Иначе
		Префикс = "-";
		Если СтрДлина(ИмяОпции) > 1 Тогда
				Префикс = "--";
		КонецЕсли;
		ИмяОпции = СтрШаблон("%1%2", Префикс, ИмяОпции);
	КонецЕсли;

	ОпцииИндекса = ОпцииИндекс[ИмяОпции];

	Возврат ОпцииИндекса;

КонецФункции

// Функция возвращает параметры команды для аргумента по переданному имени аргумента
//
// Параметры:
//   ИмяАргумента - строка - имя аргумента
//
// Возвращаемое значение:
//   ПараметраКоманды, Неопределенно - класс аргумента, находящийся в индексе Аргументов команды
//										Неопределенно, в случае отсутствия в индексе аргумента с запрошенным именем 
Функция АргументИзИндекса(Знач ИмяАргумента) Экспорт
	
	АргументИндекса = АргументыИндекс[ВРег(ИмяАргумента)];

	Возврат АргументИндекса;

КонецФункции

// Процедура устанавливает процедуру "ВыполнитьКоманду" выполнения для команды
//
// Параметры:
//   КлассРеализации - объект - класс, объект реализующий процедуру выполнения команды.
//   ИмяПроцедуры - строка - имя процедуры, отличное от стандартного "ВыполнитьКоманду"
//
Процедура УстановитьДействиеВыполнения(КлассРеализации, ИмяПроцедуры = "ВыполнитьКоманду") Экспорт

	Если ПроверитьМетодВыполнитьКоманду(КлассРеализации, ИмяПроцедуры) Тогда
		ВызватьИсключение СтрШаблон("У класса <%1> не задан обязательный метод <%2>", КлассРеализации, ИмяПроцедуры);
	КонецЕсли;

	ДействиеВыполнения = Делегаты.Создать(КлассРеализации, ИмяПроцедуры);

КонецПроцедуры

// Процедура устанавливает процедуру "ПередВыполнениемКоманды" выполнения для команды
// запускаемую перед выполнением "ВыполнитьКоманду"
//
// Параметры:
//   КлассРеализации - объект - класс, объект реализующий процедуру выполнения команды.
//   ИмяПроцедуры - строка - имя процедуры, отличное от стандартного "ПередВыполнениемКоманды"
//
Процедура УстановитьДействиеПередВыполнением(КлассРеализации, ИмяПроцедуры = "ПередВыполнениемКоманды") Экспорт

	Лог.Отладка("Установка метода: перед выполнением класс <%1> имя процедуры <%2>", КлассРеализации, ИмяПроцедуры);

	Если НЕ ПроверитьМетодПередВыполнениемКоманды(КлассРеализации, ИмяПроцедуры) Тогда
		Лог.Отладка(" >> метод %2 у класс <%1> найден", КлассРеализации, ИмяПроцедуры);

		ДействиеПередВыполнением = Делегаты.Создать(КлассРеализации, ИмяПроцедуры);

	ИначеЕсли ДействиеПередВыполнением = Неопределено Тогда

		Лог.Отладка("Установлен метод перед выполнением в текущий класс");
		ДействиеПередВыполнением = Делегаты.Создать(ЭтотОбъект, ИмяПроцедуры);
	КонецЕсли;

КонецПроцедуры

// Процедура устанавливает процедуру "ПослеВыполненияКоманды" выполнения для команды
// запускаемую после выполнением "ВыполнитьКоманду"
//
// Параметры:
//   КлассРеализации - объект - класс, объект реализующий процедуру выполнения команды.
//   ИмяПроцедуры - строка - имя процедуры, отличное от стандартного "ПослеВыполненияКоманды"
//
Процедура УстановитьДействиеПослеВыполнения(КлассРеализации, ИмяПроцедуры = "ПослеВыполненияКоманды") Экспорт

	Лог.Отладка("Установка метода: после выполнением класс <%1> имя процедуры <%2>", КлассРеализации, ИмяПроцедуры);

	Если НЕ ПроверитьМетодПослеВыполнениемКоманды(КлассРеализации, ИмяПроцедуры) Тогда

		Лог.Отладка(" >> метод %2 у класс <%1> найден", КлассРеализации, ИмяПроцедуры);

		ДействиеПослеВыполнения = Делегаты.Создать(КлассРеализации, ИмяПроцедуры);

	ИначеЕсли ДействиеПослеВыполнения = Неопределено Тогда

		Лог.Отладка("Установлен метод после выполнением в текущий класс");
		ДействиеПослеВыполнения = Делегаты.Создать(ЭтотОбъект, ИмяПроцедуры);

	КонецЕсли;

КонецПроцедуры

#Область Работа_с_входящими_аргументами

Процедура ОчиститьАргументы(АргументыCLI)

	НовыйМассивАргументов = Новый Массив;

	Для каждого арг Из АргументыCLI Цикл

		Если ПустаяСтрока(арг) Тогда
			Продолжить;
		КонецЕсли;

		НовыйМассивАргументов.Добавить(арг);

	КонецЦикла;

	АргументыCLI = Новый ФиксированныйМассив(НовыйМассивАргументов);

КонецПроцедуры

Функция ФлагУстановлен(Знач АргументыCLI, Знач Флаг)

	Если АргументыCLI.Количество() = 0 Тогда
		Возврат Ложь;
	КонецЕсли;

	Возврат АргументыCLI[0] = Флаг;

КонецФункции

Функция ПолучитьОпцииИАргументы(Знач АргументыCLI)

	ПоследнийИндекс = -1;
	Лог.Отладка("Приверяю аргументы. Количество %1", АргументыCLI.Количество());

	Для каждого ТекущийАргумент Из АргументыCLI Цикл

		Для каждого ВложеннаяКоманда Из ВложенныеКоманды Цикл

			Лог.Отладка("Ищу подчиненную команду %1", ВложеннаяКоманда.ПолучитьИмяКоманды());
			Если ВложеннаяКоманда.ЭтоСинонимКоманды(ТекущийАргумент) Тогда
				Лог.Отладка("Подчиненная команда %1 найдена", ВложеннаяКоманда.ПолучитьИмяКоманды());
				Возврат ПоследнийИндекс;
			КонецЕсли;

		КонецЦикла;

		ПоследнийИндекс = ПоследнийИндекс + 1;

	КонецЦикла;

	Возврат ПоследнийИндекс;

КонецФункции

#КонецОбласти

#Область Работа_с_индексом_опций_и_аргументов

Процедура ДобавитьОпцииВИндекс()

	Для каждого КлючЗначение Из Опции Цикл

		КлассОпции = КлючЗначение.Ключ;
		КлассОпции.ИзПеременнойОкружения();

		Для каждого ИмяПараметра Из КлассОпции.НаименованияПараметров Цикл

			ОпцииИндекс.Вставить(ИмяПараметра, КлассОпции);

		КонецЦикла;

	КонецЦикла;

КонецПроцедуры

Процедура ДобавитьАргументыВИндекс()

	Для каждого КлючЗначение Из Аргументы Цикл

		КлассАргумента = КлючЗначение.Ключ;
		КлассАргумента.ИзПеременнойОкружения();

		Для каждого ИмяПараметра Из КлассАргумента.НаименованияПараметров Цикл

				АргументыИндекс.Вставить(ИмяПараметра, КлассАргумента);

		КонецЦикла;

	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область Работа_с_рефлектором_объектов

Функция ВыполнитьОписаниеКоманды(КлассКоманды, Подкоманда)

	Если ПроверитьМетодОписаниеКоманды(КлассКоманды) Тогда
		Возврат Подкоманда;
	КонецЕсли;

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Подкоманда);

	ОписаниеКоманды = Делегаты.Создать(КлассКоманды, "ОписаниеКоманды");
	ОписаниеКоманды.Исполнить(ПараметрыВыполнения);

	Возврат ПараметрыВыполнения[0];

КонецФункции

Функция ПроверитьМетодВыполнитьКоманду(ПроверяемыйКласс, ИмяПроцедуры)

	Возврат НЕ ПроверитьМетодКласса(ПроверяемыйКласс, ИмяПроцедуры , 1, Ложь);

КонецФункции

Функция ПроверитьМетодПередВыполнениемКоманды(ПроверяемыйКласс, ИмяПроцедуры)

	Возврат НЕ ПроверитьМетодКласса(ПроверяемыйКласс, ИмяПроцедуры, 1, Ложь);

КонецФункции

Функция ПроверитьМетодПослеВыполнениемКоманды(ПроверяемыйКласс, ИмяПроцедуры)

	Возврат НЕ ПроверитьМетодКласса(ПроверяемыйКласс, ИмяПроцедуры, 1, Ложь);

КонецФункции

Функция ПроверитьМетодОписаниеКоманды(ПроверяемыйКласс)

	Возврат НЕ ПроверитьМетодКласса(ПроверяемыйКласс, "ОписаниеКоманды", 1, Ложь);

КонецФункции

Функция ПроверитьМетодКласса(Знач ПроверяемыйКласс,
	Знач ИмяМетода,
	Знач ТребуемоеКоличествоПараметров = 0,
	Знач ЭтоФункция = Ложь)

	ЕстьМетод = РефлекторПроверкиКоманд.МетодСуществует(ПроверяемыйКласс, ИмяМетода);
	Лог.Отладка("Проверяемый метод <%1> найден: %2", ИмяМетода, ЕстьМетод);
	Если Не ЕстьМетод Тогда
		Возврат Ложь;
	КонецЕсли;

	ТаблицаМетодов = РефлекторПроверкиКоманд.ПолучитьТаблицуМетодов(ПроверяемыйКласс);

	СтрокаМетода = ТаблицаМетодов.Найти(ИмяМетода, "Имя");
	Лог.Отладка("Поиск строки в таблице методов класса <%1> найдена: %2, общее количество методов класса: %3", 
				ПроверяемыйКласс, 
				НЕ СтрокаМетода = Неопределено, 
				ТаблицаМетодов.Количество());
	
	Если СтрокаМетода = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;

	ПроверкаНаФункцию = ЭтоФункция = СтрокаМетода.ЭтоФункция;
	ПроверкаНаКоличествоПараметров = ТребуемоеКоличествоПараметров = СтрокаМетода.КоличествоПараметров;

	Лог.Отладка("Проверяемый метод <%1> корректен: %2", ИмяМетода, ПроверкаНаФункцию И ПроверкаНаКоличествоПараметров);
	Возврат ПроверкаНаФункцию
		И ПроверкаНаКоличествоПараметров;

КонецФункции // ПроверитьМетодУКласса()

#КонецОбласти

#Область Работа_со_справкой

Функция НужноВывестиСправку(Знач АргументыCLI)

	Если АргументыCLI.Количество() = 0 Тогда
		Возврат Ложь;
	КонецЕсли;

	Лог.Отладка("Вывожу справку: %1", ФлагУстановлен(АргументыCLI, "--help"));
	Возврат ФлагУстановлен(АргументыCLI, "--help");

КонецФункции

Функция ПолучитьТаблицуДанныхДляСправки()
	
	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("Наименование");
	Таблица.Колонки.Добавить("Описание");
	Таблица.Колонки.Добавить("ДлинаНаименования");
	Таблица.Колонки.Добавить("ДополнительноеОписание");

	Возврат Таблица;

КонецФункции

Функция ТаблицаАргументовДляСправки()

	Таблица = ПолучитьТаблицуДанныхДляСправки();
	
	Если Аргументы.Количество() = 0  Тогда
		Возврат Таблица;
	КонецЕсли;

	Для каждого КлючЗначение Из Аргументы Цикл

		АргументСправки = КлючЗначение.Ключ;

		НоваяЗапись = Таблица.Добавить();

		ИмяОпции = АргументСправки.Имя;
		ПеременныеОкружения = ФорматироватьПеременнуюОкруженияОпцииДляСправки(АргументСправки);
		ЗначениеОпции = ФорматироватьЗначениеОпцииДляСправки(АргументСправки);
		ОписаниеОпции = АргументСправки.Описание + " " + ПеременныеОкружения + " " + ЗначениеОпции;

		НоваяЗапись.Наименование = ИмяОпции;
		НоваяЗапись.Описание = ОписаниеОпции;
		НоваяЗапись.ДополнительноеОписание = АргументСправки.ПолучитьПодробноеОписание();
		НоваяЗапись.ДлинаНаименования = СтрДлина(ИмяОпции) + 1;

	КонецЦикла;

	ТаблицаДляСортировки = Таблица.Скопировать(, "ДлинаНаименования");
	ТаблицаДляСортировки.Сортировать("ДлинаНаименования УБЫВ");

	МаксимальнаяДлина = ТаблицаДляСортировки[0].ДлинаНаименования;

	Для каждого СтрокаТаблицы Из Таблица Цикл

		ТекущаяДлина = СтрДлина(СтрокаТаблицы.Наименование);
		Если ТекущаяДлина = МаксимальнаяДлина Тогда
			Продолжить;
		КонецЕсли;

		СтрокаТаблицы.Наименование = ДополнитьСтрокуПробелами(СтрокаТаблицы.Наименование, МаксимальнаяДлина - ТекущаяДлина);

	КонецЦикла;

	Возврат Таблица;
КонецФункции

Функция ТаблицаОпцийДляСправки()

	Таблица = ПолучитьТаблицуДанныхДляСправки();
	
	Если Опции.Количество() = 0  Тогда
		Возврат Таблица;
	КонецЕсли;

	Для каждого КлючЗначение Из Опции Цикл

		ОпцияСправки = КлючЗначение.Ключ;

		НоваяЗапись = Таблица.Добавить();

		ИмяОпции = ФорматироватьИмяОпцииДляСправки(ОпцияСправки);
		ПеременныеОкружения = ФорматироватьПеременнуюОкруженияОпцииДляСправки(ОпцияСправки);
		ЗначениеОпции = ФорматироватьЗначениеОпцииДляСправки(ОпцияСправки);
		ОписаниеОпции = ОпцияСправки.Описание + " " + ПеременныеОкружения + " " + ЗначениеОпции;
		
		НоваяЗапись.Наименование = ИмяОпции;
		НоваяЗапись.Описание = ОписаниеОпции;
		НоваяЗапись.ДополнительноеОписание = ОпцияСправки.ПолучитьПодробноеОписание();
		НоваяЗапись.ДлинаНаименования = СтрДлина(ИмяОпции) + 1;

	КонецЦикла;

	ТаблицаДляСортировки = Таблица.Скопировать(, "ДлинаНаименования");
	ТаблицаДляСортировки.Сортировать("ДлинаНаименования УБЫВ");
	МаксимальнаяДлина = ТаблицаДляСортировки[0].ДлинаНаименования;

	Для каждого СтрокаТаблицы Из Таблица Цикл

		ТекущаяДлина = СтрДлина(СтрокаТаблицы.Наименование);
		Если ТекущаяДлина = МаксимальнаяДлина Тогда
			Продолжить;
		КонецЕсли;

		СтрокаТаблицы.Наименование = ДополнитьСтрокуПробелами(СтрокаТаблицы.Наименование, МаксимальнаяДлина - ТекущаяДлина);

	КонецЦикла;

	Возврат Таблица;

КонецФункции

Функция ДополнитьСтрокуПробелами(Знач НачальнаяСтрока, КоличествоПробелов)

	Для Счетчик = 1 По КоличествоПробелов Цикл
		НачальнаяСтрока = НачальнаяСтрока + " ";
	КонецЦикла;

	Возврат НачальнаяСтрока;

КонецФункции

Функция ДополнитьСтрокуПробеламиДо(Знач НачальнаяСтрока, Знач КоличествоПробелов)

	СтрокаПробелов = "";

	Для Счетчик = 1 По КоличествоПробелов Цикл
		СтрокаПробелов = СтрокаПробелов + " ";
	КонецЦикла;

	Возврат СтрокаПробелов + НачальнаяСтрока;

КонецФункции

Функция ФорматироватьИмяОпцииДляСправки(Знач КлассОпции)

	КороткоеНаименование = "";
	ДлинноеНаименование = "";

	ОграничениеДлины = 2;

	Для каждого НаименованиеОпции Из КлассОпции.НаименованияПараметров Цикл

		Если СтрДлина(НаименованиеОпции) = ОграничениеДлины
			И ПустаяСтрока(КороткоеНаименование) Тогда
			КороткоеНаименование = НаименованиеОпции;
		КонецЕсли;

		Если СтрДлина(НаименованиеОпции) > ОграничениеДлины
			И ПустаяСтрока(ДлинноеНаименование) Тогда
			ДлинноеНаименование = НаименованиеОпции;
		КонецЕсли;

	КонецЦикла;

	Если Не ПустаяСтрока(КороткоеНаименование) 
		И Не ПустаяСтрока(ДлинноеНаименование) Тогда
		Возврат СтрШаблон("%1, %2", КороткоеНаименование, ДлинноеНаименование);
	ИначеЕсли ЗначениеЗаполнено(КороткоеНаименование) И ПустаяСтрока(ДлинноеНаименование) Тогда
		Возврат СтрШаблон("%1", КороткоеНаименование);
	ИначеЕсли ЗначениеЗаполнено(ДлинноеНаименование) И ПустаяСтрока(КороткоеНаименование) Тогда
		Возврат СтрШаблон("    %1", ДлинноеНаименование);
	КонецЕсли;

	Возврат "";

КонецФункции

Функция ФорматироватьЗначениеОпцииДляСправки(Знач КлассОпции)

	Если КлассОпции.СкрытьЗначение
		ИЛИ НЕ ЗначениеЗаполнено(КлассОпции.ЗначениеВСтроку()) Тогда
		Возврат "";
	КонецЕсли;

	Возврат СтрШаблон("(по умолчанию %1)", КлассОпции.ЗначениеВСтроку());

КонецФункции

Функция ФорматироватьПеременнуюОкруженияОпцииДляСправки(Знач КлассОпции)

	Если ПустаяСтрока(СокрЛП(КлассОпции.ПеременнаяОкружения)) Тогда
		Возврат "";
	КонецЕсли;

	СтрокаПеременнойОкружения = КлассОпции.ПеременнаяОкружения;
	МассивПО = СтрРазделить(СтрокаПеременнойОкружения, " ", Ложь);

	Результат = "(env";

	СтрокаРазделитель = " ";

	Для ИИ = 0 По МассивПО.ВГраница() Цикл

		Если ИИ > 0  Тогда
			СтрокаРазделитель = ", ";
		КонецЕсли;

		Результат = Результат + СтрШаблон("%1$%2", СтрокаРазделитель, МассивПО[ИИ]);

	КонецЦикла;

	Возврат Результат + ")";

КонецФункции

#КонецОбласти

#Область Вспомогательные_процедуры_и_функции

Процедура ВывестиПутьПарсераВОтладке()

	Если Лог.Уровень() = УровниЛога.Отладка Тогда
		
		ОбработчикВыборкиПути = Новый ВыборСовпадений();
		Лог.Отладка("Вывожу текущий путь парсинга: ");
		Лог.Отладка(ОбработчикВыборкиПути.СгенеритьСтрокуПути(НачальноеСостояние));

	КонецЕсли;
	
КонецПроцедуры

// Дополняет признаком "[]" необязательности для аргумента
//
// Параметры:
//   ИмяАргумента - Строка - Имя аргумента
//   КлассАргумента - Класс - класс аргумента
//
Процедура ДополнитьИмяАргументаНеобязательного(ИмяАргумента, КлассАргумента)
	
	Если НЕ КлассАргумента.ПолучитьОбязательностьВвода() Тогда
		
		ИмяАргумента = СтрШаблон("[%1]", ИмяАргумента);

	КонецЕсли;
	
КонецПроцедуры

// Дополняет признаком "..." для аргумента массива
//
// Параметры:
//   ИмяАргумента - Строка - Имя аргумента
//   КлассАргумента - Класс - класс аргумента
//
Процедура ДополнитьИмяАргументаМассива(ИмяАргумента, КлассАргумента) 
	
	Если КлассАргумента.ЭтоМассив() Тогда
		
		ИмяАргумента = СтрШаблон("%1...", ИмяАргумента);

	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

Процедура ПриСозданииОбъекта(ИмяКоманды, ОписаниеКоманды, КлассРеализацииКоманды, ПриложениеКоманды = Неопределено)

	Синонимы = СтрРазделить(ИмяКоманды, " ", Ложь);
	Имя = Синонимы[0];
	Описание = ОписаниеКоманды;
	КлассРеализации = КлассРеализацииКоманды;

	ВложенныеКоманды = Новый Массив;
	КомандыРодители = Новый Массив;
	Опции = Новый Соответствие;
	Аргументы = Новый Соответствие;

	ОпцииИндекс = Новый Соответствие;
	АргументыИндекс = Новый Соответствие;

	Приложение = ПриложениеКоманды;

	Спек = "";
	ПодробноеОписание = "";

	РефлекторПроверкиКоманд = Новый Рефлектор;

	ДействиеПередВыполнением = Неопределено;
	ДействиеПослеВыполнения = Неопределено;

	УстановитьДействиеВыполнения(КлассРеализацииКоманды);
	УстановитьДействиеПередВыполнением(КлассРеализацииКоманды);
	УстановитьДействиеПослеВыполнения(КлассРеализацииКоманды);

КонецПроцедуры

Лог = Логирование.ПолучитьЛог("oscript.lib.cli_command");