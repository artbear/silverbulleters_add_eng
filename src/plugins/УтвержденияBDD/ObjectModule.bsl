﻿Перем СтатусыРезультатаТестирования;
Перем ФлагОтрицанияДляСообщения;

// { Plugin interface
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("Тип", ВозможныеТипыПлагинов.Утилита);
	Результат.Вставить("Идентификатор", Метаданные().Имя);
	Результат.Вставить("Представление", "УтвержденияBDD");
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
КонецФункции

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
КонецПроцедуры
// } Plugin interface

Функция Что(Знач ПроверяемоеЗначение, Знач Сообщение = "") Экспорт
	ЭтотОбъект.ПроверяемоеЗначение = ПроверяемоеЗначение;
	ЭтотОбъект.ДопСообщениеОшибки = Сообщение;
	ЭтотОбъект.ФлагОтрицания = Ложь;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция That(Знач ПроверяемоеЗначение, Знач Сообщение = "") Экспорт	
	Возврат Что( ПроверяемоеЗначение,  Сообщение);
КонецФункции

Функция Не_() Экспорт
	ЭтотОбъект.ФлагОтрицания = Истина;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция Not_() Экспорт
	Возврат Не_();
КонецФункции

Функция ЭтоНе() Экспорт
	Возврат Не_();
КонецФункции

Функция Метод(Знач ИмяМетода, Знач ПараметрыМетода = Неопределено) Экспорт
	ЭтотОбъект.ИмяМетода = ИмяМетода;
	ЭтотОбъект.ПараметрыМетода = ПараметрыМетода;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция Method(Знач ИмяМетода, Знач ПараметрыМетода = Неопределено) Экспорт
	Возврат Метод( ИмяМетода,  ПараметрыМетода ) ;
КонецФункции

Функция ЭтоИстина() Экспорт
	Если Не ЛогическоеВыражениеВерно(ПроверяемоеЗначение = Истина) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(Формат(ПроверяемоеЗначение, "БЛ=Ложь; БИ=Истина"), "является ИСТИНОЙ.");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция ЕстьИстина() Экспорт
	Возврат ЭтоИстина();
КонецФункции

Функция IsTrue() Экспорт
	Возврат ЭтоИстина();
КонецФункции

Функция ЭтоЛожь() Экспорт
	Если Не ЛогическоеВыражениеВерно(ПроверяемоеЗначение = Ложь) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(Формат(ПроверяемоеЗначение, "БЛ=Ложь; БИ=Истина"), "является ЛОЖЬЮ.");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция ЕстьЛожь() Экспорт
	Возврат ЭтоЛожь();
КонецФункции

Функция IsFalse() Экспорт
	Возврат ЭтоЛожь();
КонецФункции

Функция Равно(Знач ОжидаемоеЗначение) Экспорт
	Если Не ЛогическоеВыражениеВерно(ПроверяемоеЗначение = ОжидаемоеЗначение) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(ПроверяемоеЗначение, "РАВНО (" + ОжидаемоеЗначение + ").");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция Equals(Знач ОжидаемоеЗначение) Экспорт
	Возврат Равно(ОжидаемоеЗначение);
КонецФункции

Функция Больше(Знач МеньшееЗначение) Экспорт
	Если Не ЛогическоеВыражениеВерно(ПроверяемоеЗначение > МеньшееЗначение) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(ПроверяемоеЗначение, "БОЛЬШЕ (" + МеньшееЗначение + ").");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция Greater(Знач МеньшееЗначение) Экспорт
	Возврат Больше(МеньшееЗначение);
КонецФункции

Функция БольшеИлиРавно(Знач МеньшееИлиРавноеЗначение) Экспорт
	Если Не ЛогическоеВыражениеВерно(ПроверяемоеЗначение >= МеньшееИлиРавноеЗначение) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(ПроверяемоеЗначение, "БОЛЬШЕ ИЛИ РАВНО (" + МеньшееИлиРавноеЗначение + ").");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция GreaterOrEqual(Знач МеньшееИлиРавноеЗначение) Экспорт
	Возврат БольшеИлиРавно(МеньшееИлиРавноеЗначение);
