
## Что такое Тест план?

Тест план (Test Plan) — это документ, который описывает все аспекты тестирования программного обеспечения для конкретного проекта. Он включает в себя цели, объем, подходы, ресурсы и графики тестирования, а также критерии начала и окончания тестирования.

### Что должен описывать тест план?

Тест план должен описывать:
1. **Цели тестирования**: Что планируется достичь посредством тестирования.
2. **Объем тестирования**: Какие функциональности и аспекты ПО будут тестироваться.
3. **Методологии и подходы**: Используемые стратегии и техники тестирования.
4. **Ресурсы**: Команда, инструменты и оборудование, необходимые для тестирования.
5. **График тестирования**: Даты начала и окончания тестирования, важные вехи и дедлайны.
6. **Критерии приемки**: Критерии начала и окончания тестирования.
7. **Управление рисками**: Потенциальные риски и план их смягчения.
8. **Процедуры отчетности**: Как и кому будут передаваться результаты тестирования.

### Какие вы знаете Виды тест планов?

1. **Мастер-план тестирования**: Общий план для всего проекта.
2. **План системного тестирования**: Описание тестирования системы в целом.
3. **План интеграционного тестирования**: Описание тестирования взаимодействия между компонентами.
4. **План регрессионного тестирования**: Описание тестирования после изменений в ПО.
5. **План приемочного тестирования**: Описание тестирования, проводимого для принятия системы заказчиком.

### Что такое Чек лист?

Чек лист (Check List) — это список задач, критериев или шагов, которые должны быть выполнены или проверены. Он используется для проверки и подтверждения выполнения задач или требований.

### Перечислите возможные атрибуты Чек листа

1. **Название элемента**
2. **Описание задачи**
3. **Критерии выполнения**
4. **Ответственный**
5. **Дата выполнения**
6. **Статус выполнения**

### Перечислите варианты статусов при прохождении Чек листа

1. **Пройдено (Passed)**
2. **Не пройдено (Failed)**
3. **В процессе (In Progress)**
4. **Не применимо (Not Applicable)**
5. **Заблокировано (Blocked)**

### Что такое Тест кейс?

Тест кейс (Test Case) — это документ, описывающий набор условий, шагов и данных, которые необходимы для проведения тестирования определенной функциональности или части ПО.

### Перечислите атрибуты Тест кейса

1. **Идентификатор**
2. **Название**
3. **Описание**
4. **Предусловия**
5. **Шаги выполнения**
6. **Ожидаемый результат**
7. **Фактический результат**
8. **Приоритет**
9. **Автор**
10. **Дата создания**
11. **Статус**

Атрибуты тест-кейса — это характеристики, которые помогают структуировать и организовать информацию о тестах в процессе тестирования программного обеспечения. Ниже приведены основные атрибуты, которые часто используются в тест-кейсах:

1. **Идентификатор тест-кейса (ID)**: Уникальный номер или код для каждого тест-кейса, который позволяет легко его отслеживать.

2. **Название тест-кейса**: Краткое и ясное описание того, что проверяет данный тест.

3. **Описание**: Подробное описание того, что тестируется и какие критерии успеха.

4. **Предусловия**: Условия или требования, которые должны быть выполнены перед запуском теста (например, настройки системы, необходимые данные).

5. **Шаги выполнения**: Пошаговое руководство о том, как выполнять тест. Эти шаги должны быть четкими и легко понятными, чтобы кто угодно мог повторить тест.

6. **Ожидаемый результат**: Описание того, что должно произойти, если тест проходит успешно. Это помогает оценить, был ли тест успешным или нет.

7. **Фактический результат**: Запись того, что на самом деле произошло во время выполнения теста.

8. **Статус**: Указывает, был ли тест пройден, провален или ожидает выполнения. 

9. **Приоритет**: Уровень важности теста (например, высоко, средне, низко), который помогает в организации тестирования.

10. **Тип теста**: Указывает, считается ли тест функциональным, регрессионным, нагрузочным и т. д.

11. **Ответственное лицо**: Имя человека или команды, отвечающей за выполнение теста.

12. **Трекер ошибок (если применимо)**: Ссылка на ошибку в системе отслеживания, если тест выявляет проблему.


 
### Перечислите виды Тест кейсов

