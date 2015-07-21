﻿
#Использовать ".."

Перем юТест;
Перем Лог;

Перем мСообщенияЛога;

Функция ПолучитьСписокТестов(Знач ЮнитТестирование) Экспорт

	юТест = ЮнитТестирование;
	
	МассивТестов = Новый Массив;
	МассивТестов.Добавить("Тест_ДолженСоздатьЛоггерПоУмолчанию");
	МассивТестов.Добавить("Тест_ДолженПроверитьУровниВывода");
	МассивТестов.Добавить("Тест_ДолженПроверитьЧтоЗарегистрированыАппендеры");
	МассивТестов.Добавить("Тест_ДолженПроверитьЧтоУровниВыводаИзменяются");
	МассивТестов.Добавить("Тест_ДолженПроверитьЧтоАппендерУстановлен");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводБолееПриоритетногоСообщения");
	МассивТестов.Добавить("Тест_ДолженПроверитьЧтоНеВыводятсяМенееПриоритетныеСообщения");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводОтладки");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводИнформации");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводПредупреждения");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводОшибки");
	МассивТестов.Добавить("Тест_ДолженПроверитьВыводКритичнойОшибки");
	МассивТестов.Добавить("Тест_ДолженПроверитьСозданиеИдентификатораВЛоге");
	МассивТестов.Добавить("Тест_ДолженПроверитьЗакрытиеЛогаПоСчетчикуСсылок");
	
	Возврат МассивТестов;

КонецФункции

Процедура ПередЗапускомТеста() Экспорт
	Лог = Логирование.ПолучитьЛог("logos.internal");
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	Логирование.ЗакрытьЛог(Лог);
	Лог = Неопределено;
	мСообщенияЛога = Неопределено;
КонецПроцедуры

Процедура Тест_ДолженСоздатьЛоггерПоУмолчанию() Экспорт
	
	юТест.ПроверитьРавенство(УровниЛога.Информация, Лог.Уровень());
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьУровниВывода() Экспорт
	
	юТест.ПроверитьРавенство(0, УровниЛога.Отладка);
	юТест.ПроверитьРавенство(1, УровниЛога.Информация);
	юТест.ПроверитьРавенство(2, УровниЛога.Предупреждение);
	юТест.ПроверитьРавенство(3, УровниЛога.Ошибка);
	юТест.ПроверитьРавенство(4, УровниЛога.КритичнаяОшибка);
	юТест.ПроверитьРавенство(5, УровниЛога.Отключить);
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьЧтоЗарегистрированыАппендеры() Экспорт
	
	// данные типы регистрируются при создании логгера
	ВФайл = Новый ВыводЛогаВФайл();
	юТест.ПроверитьРавенство(Тип("ВыводЛогаВФайл"), ТипЗнч(ВФайл));
	
	Консоль = Новый ВыводЛогаВКонсоль();
	юТест.ПроверитьРавенство(Тип("ВыводЛогаВКонсоль"), ТипЗнч(Консоль));
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьЧтоУровниВыводаИзменяются() Экспорт
	
	юТест.ПроверитьРавенство(УровниЛога.Информация, Лог.Уровень());
	
	Лог.УстановитьУровень(УровниЛога.Предупреждение);
	
	юТест.ПроверитьРавенство(УровниЛога.Предупреждение, Лог.Уровень());
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьЧтоАппендерУстановлен() Экспорт
	ДобавитьСебяКакОбработчикаВывода();
	Лог.Информация("Привет");
	юТест.ПроверитьРавенство("ИНФОРМАЦИЯ - "+"Привет", мСообщенияЛога[0]);
КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводБолееПриоритетногоСообщения() Экспорт
	
	ДобавитьСебяКакОбработчикаВывода();
	Лог.Информация("Привет");
	Лог.Ошибка("Ошибка");
	юТест.ПроверитьРавенство(2, мСообщенияЛога.Количество());
	юТест.ПроверитьРавенство("ИНФОРМАЦИЯ - "+"Привет", мСообщенияЛога[0]);
	юТест.ПроверитьРавенство("ОШИБКА - "+"Ошибка", мСообщенияЛога[1]);
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьЧтоНеВыводятсяМенееПриоритетныеСообщения() Экспорт
	
	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Ошибка);
	Лог.Информация("Привет");
	Лог.Ошибка("Ошибка");
	юТест.ПроверитьРавенство(1, мСообщенияЛога.Количество());
	юТест.ПроверитьРавенство("ОШИБКА - "+"Ошибка", мСообщенияЛога[0]);
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводОтладки() Экспорт
	
	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Отладка);
	Лог.Отладка("Привет");
	юТест.ПроверитьРавенство("ОТЛАДКА - "+"Привет", мСообщенияЛога[0]);
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводИнформации() Экспорт
	
	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Информация);
	Лог.Информация("Привет");
	юТест.ПроверитьРавенство("ИНФОРМАЦИЯ - "+"Привет", мСообщенияЛога[0]);
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводПредупреждения() Экспорт
	
	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Предупреждение);
	Лог.Предупреждение("Привет");
	юТест.ПроверитьРавенство("ПРЕДУПРЕЖДЕНИЕ - "+"Привет", мСообщенияЛога[0]);
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводОшибки() Экспорт
	
	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.Ошибка);
	Лог.Ошибка("Привет");
	юТест.ПроверитьРавенство("ОШИБКА - "+"Привет", мСообщенияЛога[0]);
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьВыводКритичнойОшибки() Экспорт
	
	ДобавитьСебяКакОбработчикаВывода();
	Лог.УстановитьУровень(УровниЛога.КритичнаяОшибка);
	Лог.КритичнаяОшибка("Привет");
	юТест.ПроверитьРавенство("КРИТИЧНАЯОШИБКА - "+"Привет", мСообщенияЛога[0]);
	
КонецПроцедуры

Процедура ДобавитьСебяКакОбработчикаВывода()
	
	мСообщенияЛога = Новый Массив;
	Лог.ДобавитьСпособВывода(ЭтотОбъект);
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьСозданиеИдентификатораВЛоге() Экспорт
	
	ИД = Лог.ПолучитьИдентификатор();
	Сообщить(ИД);
	юТест.Проверить(ЗначениеЗаполнено(ИД));
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьЗакрытиеЛогаПоСчетчикуСсылок() Экспорт
	ДобавитьСебяКакОбработчикаВывода();
	Лог2 = Логирование.ПолучитьЛог("logos.internal");
	Лог2.Информация("ТестовоеСообщение");
	юТест.ПроверитьРавенство(1, мСообщенияЛога.Количество());
	юТест.ПроверитьРавенство(Лог, Лог2);
	Логирование.ЗакрытьЛог(Лог); // закрываем в неправильном порядке, но sink должен остаться открыт
	юТест.ПроверитьРавенство(1, мСообщенияЛога.Количество());
	Логирование.ЗакрытьЛог(Лог2);
	юТест.ПроверитьРавенство(Неопределено, мСообщенияЛога);
КонецПроцедуры

////////////////////////////
// Методы аппендера

Процедура Вывести(Знач Сообщение) Экспорт
	мСообщенияЛога.Добавить(Сообщение);
КонецПроцедуры

Процедура Закрыть() Экспорт
	мСообщенияЛога = Неопределено;
КонецПроцедуры