КонецФункции

Функция Минимум(Знач МинимальноеЗначение) Экспорт
	Возврат БольшеИлиРавно(МинимальноеЗначение);
КонецФункции

Функция Minimum(Знач МинимальноеЗначение) Экспорт
	Возврат БольшеИлиРавно(МинимальноеЗначение);
КонецФункции

Функция МеньшеИлиРавно(Знач БольшееИлиРавноеЗначение) Экспорт
	Если Не ЛогическоеВыражениеВерно(ПроверяемоеЗначение <= БольшееИлиРавноеЗначение) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(ПроверяемоеЗначение, "МЕНЬШЕ ИЛИ РАВНО (" + БольшееИлиРавноеЗначение + ").");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция LessOrEqual(Знач БольшееИлиРавноеЗначение) Экспорт
	Возврат МеньшеИлиРавно(БольшееИлиРавноеЗначение);
КонецФункции

Функция Максимум(Знач МаксимальноеЗначение) Экспорт
	Возврат МеньшеИлиРавно(МаксимальноеЗначение);
КонецФункции

Функция Maximum(Знач МаксимальноеЗначение) Экспорт
	Возврат Максимум(МаксимальноеЗначение);
КонецФункции

Функция Меньше(Знач БольшееЗначение) Экспорт
	Если Не ЛогическоеВыражениеВерно(ПроверяемоеЗначение < БольшееЗначение) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(ПроверяемоеЗначение, "МЕНЬШЕ (" + БольшееЗначение + ").");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция Less(Знач БольшееЗначение) Экспорт
	Возврат Меньше(БольшееЗначение);
КонецФункции

Функция Заполнено() Экспорт
	Если Не ЛогическоеВыражениеВерно(ЗначениеЗаполнено(ПроверяемоеЗначение)) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(ПроверяемоеЗначение, "является ЗАПОЛНЕННЫМ.");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция IsFilled() Экспорт
	Возврат Заполнено();
КонецФункции

Функция Существует() Экспорт
	Если Не ЛогическоеВыражениеВерно(ПроверяемоеЗначение <> Неопределено И ПроверяемоеЗначение <> Null) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(ПроверяемоеЗначение, "СУЩЕСТВУЕТ.");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция Exists() Экспорт
	Возврат Существует();
КонецФункции

Функция ЭтоНеопределено() Экспорт
	Если Не ЛогическоеВыражениеВерно(ПроверяемоеЗначение = Неопределено) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(ПроверяемоеЗначение, "является НЕОПРЕДЕЛЕНО.");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция ЕстьНеопределено() Экспорт
	Возврат ЭтоНеопределено();
КонецФункции

Функция IsUndefined() Экспорт
	Возврат ЭтоНеопределено();
КонецФункции

Функция ЭтоNull() Экспорт
	Если Не ЛогическоеВыражениеВерно(ПроверяемоеЗначение = Null) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(ПроверяемоеЗначение, "является NULL.");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция ЕстьNull() Экспорт
	Возврат ЭтоNull();
КонецФункции

Функция IsNull() Экспорт
	Возврат ЭтоNull();
КонецФункции

Функция ИмеетТип(Знач ТипИлиИмяТипа) Экспорт
	ОжидаемыйТип = ?(ТипЗнч(ТипИлиИмяТипа) = Тип("Строка"), Тип(ТипИлиИмяТипа), ТипИлиИмяТипа);
	ТипПроверяемогоЗначения = ТипЗнч(ПроверяемоеЗначение);
	Если Не ЛогическоеВыражениеВерно(ТипПроверяемогоЗначения = ОжидаемыйТип) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке("тип - " + ТипПроверяемогоЗначения, "имеет тип (" + ОжидаемыйТип + ").");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция HasType( Знач ТипИлиИмяТипа ) Экспорт
	Возврат ИмеетТип(ТипИлиИмяТипа);
КонецФункции