1. **Функциональные тест кейсы**
2. **Нефункциональные тест кейсы**
3. **Позитивные тест кейсы**
4. **Негативные тест кейсы**
5. **Регрессионные тест кейсы**
6. **Пользовательские сценарии (User Stories)**

### Что такое Тестовый набор (Test Suite)?

Тестовый набор (Test Suite) — это группа тест кейсов, объединенных для совместного выполнения. Тестовые наборы обычно формируются для определенной функциональности, модуля или этапа тестирования.

### Что такое Баг репорт?

Баг репорт (Bug Report) — это документ, описывающий ошибку или дефект, найденный в программном обеспечении. Он содержит информацию, необходимую для воспроизведения, анализа и исправления ошибки.

### Какое нужно соблюдать правило в баг репорте для хорошего Summary?

Правило: **Краткость и точность**. Summary должен быть кратким и точным, четко описывать суть проблемы. Он должен содержать достаточно информации, чтобы сразу понять, о чем идет речь, без чтения всего отчета.

### Перечислите атрибуты Баг репорта

1. **Идентификатор**
2. **Заголовок (Summary)**
3. **Описание**
4. **Шаги воспроизведения**
5. **Ожидаемый результат**
6. **Фактический результат**
7. **Скриншоты или видео**
8. **Серьезность (Severity)**
9. **Приоритет (Priority)**
10. **Автор**
11. **Дата создания**
12. **Статус**
13. **Среда (Environment)**

Атрибуты баг-репорта — это детали, которые помогают описать обнаруженную ошибку (баг) в программном обеспечении, а также обеспечивают информацию для её воспроизведения и последующего исправления. Вот основные атрибуты, которые обычно включаются в баг-репорт:

1. **Идентификатор бага (ID)**: Уникальный номер или код для отслеживания баг-репорта.

2. **Название/Название проблемы**: Краткое, но информативное описание проблемы.

3. **Описание**: Подробное описание ошибки, включая что произошло, когда это произошло, и почему это является проблемой.

4. **Шаги воспроизведения**: Пошаговое руководство, позволяющее разработчикам и тестировщикам воспроизвести ошибку.

5. **Ожидаемый результат**: Описание того, что должно было произойти, если бы ошибки не было.

6. **Фактический результат**: Что по факту произошло во время тестирования.

7. **Скриншоты/видео**: Визуальные подтверждения ошибки (скриншоты или видео), которые помогают лучше понять проблему.

8. **Территория/среда тестирования**: Информация о среде, в которой была обнаружена ошибка (например, операционная система, браузер, версия приложения).

9. **Приоритет**: Указывает важность ошибки и её влияние на функциональность (например, высокий, средний, низкий).

10. **Статус**: Текущее состояние бага (например, открытый, в работе, исправленный, закрытый).

11. **Ответственное лицо**: Имя или команда, отвечающая за исправление ошибки.

12. **Дата обнаружения**: Дата, когда была найдена ошибка.

13. **Версия продукта**: Версия программного обеспечения, в которой была обнаружена проблема.

14. **Теги или метки**: Дополнительная информация для классификации багов (например, тип бага: критический, несущественный и т. д.).

15. **Ссылки на связанные баги**: Если баг связан с другими, это можно указать для более детального анализа.



### Опишите Жизненный цикл бага

1. **Новый (New)**: Баг только что создан и еще не был рассмотрен.
2. **Назначен (Assigned)**: Баг назначен на разработчика или команду для исправления.
3. **В процессе (In Progress)**: Исправление бага начато.
4. **Исправлено (Fixed)**: Баг исправлен разработчиком.
5. **На проверке (In Testing)**: Баг проверяется тестировщиком.
6. **Закрыт (Closed)**: Баг подтвержден как исправленный или не являющийся ошибкой.
7. **Повторно открыт (Reopened)**: Баг снова открыт, если он не был исправлен.

### Что такое Priority?

Priority (Приоритет) — это параметр, указывающий на важность и срочность исправления бага. Он определяется на основе влияния бага на проект и пользователей.

### Перечислите классификации Priority

1. **Высокий (High)**: Срочное исправление; баг критически влияет на работу системы.
2. **Средний (Medium)**: Важное исправление; баг существенно влияет на функциональность.
3. **Низкий (Low)**: Менее важное исправление; баг имеет минимальное влияние.

