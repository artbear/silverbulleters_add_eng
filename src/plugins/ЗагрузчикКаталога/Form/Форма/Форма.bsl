﻿
// { Plugin interface
&НаКлиенте
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Возврат ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов);
КонецФункции

&НаСервере
Функция ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов)
	Возврат ЭтотОбъектНаСервере().ОписаниеПлагина(ВозможныеТипыПлагинов);
КонецФункции

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
КонецПроцедуры

// } Plugin interface

// { Loader interface
&НаКлиенте
Функция ВыбратьПутьИнтерактивно(КонтекстЯдра, ТекущийПуть = "") Экспорт
	
	ДиалогВыбораКаталога = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ДиалогВыбораКаталога.Каталог = ТекущийПуть;
	
	ДиалогВыбораКаталога.Показать(Новый ОписаниеОповещения("ВыбратьПутьИнтерактивноЗавершение", ЭтаФорма, 
		Новый Структура("ДиалогВыбораКаталога, КонтекстЯдра", ДиалогВыбораКаталога, КонтекстЯдра)));
		
КонецФункции

&НаКлиенте
Функция Загрузить(КонтекстЯдра, Путь) Экспорт
	КаталогДляЗагрузки = Новый Файл(Путь);
	Если Не (КаталогДляЗагрузки.Существует() И КаталогДляЗагрузки.ЭтоКаталог()) Тогда
		ВызватьИсключение "Для загрузки передан не каталог файловой системы <" + КаталогДляЗагрузки.ПолноеИмя + ">";
	КонецЕсли;
	ДеревоТестов = ЗагрузитьКаталог(КонтекстЯдра, КаталогДляЗагрузки);
	ДеревоТестов.Имя = КаталогДляЗагрузки.ПолноеИмя;
	
	Возврат ДеревоТестов;
КонецФункции

#Область АсинхронныйAPI