Функция Между(Знач НачальноеЗначение, Знач КонечноеЗначение) Экспорт
	Если Не ЛогическоеВыражениеВерно(ПроверяемоеЗначение >= НачальноеЗначение И ПроверяемоеЗначение <= КонечноеЗначение) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(ПроверяемоеЗначение, "МЕЖДУ (" + НачальноеЗначение + ") и (" + КонечноеЗначение + ").");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция Between( Знач НачальноеЗначение, Знач КонечноеЗначение ) Экспорт
	Возврат Между(НачальноеЗначение, КонечноеЗначение);
КонецФункции

Функция Содержит(Знач ИскомоеЗначение) Экспорт
	Перем ИскомоеЗначениеНайдено;
	
	ТипПроверяемоегоЗначения = ТипЗнч(ПроверяемоеЗначение);
	Если ТипПроверяемоегоЗначения = Тип("Строка") Тогда
		ИскомоеЗначениеНайдено = Найти(ПроверяемоеЗначение, ИскомоеЗначение) > 0;
	ИначеЕсли ТипПроверяемоегоЗначения = Тип("Массив") Или ТипПроверяемоегоЗначения = Тип("ФиксированныйМассив") Тогда
		ИскомоеЗначениеНайдено = ПроверяемоеЗначение.Найти(ИскомоеЗначение) <> Неопределено;
	ИначеЕсли ТипПроверяемоегоЗначения = Тип("Структура") Или ТипПроверяемоегоЗначения = Тип("ФиксированнаяСтруктура")
			Или ТипПроверяемоегоЗначения = Тип("Соответствие") Или ТипПроверяемоегоЗначения = Тип("ФиксированноеСоответствие") Тогда
		Для каждого КлючЗначение Из ПроверяемоеЗначение Цикл
			ИскомоеЗначениеНайдено = КлючЗначение.Значение = ИскомоеЗначение;
			Если ИскомоеЗначениеНайдено Тогда
				Прервать;
			КонецЕсли;
		КонецЦикла;
	ИначеЕсли ТипПроверяемоегоЗначения = Тип("СписокЗначений") Тогда
		ИскомоеЗначениеНайдено = ПроверяемоеЗначение.НайтиПоЗначению(ИскомоеЗначение) <> Неопределено;
	КонецЕсли;
	
	Если ИскомоеЗначениеНайдено = Неопределено Тогда
		СообщениеОшибки = "Утверждение ""Содержит"" не умеет работать с типом <" + ТипПроверяемоегоЗначения + ">." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение СообщениеОшибки;
	КонецЕсли;
	
	Если Не ЛогическоеВыражениеВерно(ИскомоеЗначениеНайдено) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке(ПроверяемоеЗначение, "СОДЕРЖИТ (" + ИскомоеЗначение + ").");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция Contains( Знач ИскомоеЗначение ) Экспорт
	Возврат Содержит(ИскомоеЗначение);
КонецФункции

Функция ИмеетДлину(Знач ОжидаемаяДлина) Экспорт
	Перем ФактическаяДлина;
	
	ТипПроверяемоегоЗначения = ТипЗнч(ПроверяемоеЗначение);
	Если ТипПроверяемоегоЗначения = Тип("Строка") Тогда
		ФактическаяДлина = СтрДлина(ПроверяемоеЗначение);
	ИначеЕсли ТипПроверяемоегоЗначения = Тип("Массив") Или ТипПроверяемоегоЗначения = Тип("ФиксированныйМассив")
			Или ТипПроверяемоегоЗначения = Тип("Структура") Или ТипПроверяемоегоЗначения = Тип("ФиксированнаяСтруктура")
			Или ТипПроверяемоегоЗначения = Тип("Соответствие") Или ТипПроверяемоегоЗначения = Тип("ФиксированноеСоответствие")
			Или ТипПроверяемоегоЗначения = Тип("СписокЗначений") Тогда
		ФактическаяДлина = ПроверяемоеЗначение.Количество();
	КонецЕсли;
	
	Если ФактическаяДлина = Неопределено Тогда
		СообщениеОшибки = "Утверждение ""ИмеетДлину"" не умеет работать с типом <" + ТипПроверяемоегоЗначения + ">." + ФорматДСО(ДопСообщениеОшибки);
		ВызватьИсключение СообщениеОшибки;
	КонецЕсли;
	
	Если Не ЛогическоеВыражениеВерно(ФактическаяДлина = ОжидаемаяДлина) Тогда
		СообщениеОшибки = СформироватьСообщениеОбОшибке("<" +ПроверяемоеЗначение + "> с длиной " + ФактическаяДлина, "ИМЕЕТ ДЛИНУ (" + ОжидаемаяДлина + ").");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