### Что такое Severity?

Severity (Серьезность) — это параметр, указывающий на степень влияния бага на функциональность и производительность системы. Он определяется на основе того, насколько серьезно баг нарушает работу системы.

### Перечислите классификации Severity

1. **Критический (Critical)**: Баг полностью останавливает работу системы или вызывает серьезные нарушения.
2. **Высокий (High)**: Баг вызывает значительные проблемы, но система продолжает работать.
3. **Средний (Medium)**: Баг вызывает проблемы средней тяжести.
4. **Низкий (Low)**: Баг вызывает незначительные проблемы или косметические дефекты.

### Приведите пример Низкого Priority и Высокого Severity

Пример: В важной функции системы обнаружен баг, вызывающий крах программы, но эта функция редко используется.

### Приведите пример Низкого Severity и Высокого Priority

Пример: Орфографическая ошибка на главной странице веб-сайта, которая не влияет на функциональность, но критична для имиджа компании.

### Что такое Матрица соответствия требований (Requirements Traceability Matrix)?

Матрица соответствия требований (Requirements Traceability Matrix, RTM) — это документ, который отслеживает и сопоставляет требования с соответствующими тест кейсами. Цель — убедиться, что все требования покрыты тестами.

### Что такое Тест-отчет?

Тест-отчет (Test Report) — это документ, содержащий результаты тестирования. Он описывает, что было протестировано, какие баги были найдены, как они были исправлены, и общую оценку качества системы.

### По времени Тест отчет на сколько типов возможно разделить?

1. **Промежуточный отчет (Interim Report)**
2. **Итоговый отчет (Final Report)**

### Что должен показывать Промежуточный отчет?

Промежуточный отчет должен показывать:
1. **Текущий статус тестирования**
2. **Выполненные тесты и результаты**
3. **Обнаруженные баги и их статус**
4. **Проблемы и риски**
5. **Планы на дальнейшее тестирование**

### Что должен показывать Итоговый отчет?

Итоговый отчет должен показывать:
1. **Общий статус тестирования**
2. **Общее количество тестов и результаты**
3. **Обнаруженные и исправленные баги**
4. **Оценка качества ПО**
5. **Выводы и рекомендации**

___________________________

Северити (severity) и прайорити (priority) — это два важных понятия в области тестирования программного обеспечения, которые помогают в оценке и управлении дефектами и ошибками.

### Северити (Severity)
Северити обозначает уровень серьезности проблемы или дефекта, который был обнаружен в приложении. Это характеристика, определяющая, насколько критично влияние проблемы на функциональность или производительность системы. Примеры уровней серьезности:

- **Блокирующий (Blocking)**: Проблема, из-за которой система не может функционировать вообще.
- **Критический (Critical)**: Ошибка, которая вызывает серьезные сбои в работе приложения, но не блокирует его полностью.
- **Основной (Major)**: Существенная, но не критическая проблема, которая требует исправления.
- **Минорный (Minor)**: Небольшая ошибка, которая не оказывает значительного влияния на функциональность.
- **Тривиальный (Trivial)**: Незначительная проблема, которую можно игнорировать.

### Прайорити (Priority)
Прайорити, в свою очередь, обозначает уровень важности или срочности, с которой дефект должен быть исправлен. Это характеристика, определяющая, когда нужно заниматься исправлением найденной проблемы. Примеры уровней приоритета:

- **Высокий (High)**: Ошибка должна быть исправлена как можно скорее, часто в рамках ближайшего релиза.
- **Средний (Medium)**: Ошибка должна быть исправлена после более критичных проблем, но не слишком откладываться.
- **Низкий (Low)**: Исправление может быть отложено на более поздний срок или может быть рассмотрено в будущих обновлениях.

### Важные отличия
- **Северити** относится к **серьезности** проблемы, а **прайорити** — к **срочности** ее исправления.
- Ошибка с высокой серьезностью не всегда имеет высокий приоритет. Например, критичный дефект может быть обнаружен в системе, которая еще не будет запущена, и его исправление может не требоваться срочно (низкий приоритет).

Понимание различий между северити и прайорити помогает командам тестирования и разработки эффективно управлять дефектами и определять порядок их исправления.

