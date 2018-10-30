﻿
// { Plugin interface
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("Тип", ВозможныеТипыПлагинов.ГенераторОтчета);
	Результат.Вставить("Идентификатор", Метаданные().Имя);
	Результат.Вставить("Представление", "Отчет о тестировании в формате JUnit.xml");
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
КонецФункции

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
КонецПроцедуры
// } Plugin interface

// { Report generator interface
Функция СоздатьОтчет(КонтекстЯдра, РезультатыТестирования) Экспорт
	ПостроительДереваТестов = КонтекстЯдра.Плагин("ПостроительДереваТестов");
	ЭтотОбъект.ТипыУзловДереваТестов = ПостроительДереваТестов.ТипыУзловДереваТестов;
	ЭтотОбъект.СостоянияТестов = КонтекстЯдра.СостоянияТестов;
	Отчет = СоздатьОтчетНаСервере(РезультатыТестирования);
	
	Возврат Отчет;
КонецФункции

Функция СоздатьОтчетНаСервере(РезультатыТестирования) Экспорт
	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.УстановитьСтроку("UTF-8");
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	
	ЗаписьXML.ЗаписатьНачалоЭлемента("testsuites");
	ЗаписьXML.ЗаписатьАтрибут("name", XMLСтрока(РезультатыТестирования.Имя));
	ЗаписьXML.ЗаписатьАтрибут("time", XMLСтрока(РезультатыТестирования.ВремяВыполнения));
	ЗаписьXML.ЗаписатьАтрибут("tests", XMLСтрока(РезультатыТестирования.КоличествоТестов));
	ЗаписьXML.ЗаписатьАтрибут("failures", XMLСтрока(РезультатыТестирования.КоличествоСломанныхТестов));
	ЗаписьXML.ЗаписатьАтрибут("errors", XMLСтрока(РезультатыТестирования.КоличествоОшибочныхТестов));
	ЗаписьXML.ЗаписатьАтрибут("skipped", XMLСтрока(РезультатыТестирования.КоличествоНеРеализованныхТестов));
	
	ВывестиДанныеОтчетаТестированияРекурсивно(ЗаписьXML, РезультатыТестирования);
	
	ЗаписьXML.ЗаписатьКонецЭлемента();
	
	СтрокаXML = ЗаписьXML.Закрыть();
	Отчет = Новый ТекстовыйДокумент;
	Отчет.ДобавитьСтроку(СтрокаXML);
	
	Возврат Отчет;
КонецФункции

Процедура ВывестиДанныеОтчетаТестированияРекурсивно(ЗаписьXML, РезультатыТестирования, ИмяРодителя = "")
	Если РезультатыТестирования.Тип = ТипыУзловДереваТестов.Контейнер Тогда
		ЗаписьXML.ЗаписатьНачалоЭлемента("testsuite");
		ЗаписьXML.ЗаписатьАтрибут("name", РезультатыТестирования.Имя);
		Для Каждого ЭлементКоллекции Из РезультатыТестирования.Строки Цикл
			ВывестиДанныеОтчетаТестированияРекурсивно(ЗаписьXML, ЭлементКоллекции, РезультатыТестирования.Имя);
		КонецЦикла;
		ЗаписьXML.ЗаписатьКонецЭлемента();
	Иначе
		ВывестиРезультатЭлемента(ЗаписьXML, РезультатыТестирования, ИмяРодителя);
	КонецЕсли;
КонецПроцедуры

Процедура ВывестиРезультатЭлемента(ЗаписьXML, РезультатыТестирования, ИмяРодителя)
	ЗаписьXML.ЗаписатьНачалоЭлемента("testcase");
	ЗаписьXML.ЗаписатьАтрибут("classname", XMLСтрока(ИмяРодителя));
	ЗаписьXML.ЗаписатьАтрибут("name", XMLСтрока(РезультатыТестирования.Представление));
	ЗаписьXML.ЗаписатьАтрибут("time", XMLСтрока(РезультатыТестирования.ВремяВыполнения));
	
	Если РезультатыТестирования.Состояние = СостоянияТестов.Пройден Тогда
		ЗаписьXML.ЗаписатьАтрибут("status", "passed");
	ИначеЕсли РезультатыТестирования.Состояние = СостоянияТестов.НеРеализован Тогда
		СтатусJUnit = "skipped";
		ЗаписьXML.ЗаписатьАтрибут("status", СтатусJUnit);
		ЗаписьXML.ЗаписатьНачалоЭлемента(СтатусJUnit);
		ЗаписьXML.ЗаписатьКонецЭлемента();
	ИначеЕсли РезультатыТестирования.Состояние = СостоянияТестов.Сломан Тогда
		СтатусJUnit = "failure";
		ЗаписьXML.ЗаписатьАтрибут("status", СтатусJUnit);
		ЗаписьXML.ЗаписатьНачалоЭлемента(СтатусJUnit);
		Сообщение = УдалитьНедопустимыеСимволыXML(РезультатыТестирования.Сообщение);
		ЗаписьXML.ЗаписатьАтрибут("message", XMLСтрока(Сообщение));
		ЗаписьXML.ЗаписатьКонецЭлемента();
	ИначеЕсли РезультатыТестирования.Состояние = СостоянияТестов.НеизвестнаяОшибка Тогда
		СтатусJUnit = "error";
		ЗаписьXML.ЗаписатьАтрибут("status", СтатусJUnit);
		ЗаписьXML.ЗаписатьНачалоЭлемента(СтатусJUnit);
		Сообщение = УдалитьНедопустимыеСимволыXML(РезультатыТестирования.Сообщение);
		ЗаписьXML.ЗаписатьАтрибут("message", XMLСтрока(Сообщение));
		ЗаписьXML.ЗаписатьКонецЭлемента();
	КонецЕсли;
	ЗаписьXML.ЗаписатьКонецЭлемента();
КонецПроцедуры

#Если ТолстыйКлиентОбычноеПриложение Тогда
Процедура Показать(Отчет) Экспорт
	Отчет.Показать();
КонецПроцедуры
#КонецЕсли

Процедура Экспортировать(Отчет, ПолныйПутьФайла) Экспорт
	Отчет.Записать(ПолныйПутьФайла);
КонецПроцедуры
// } Report generator interface

// { Helpers
Функция УдалитьНедопустимыеСимволыXML(Знач Результат)
	Позиция = НайтиНедопустимыеСимволыXML(Результат);
	Пока Позиция > 0 Цикл
		Результат = Лев(Результат, Позиция - 1) + Сред(Результат, Позиция + 1);
		Позиция = НайтиНедопустимыеСимволыXML(Результат, Позиция);
	КонецЦикла;
	
	Возврат Результат;
КонецФункции
// } Helpers
