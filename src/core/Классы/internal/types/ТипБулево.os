Перем ОписаниеОшибкиКласса;

// Возвращает строковое представление значения типаа
//
// Параметры:
//   Значение - Булево - значение типа
//
//  Возвращаемое значение:
//   строка - значение в строковом представлении
//
Функция ВСтроку(Значение) Экспорт
	
	Возврат Строка(Значение);
	
КонецФункции

// Преобразует и устанавливает входящее значение к значению типа
//
// Параметры:
//   ВходящееЗначение - строка - строковое представление значения
//   Значение - булево - переменная для установки значения
//
//  Возвращаемое значение:
//   булево - конвертированные значение
//
Функция УстановитьЗначение(Знач ВходящееЗначение, Значение) Экспорт

	Если ТипЗнч(ВходящееЗначение) = Тип("Булево") Тогда
		Возврат ВходящееЗначение;
	КонецЕсли;

	Попытка
		Значение = Булево(ВходящееЗначение);
	Исключение
		ОписаниеОшибкиКласса = ОписаниеОшибки();
	КонецПопытки;
	
	Возврат Значение;

КонецФункции 

// Возвращает описание ошибки и устанавливает признак ошибки 
//
// Параметры:
//   ЕстьОшибка - булево - произвольная переменная
//
//  Возвращаемое значение:
//   Строка - описание текущей ошибки преобразования типов
//
Функция Ошибка(ЕстьОшибка = Ложь) Экспорт
	
	Если НЕ ПустаяСтрока(ОписаниеОшибкиКласса) Тогда
		ЕстьОшибка = Истина;
	КонецЕсли;

	Возврат ОписаниеОшибкиКласса;
	
КонецФункции

ОписаниеОшибкиКласса = "";