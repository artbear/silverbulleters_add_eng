﻿//TODO раскомментировать утверждения во всех методах после решения Архитектура взаимодействия плагинов/утилит между собой #568 https://github.com/xDrivenDevelopment/xUnitFor1C/issues/568

// { Plugin interface
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("Тип", ВозможныеТипыПлагинов.Утилита);
	Результат.Вставить("Идентификатор", Метаданные().Имя);
	Результат.Вставить("Представление", "ЗапросыИзБД");
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
КонецФункции

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
КонецПроцедуры
// } Plugin interface

//{ Методы работы с БД

// Функция - Получить количество документов по отбору
//
// Параметры:
//  видДокумента	 - 	 - 
//  Дата1			 - 	 - 
//  дата2			 - 	 - 
//  структураОтбора	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
Функция ПолучитьКоличествоДокументовПоОтбору(видДокумента, Дата1, дата2, структураОтбора = Неопределено) Экспорт
		//ПроверитьЗаполненность(видДокумента, "видДокумента");
		//ПроверитьЗаполненность(Дата1, "Дата1");
		//ПроверитьЗаполненность(Дата2, "Дата2");
		
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Доки.Ссылка) КАК КоличествоДокументов
	|ИЗ
	|	Документ."+видДокумента+" КАК Доки
	|ГДЕ
	|	Доки.Ссылка.Дата МЕЖДУ &Дата1 И &Дата2
	|";
	Запрос.УстановитьПараметр("Дата1", Дата1);
	Запрос.УстановитьПараметр("Дата2", КонецДня(Дата2));
	
	Если ЗначениеЗаполнено(структураОтбора) Тогда
		Для каждого ключЗначение Из структураОтбора Цикл
			имяРеквизита = ключЗначение.Ключ;
			Запрос.Текст = Запрос.Текст + " И Доки."+имяРеквизита+" = &"+имяРеквизита+" ";
			Запрос.УстановитьПараметр(имяРеквизита, ключЗначение.Значение);
		КонецЦикла;
	КонецЕсли; 
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат 0;
	КонецЕсли; 
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	Возврат выборка.КоличествоДокументов;
КонецФункции

// Функция - Получить количество элементов справочника по отбору
//
// Параметры:
//  видСправочника	 - 	 - 
//  структураОтбора	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
Функция ПолучитьКоличествоЭлементовСправочникаПоОтбору(видСправочника, структураОтбора = Неопределено) Экспорт
		//ПроверитьЗаполненность(видСправочника, "видСправочника");
		
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Спр.Ссылка) КАК КоличествоЭлементов
	|ИЗ
	|	Справочник."+видСправочника+" КАК Спр
	|ГДЕ
	|	Истина
	|";
	
	Если ЗначениеЗаполнено(структураОтбора) Тогда
		Для каждого ключЗначение Из структураОтбора Цикл
			имяРеквизита = ключЗначение.Ключ;
			Запрос.Текст = Запрос.Текст + " И Спр."+имяРеквизита+" = &"+имяРеквизита+" ";
			Запрос.УстановитьПараметр(имяРеквизита, ключЗначение.Значение);
		КонецЦикла;
	КонецЕсли; 
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат 0;
	КонецЕсли; 
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	Возврат выборка.КоличествоЭлементов;
КонецФункции

