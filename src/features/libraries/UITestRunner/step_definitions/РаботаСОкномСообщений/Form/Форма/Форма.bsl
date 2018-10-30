﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//пример вызова Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВЛогеСообщенийTestClientЕстьСтрока(Парам01)","ВЛогеСообщенийTestClientЕстьСтрока","Когда в логе сообщений TestClient есть строка ""Нужное сообщение пользователю""","Проверяет в логе сообщений наличие нужной строки.","UI.Сообщения пользователю");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВЛогеСообщенийTestClientЕстьСтроки(ТабПарам)","ВЛогеСообщенийTestClientЕстьСтроки","Когда в логе сообщений TestClient есть строки:" + Символы.ПС + "	| 'Сообщение1' |" + Символы.ПС + "	| 'Сообщение2' |","Проверяет в логе сообщений наличие нужной строки.","UI.Сообщения пользователю");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВСообщенияхПользователюНетОдинаковыхСообщений()","ВСообщенияхПользователюНетОдинаковыхСообщений","И в сообщениях пользователю нет одинаковых сообщений","Проверяет, что каждое сообщение пользователю встречается только один раз","UI.Сообщения пользователю");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//Когда в логе сообщений TestClient есть строка "Таблица параметров должна заканчиваться символом |"
//@ВЛогеСообщенийTestClientЕстьСтрока(Парам01)
Процедура ВЛогеСообщенийTestClientЕстьСтрока(Стр) Экспорт
	Нашел = Ложь;
	МассивСообщений = Ванесса.ПолучитьАктивноеОкноИзТестовоеПриложение().ПолучитьТекстыСообщенийПользователю();
	Для каждого Сообщение Из МассивСообщений Цикл
		Если Найти(НРег(Сообщение),НРег(Стр)) > 0 Тогда
			Нашел = Истина;
			Прервать;
		КонецЕсли;	 
	КонецЦикла;
	
	Если Не Нашел Тогда
		ВызватьИсключение "Строка <" + Стр + "> не найдена в окне сообщений пользователю.";
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
//Когда в логе сообщений TestClient есть строки:
//@ВЛогеСообщенийTestClientЕстьСтроки(Парам01)
Процедура ВЛогеСообщенийTestClientЕстьСтроки(ТабПарам) Экспорт
	МассивСообщений = Ванесса.ПолучитьАктивноеОкноИзТестовоеПриложение().ПолучитьТекстыСообщенийПользователю();
	Для Каждого СтрокаТабПарам Из ТабПарам Цикл
		Стр = СтрокаТабПарам.Кол1;
		
		Нашел = Ложь;
		Для каждого Сообщение Из МассивСообщений Цикл
			Если Найти(НРег(Сообщение),НРег(Стр)) > 0 Тогда
				Нашел = Истина;
				Прервать;
			КонецЕсли;	 
		КонецЦикла;	
		
		Если Не Нашел Тогда
			ВызватьИсключение "Строка <" + Стр + "> не найдена в окне сообщений пользователю.";
		КонецЕсли;	 
	КонецЦикла;
	
КонецПроцедуры


&НаСервере
Функция МассивПовторяющихсяСообщений(МассивСообщений)
	
	Массив = Новый Массив;
	
	Тзн = Новый ТаблицаЗначений;
	Тзн.Колонки.Добавить("Стр");
	Тзн.Колонки.Добавить("Количество",Новый ОписаниеТипов("Число"));
	
	Для Каждого Стр Из МассивСообщений Цикл
		СтрТзн            = Тзн.Добавить();
		СтрТзн.Стр        = Стр;
		СтрТзн.Количество = 1;
	КонецЦикла;	
	
	Тзн.Свернуть("Стр","Количество");
	
	Для Каждого СтрТзн Из Тзн Цикл
		Если СтрТзн.Количество > 1 Тогда
			Массив.Добавить(СтрТзн.Стр);
		КонецЕсли;	 
	КонецЦикла;	
	
	Возврат Массив;
КонецФункции	

&НаКлиенте
//И в сообщениях пользователю нет одинаковых сообщений
//@ВСообщенияхПользователюНетОдинаковыхСообщений()
Процедура ВСообщенияхПользователюНетОдинаковыхСообщений() Экспорт
	МассивСообщений = Ванесса.ПолучитьАктивноеОкноИзТестовоеПриложение().ПолучитьТекстыСообщенийПользователю();
	МассивПовторяющихсяСообщений = МассивПовторяющихсяСообщений(МассивСообщений);
	
	Если МассивПовторяющихсяСообщений.Количество() > 0 Тогда
		Стр = "Обнаружены сообщения, которые встречаются больше одного раза:";
		Ном = 0;
		Для Каждого ТекстСообщения Из МассивПовторяющихсяСообщений Цикл
			Ном = Ном + 1;
			Стр = Стр + Символы.ПС + "Сообщение №" + Ном + ": " +  ТекстСообщения; 
		КонецЦикла;	
		ВызватьИсключение Стр;
	КонецЕсли;	 
КонецПроцедуры

//окончание текста модуля