Функция ВыбрасываетИсключение(Знач ФрагментИсключения = "") Экспорт
	Контекст = ПроверяемоеЗначение;
	СтрокаПараметры = "";
	Если ТипЗнч(ПараметрыМетода) = Тип("Массив") Тогда
		Для Сч = 0 По ПараметрыМетода.Количество() - 1 Цикл
			СтрокаПараметры = СтрокаПараметры + ",ПараметрыМетода[" + Сч + "]";
		КонецЦикла;
		СтрокаПараметры = Сред(СтрокаПараметры, 2);
	КонецЕсли;
	СтрокаДляВыполнения = "Контекст." + ИмяМетода + "(" + СтрокаПараметры + ")";
	
	ИсключениеВозникло = Ложь;
	Попытка
		Выполнить(СтрокаДляВыполнения);
	Исключение
		ИсключениеВозникло = Истина;
		ТекстИсключения = ОписаниеОшибки();
	КонецПопытки;
	
	Если Не ЛогическоеВыражениеВерно(ИсключениеВозникло И Найти(ТекстИсключения, ФрагментИсключения) > 0) Тогда
		СообщениеОшибки = "Ожидали, что " + СтрокаДляВыполнения
			+ ?(ФлагОтрицания, " НЕ ", " ")
			+ "ВЫБРОСИТ ИСКЛЮЧЕНИЕ"
			+ ?(ЗначениеЗаполнено(ФрагментИсключения), " СОДЕРЖАЩЕЕ ТЕКСТ <" + ФрагментИсключения + ">, а был текст <" + ТекстИсключения + ">.", "");
		ВызватьОшибкуПроверки(СообщениеОшибки);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
КонецФункции

// { Helpers
Функция ФорматДСО(Знач ДопСообщениеОшибки)
	Если ДопСообщениеОшибки = "" Тогда
		Возврат "";
	КонецЕсли;
	
	Возврат Символы.ПС + ДопСообщениеОшибки;
КонецФункции

Процедура ВызватьОшибкуПроверки(Знач СообщениеОшибки)
	Префикс = "["+ СтатусыРезультатаТестирования.ОшибкаПроверки + "]";
	ВызватьИсключение Префикс + " " + СообщениеОшибки;
КонецПроцедуры

Функция ЛогическоеВыражениеВерно(Знач ЛогическоеВыражение)
	Результат = ФлагОтрицания <> ЛогическоеВыражение;
	ФлагОтрицанияДляСообщения = ФлагОтрицания;
	ФлагОтрицания = Ложь;
	
	Возврат Результат;
КонецФункции

Функция СформироватьСообщениеОбОшибке(Знач ПроверяемоеЗначение, Знач Ожидание)
	Возврат "Ожидали, что проверяемое значение (" + ПроверяемоеЗначение + ")" + ?(ФлагОтрицанияДляСообщения, " НЕ ", " ") + Ожидание + ФорматДСО(ДопСообщениеОшибки);
КонецФункции
// } Helpers

СтатусыРезультатаТестирования = Новый Структура;
СтатусыРезультатаТестирования.Вставить("ОшибкаПроверки", "Failed");
СтатусыРезультатаТестирования.Вставить("НеизвестнаяОшибка", "Broken");
СтатусыРезультатаТестирования.Вставить("ТестПропущен", "Pending");
СтатусыРезультатаТестирования = Новый ФиксированнаяСтруктура(СтатусыРезультатаТестирования);