&НаКлиенте
Процедура НачатьЗагрузку(ОбработчикОповещения, КонтекстЯдра, Путь) Экспорт
	
	КаталогДляЗагрузки = Новый Файл(Путь);
	НачатьЗагрузкуКаталога(ОбработчикОповещения, КаталогДляЗагрузки, КонтекстЯдра);
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьЗагрузкуКаталога(Знач ОбработчикОповещения, Знач КаталогДляЗагрузки, Знач КонтекстЯдра) Экспорт
	
	КонтейнерКаталога = КонтекстЯдра.Плагин("ПостроительДереваТестов").СоздатьКонтейнер(КаталогДляЗагрузки.Имя);
	
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("ОбработкаЗавершения", ОбработчикОповещения);
	ДопПараметры.Вставить("КонтейнерКаталога", КонтейнерКаталога);
	ДопПараметры.Вставить("КонтекстЯдра", КонтекстЯдра);
	
	Обработчик = Новый ОписаниеОповещения("ОбработкаПоискаВКорнеКаталога", ЭтаФорма, ДопПараметры);
	НачатьПоискФайлов(Обработчик, КаталогДляЗагрузки.ПолноеИмя, "*", Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаПоискаВКорнеКаталога(Знач НайденныеФайлы, Знач ДополнительныеПараметры) Экспорт
	
	Итератор = Новый Структура;
	Итератор.Вставить("Коллекция", НайденныеФайлы);
	Итератор.Вставить("Индекс", -1);
	
	Контекст = Новый Структура("Итератор, ДополнительныеПараметры", Итератор, ДополнительныеПараметры);
	Контекст.Вставить("Результат", ДополнительныеПараметры.КонтейнерКаталога);
	
	ОбработатьОчереднойФайлНачало(Контекст);
		
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьОбработкуНайденногоФайла(Знач ЭтоКаталог, Знач ВходящийКонтекст) Экспорт
	
	ОбработкаПрерыванияПользователя();
	ДополнительныеПараметры = ВходящийКонтекст.ДополнительныеПараметры;
	Если ЭтоКаталог Тогда
		
		Сообщить( НСтр("ru = 'Загрузка вложенных каталогов в асинхронном режиме не поддерживается. Файлы будут загружены без учета каталогов'") );
		ОбработатьОчереднойФайлНачало(ВходящийКонтекст);
		
	ИначеЕсли НРег(ДополнительныеПараметры.Файл.Расширение) = ".epf"
			ИЛИ НРег(ДополнительныеПараметры.Файл.Расширение) = ".erf" Тогда
			
		Обработчик = Новый ОписаниеОповещения("ОбработчикЗавершенияЗагрузкиФайла", ЭтаФорма, ВходящийКонтекст);	
		КонтекстЯдра = ДополнительныеПараметры.КонтекстЯдра;
		ЗагрузчикФайла = КонтекстЯдра.Плагин("ЗагрузчикФайла");
		ЗагрузчикФайла.НачатьЗагрузку(Обработчик, КонтекстЯдра, ДополнительныеПараметры.Файл.ПолноеИмя);
			
	Иначе
		ОбработатьОчереднойФайлНачало(ВходящийКонтекст);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьОчереднойФайлНачало(Знач ВходящийКонтекст) Экспорт
	
	Итератор = ВходящийКонтекст.Итератор;
	ДополнительныеПараметры = ВходящийКонтекст.ДополнительныеПараметры;
	
	Итератор.Индекс = Итератор.Индекс+1;
	
	Если Итератор.Индекс < Итератор.Коллекция.Количество() Тогда
		
		ТекущийФайл = Итератор.Коллекция[Итератор.Индекс];
		ДополнительныеПараметры.Вставить("Файл", ТекущийФайл);
		Обработчик = Новый ОписаниеОповещения("ЗавершитьОбработкуНайденногоФайла", ЭтаФорма, ВходящийКонтекст);
		ТекущийФайл.НачатьПроверкуЭтоКаталог(Обработчик);
	Иначе
		ВыполнитьОбработкуОповещения(ДополнительныеПараметры.ОбработкаЗавершения, ВходящийКонтекст.Результат);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикЗавершенияЗагрузкиКаталога(Знач ДеревоТестов, Знач ВходящийКонтекст) Экспорт
	
	ОбработатьОчереднойФайлНачало(ВходящийКонтекст);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикЗавершенияЗагрузкиФайла(Знач ДеревоТестовФайла, Знач ВходящийКонтекст) Экспорт
	
	Перем Результат;
	Если ДеревоТестовФайла.Строки.Количество() > 0 Тогда
		Результат = ДеревоТестовФайла.Строки[0];
		ВходящийКонтекст.ДополнительныеПараметры.КонтейнерКаталога.Строки.Добавить(Результат);
	КонецЕсли;
	
	ОбработатьОчереднойФайлНачало(ВходящийКонтекст);
	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Функция ПолучитьКонтекстПоПути(КонтекстЯдра, Путь) Экспорт
	ЗагрузчикФайла = КонтекстЯдра.Плагин("ЗагрузчикФайла");
	Контекст = ЗагрузчикФайла.ПолучитьКонтекстПоПути(КонтекстЯдра, Путь);
	
	Возврат Контекст;
КонецФункции
// } Loader interface

&НаКлиенте
Функция ЗагрузитьКаталог(КонтекстЯдра, КаталогДляЗагрузки)
	КонтейнерКаталога = КонтекстЯдра.Плагин("ПостроительДереваТестов").СоздатьКонтейнер(КаталогДляЗагрузки.Имя);
	НайденныеФайлы = НайтиФайлы(КаталогДляЗагрузки.ПолноеИмя, "*", Ложь);
	Для каждого Файл из НайденныеФайлы Цикл
		ОбработкаПрерыванияПользователя();
		Если Файл.ЭтоКаталог() Тогда
			КонтейнерДочернегоКаталога = ЗагрузитьКаталог(КонтекстЯдра, Файл);
			Если КонтейнерДочернегоКаталога.Строки.Количество() > 0 Тогда
				КонтейнерКаталога.Строки.Добавить(КонтейнерДочернегоКаталога);
			КонецЕсли;
		ИначеЕсли НРег(Файл.Расширение) = ".epf"
			ИЛИ НРег(Файл.Расширение) = ".erf" Тогда
			КонтейнерФайла = ЗагрузитьФайл(КонтекстЯдра, Файл);
			Если ЗначениеЗаполнено(КонтейнерФайла) И КонтейнерФайла.Строки.Количество() > 0 Тогда
				КонтейнерКаталога.Строки.Добавить(КонтейнерФайла);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат КонтейнерКаталога;
КонецФункции

&НаКлиенте
Функция ЗагрузитьФайл(КонтекстЯдра, ФайлОбработки)
	ЗагрузчикФайла = КонтекстЯдра.Плагин("ЗагрузчикФайла");
	Попытка
		ДеревоТестовФайла = ЗагрузчикФайла.Загрузить(КонтекстЯдра, ФайлОбработки.ПолноеИмя);
		Результат = ДеревоТестовФайла;
		Если ДеревоТестовФайла.Строки.Количество() > 0 Тогда
			Результат = ДеревоТестовФайла.Строки[0];
		КонецЕсли;
		
	Исключение
		Сообщить("Не удалось загрузить файл " + ФайлОбработки.ПолноеИмя + Символы.ПС + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		Результат = Неопределено;
	КонецПопытки;
	
	Возврат Результат;
КонецФункции

// { Helpers
&НаСервере
Функция ЭтотОбъектНаСервере()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции
// } Helpers

// { Вспомогательные методы
&НаКлиенте
Процедура ВыбратьПутьИнтерактивноЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДиалогВыбораКаталога = ДополнительныеПараметры.ДиалогВыбораКаталога;
	КонтекстЯдра = ДополнительныеПараметры.КонтекстЯдра;
	
	Если (ВыбранныеФайлы <> Неопределено) Тогда
		Результат = ДиалогВыбораКаталога.Каталог;
	КонецЕсли;
	
	Описание = ОписаниеПлагина(КонтекстЯдра.Объект.ТипыПлагинов);
	Если КонтекстЯдра.ЕстьПоддержкаАсинхронныхВызовов Тогда
		Обр = Новый ОписаниеОповещения("ОкончаниеЗагрузкиТестов", ЭтаФорма);
		КонтекстЯдра.НачатьЗагрузкуТестов(Обр, Описание.Идентификатор, Результат);
	Иначе
		КонтекстЯдра.ЗагрузитьТесты(Описание.Идентификатор, Результат);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОкончаниеЗагрузкиТестов(Результат, Параметры) Экспорт
КонецПроцедуры

// } Вспомогательные методы