// Функция - Получить количество строк в документах по отбору
//
// Параметры:
//  видДокумента					 - 	 - 
//  имяТабличнойЧасти				 - 	 - 
//  Дата1							 - 	 - 
//  дата2							 - 	 - 
//  структураОтбораШапки			 - 	 - 
//  структураОтбораТабличнойЧасти	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
Функция ПолучитьКоличествоСтрокВДокументахПоОтбору(видДокумента, имяТабличнойЧасти, Дата1, дата2, структураОтбораШапки = Неопределено, структураОтбораТабличнойЧасти = Неопределено) Экспорт
		//ПроверитьЗаполненность(видДокумента, "видДокумента");
		//ПроверитьЗаполненность(Дата1, "Дата1");
		//ПроверитьЗаполненность(Дата2, "Дата2");
		
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	КОЛИЧЕСТВО(Доки.Ссылка) КАК КоличествоДокументов
	|ИЗ
	|	Документ."+видДокумента+"."+имяТабличнойЧасти+" КАК Доки
	|ГДЕ
	|	Доки.Ссылка.Дата МЕЖДУ &Дата1 И &Дата2
	|";
	Запрос.УстановитьПараметр("Дата1", Дата1);
	Запрос.УстановитьПараметр("Дата2", КонецДня(Дата2));
	
	Если ЗначениеЗаполнено(структураОтбораШапки) Тогда
		Для каждого ключЗначение Из структураОтбораШапки Цикл
			имяРеквизита = ключЗначение.Ключ;
			Запрос.Текст = Запрос.Текст + " И Доки.Ссылка."+имяРеквизита+" = &"+имяРеквизита+" ";
			Запрос.УстановитьПараметр(имяРеквизита, ключЗначение.Значение);
		КонецЦикла;
	КонецЕсли; 
	Если ЗначениеЗаполнено(структураОтбораТабличнойЧасти) Тогда
		Для каждого ключЗначение Из структураОтбораТабличнойЧасти Цикл
			имяРеквизита = ключЗначение.Ключ;
			Запрос.Текст = Запрос.Текст + " И Доки."+имяРеквизита+" = &"+имяРеквизита+" ";
			Запрос.УстановитьПараметр(имяРеквизита, ключЗначение.Значение);
		КонецЦикла;
	КонецЕсли; 
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат 0;
	КонецЕсли; 
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	Возврат выборка.КоличествоДокументов;
КонецФункции

// Функция - Получить итоговую сумму табличной части документов по отбору
//
// Параметры:
//  видДокумента					 - 	 - 
//  имяТабличнойЧасти				 - 	 - 
//  имяРеквизита					 - 	 - 
//  Дата1							 - 	 - 
//  дата2							 - 	 - 
//  структураОтбораШапки			 - 	 - 
//  структураОтбораТабличнойЧасти	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
Функция ПолучитьИтоговуюСуммуТабличнойЧастиДокументовПоОтбору(видДокумента, имяТабличнойЧасти, имяРеквизита, Дата1, дата2, структураОтбораШапки = Неопределено, структураОтбораТабличнойЧасти = Неопределено) Экспорт
		//ПроверитьЗаполненность(видДокумента, "видДокумента");
		//ПроверитьЗаполненность(Дата1, "Дата1");
		//ПроверитьЗаполненность(Дата2, "Дата2");
	Запрос = Новый Запрос;
	текстТабличнаяЧасть = ?(НЕ ЗначениеЗаполнено(имяТабличнойЧасти), "", "."+имяТабличнойЧасти);
	Запрос.Текст = "ВЫБРАТЬ
	|	ЕСТЬNULL(СУММА(Доки."+имяРеквизита+"), 0) КАК Сумма
	|ИЗ
	|	Документ."+видДокумента+текстТабличнаяЧасть+" КАК Доки
	|ГДЕ
	|	Доки.Ссылка.Дата МЕЖДУ &Дата1 И &Дата2
	|";
	Запрос.УстановитьПараметр("Дата1", Дата1);
	Запрос.УстановитьПараметр("Дата2", КонецДня(Дата2));
	
	Если ЗначениеЗаполнено(структураОтбораШапки) Тогда
		Для каждого ключЗначение Из структураОтбораШапки Цикл
			имяРеквизита = ключЗначение.Ключ;
			Запрос.Текст = Запрос.Текст + " И Доки.Ссылка."+имяРеквизита+" = &"+имяРеквизита+" ";
			Запрос.УстановитьПараметр(имяРеквизита, ключЗначение.Значение);
		КонецЦикла;
	КонецЕсли; 
		//ПроверитьИстину(НЕ (имяТабличнойЧасти = "" И ЗначениеЗаполнено(структураОтбораТабличнойЧасти)), "табличная часть не должна быть указана");
	Если ЗначениеЗаполнено(структураОтбораТабличнойЧасти) Тогда
		Для каждого ключЗначение Из структураОтбораТабличнойЧасти Цикл
			имяРеквизита = ключЗначение.Ключ;
			Запрос.Текст = Запрос.Текст + " И Доки."+имяРеквизита+" = &"+имяРеквизита+" ";
			Запрос.УстановитьПараметр(имяРеквизита, ключЗначение.Значение);
		КонецЦикла;
	КонецЕсли; 
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат 0;
	КонецЕсли; 
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	Возврат выборка.Сумма;
КонецФункции

// Функция - Получить итоговую сумму документов по отбору
//
// Параметры:
//  видДокумента					 - 	 - 
//  имяРеквизита					 - 	 - 
//  Дата1							 - 	 - 
//  дата2							 - 	 - 
//  структураОтбораШапки			 - 	 - 
//  структураОтбораТабличнойЧасти	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
Функция ПолучитьИтоговуюСуммуДокументовПоОтбору(видДокумента, имяРеквизита, Дата1, дата2, структураОтбораШапки = Неопределено, структураОтбораТабличнойЧасти = Неопределено) Экспорт
	Возврат ПолучитьИтоговуюСуммуТабличнойЧастиДокументовПоОтбору(видДокумента, "", имяРеквизита, Дата1, дата2, структураОтбораШапки, структураОтбораТабличнойЧасти);
КонецФункции

// Функция - Получить количество элементов метаданного по отбору
//
// Параметры:
//  типМетаданного	 - 	 - 
//  видМетаданного	 - 	 - 
//  структураОтбора	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
Функция ПолучитьКоличествоЭлементовМетаданногоПоОтбору(типМетаданного, видМетаданного, структураОтбора = Неопределено) Экспорт
		//ПроверитьЗаполненность(типМетаданного, "типМетаданного");
		//ПроверитьЗаполненность(видМетаданного, "видМетаданного");
		
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Таб.Ссылка) КАК КоличествоЭлементов
	|ИЗ
	|	"+типМетаданного+"."+видМетаданного+" КАК Таб
	|ГДЕ
	|	Истина
	|";
	
	Если ЗначениеЗаполнено(структураОтбора) Тогда
		Для каждого ключЗначение Из структураОтбора Цикл
			имяРеквизита = ключЗначение.Ключ;
			Запрос.Текст = Запрос.Текст + " И Таб."+имяРеквизита+" = &"+имяРеквизита+" ";
			Запрос.УстановитьПараметр(имяРеквизита, ключЗначение.Значение);
		КонецЦикла;
	КонецЕсли; 
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат 0;
	КонецЕсли; 
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	Возврат выборка.КоличествоЭлементов;
КонецФункции

// Функция - Получить количество бизнес процессов по отбору
//
// Параметры:
//  видМетаданного	 - 	 - 
//  структураОтбора	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
Функция ПолучитьКоличествоБизнесПроцессовПоОтбору(видМетаданного, структураОтбора = Неопределено) Экспорт
	Возврат ПолучитьКоличествоЭлементовМетаданногоПоОтбору("БизнесПроцесс", видМетаданного, структураОтбора);
КонецФункции

// Функция - Получить количество задач по отбору
//
// Параметры:
//  видМетаданного	 - 	 - 
//  структураОтбора	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
Функция ПолучитьКоличествоЗадачПоОтбору(видМетаданного, структураОтбора = Неопределено) Экспорт
	Возврат ПолучитьКоличествоЭлементовМетаданногоПоОтбору("Задача", видМетаданного, структураОтбора);
КонецФункции

// Функция - Получить количество элементов регистра по отбору
//
// Параметры:
//  типМетаданного	 - 	 - 
//  видМетаданного	 - 	 - 
//  структураОтбора	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
Функция ПолучитьКоличествоЭлементовРегистраПоОтбору(типМетаданного, видМетаданного, структураОтбора = Неопределено) Экспорт
		//ПроверитьЗаполненность(типМетаданного, "типМетаданного");
		//ПроверитьЗаполненность(видМетаданного, "видМетаданного");
		
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	КОЛИЧЕСТВО(*) КАК КоличествоЭлементов
	|ИЗ
	|	"+типМетаданного+"."+видМетаданного+" КАК Таб
	|ГДЕ
	|	Истина
	|";
	
	Если ЗначениеЗаполнено(структураОтбора) Тогда
		Для каждого ключЗначение Из структураОтбора Цикл
			имяРеквизита = ключЗначение.Ключ;
			Запрос.Текст = Запрос.Текст + " И Таб."+имяРеквизита+" = &"+имяРеквизита+" ";
			Запрос.УстановитьПараметр(имяРеквизита, ключЗначение.Значение);
		КонецЦикла;
	КонецЕсли; 
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат 0;
	КонецЕсли; 
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	Возврат выборка.КоличествоЭлементов;
КонецФункции

// Функция - Получить элементы метаданного по отбору
//
// Параметры:
//  типМетаданного	 - 	 - 
//  видМетаданного	 - 	 - 
//  Количество		 - 	 - 
//  структураОтбора	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
Функция ПолучитьЭлементыМетаданногоПоОтбору(типМетаданного, видМетаданного, Количество = 1, структураОтбора = Неопределено) Экспорт
	//ПроверитьЗаполненность(типМетаданного, "типМетаданного");
	//ПроверитьЗаполненность(видМетаданного, "видМетаданного");
		
	Запрос = Новый Запрос;
	ТекстЗапроса = "ВЫБРАТЬ ПЕРВЫЕ %3
	|	*
	|ИЗ
	|	%1.%2 КАК Таб
	|ГДЕ
	|	Истина
	|";

	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "%1", типМетаданного);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "%2", видМетаданного);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "%3", Формат(Количество, "ЧГ=0"));
	Запрос.Текст = ТекстЗапроса;
	Если ЗначениеЗаполнено(структураОтбора) Тогда
		Для каждого ключЗначение Из структураОтбора Цикл
			имяРеквизита = ключЗначение.Ключ;
			Запрос.Текст = Запрос.Текст + " И Таб."+имяРеквизита+" = &"+имяРеквизита+" ";
			Запрос.УстановитьПараметр(имяРеквизита, ключЗначение.Значение);
		КонецЦикла;
	КонецЕсли; 
	
	РезультатЗапроса = Запрос.Выполнить();
	ТЗ = РезультатЗапроса.Выгрузить();
	
	Возврат ТЗ;
КонецФункции

//}

// Функция - удалить элементы по отбору
//
// Параметры:
//  ТипМетаданного	 - Строка	 - Например, "Справочник", "Документ"
//  видМетаданного	 - Строка	 - Например, "Контрагенты"
//  Отбор			 - Структура - 
//
//	ВозвращаемоеЗначение - Число - количество удаленных элементов
//
Функция УдалитьЭлементыМетаданного(Знач ТипМетаданного, Знач ВидМетаданного, Отбор = Неопределено) Экспорт
	ТабЭлементов = ПолучитьЭлементыМетаданногоПоОтбору(ТипМетаданного, ВидМетаданного, 100000, Отбор);
	Результат = ТабЭлементов.Количество();
	Для Каждого Строка Из ТабЭлементов Цикл
		ОбъектЭл = Строка.Ссылка.ПолучитьОбъект();
		ОбъектЭл.Удалить();
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

