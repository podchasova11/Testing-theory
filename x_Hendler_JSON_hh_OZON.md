### Вопрос :

Для тестирования хендлера, который отображает последний заказ в личном кабинете в формате JSON, нужно проверить несколько ключевых бизнес-сценариев.

Hendler или Ручка - это один из видов запросов: GET, PUT, POST, DELITE
Поэтому Хендлер, который отображает последний заказ в личном кабинете в формате JSON, это запрос GET, и полученный ответ из Swagger в виде JSON.

Для бизнес-сценария очень важно что для id клиента есть соответствующий ему последний заказ. Проверить id клиента и id последнего заказа. Что этот заказ, последний соответствует этому клиенту.

Мы должны проверить что это действительно последний заказ.

А затем проверить, что совпадает сумма всех заказов "price" и общая сумма заказа "total_amount". Нужно убедиться, что сумма всех товаров, которые находятся внутри заказа, соответствует общей сумме.


Предположим, что структура ответа на запрос последнего заказа выглядит следующим образом (основано на спецификации Swagger):

```json
{
  "order_id": "123456",
  "date": "2024-07-27T12:34:56Z",
  "status": "delivered",
  "items": [
    {
      "item_id": "987654",
      "name": "Product 1",
      "quantity": 2,
      "price": 29.99
    },
    {
      "item_id": "654321",
      "name": "Product 2",
      "quantity": 1,
      "price": 99.99
    }
  ],
  "total_amount": 159.97,
  "delivery_address": {
    "street": "123 Main St",
    "city": "Moscow",
    "postal_code": "101000",
    "country": "Russia"
  },
  "payment_method": "credit_card"
}
```

В этом примере:
- `order_id` — уникальный идентификатор заказа.
- `date` — дата и время заказа в формате ISO 8601.
- `status` — статус заказа (например, "delivered", "pending", "cancelled").
- `items` — список товаров в заказе, каждый из которых содержит `item_id`, `name`, `quantity` и `price`.
- `total_amount` — общая сумма заказа.
- `delivery_address` — адрес доставки, содержащий `street`, `city`, `postal_code` и `country`.
- `payment_method` — метод оплаты (например, "credit_card", "paypal").

## Вариант Ответа :

### Бизнес-сценарии и ответы в формате JSON

#### 1. Корректное отображение последнего заказа

**Сценарий:** У пользователя есть несколько заказов, и хендлер корректно отображает данные последнего заказа в формате JSON.

**Запрос:**
```http
GET /api/orders/last
Authorization: Bearer <valid_token>
```

**Ответ:**
```json
{
  "order_id": "123456",
  "date": "2024-07-27T12:34:56Z",
  "status": "delivered",
  "items": [
    {
      "item_id": "987654",
      "name": "Product 1",
      "quantity": 2,
      "price": 29.99
    },
    {
      "item_id": "654321",
      "name": "Product 2",
      "quantity": 1,
      "price": 99.99
    }
  ],
  "total_amount": 159.97,
  "delivery_address": {
    "street": "123 Main St",
    "city": "Moscow",
    "postal_code": "101000",
    "country": "Russia"
  },
  "payment_method": "credit_card"
}
```

#### 2. Отсутствие заказов у пользователя

**Сценарий:** У пользователя нет ни одного заказа, и хендлер корректно обрабатывает этот случай.

**Запрос:**
```http
GET /api/orders/last
Authorization: Bearer <valid_token>
```

**Ответ:**
```json
{
  "message": "No orders found for the user."
}
```
Или:
```http
204 No Content
```

#### 3. Некорректный или отсутствующий токен аутентификации

**Сценарий:** Запрос выполняется с некорректным или отсутствующим токеном аутентификации.

**Запрос:**
```http
GET /api/orders/last
Authorization: Bearer <invalid_or_missing_token>
```

**Ответ:**
```json
{
  "error": "Unauthorized",
  "message": "Invalid or missing authentication token."
}
```
Или:
```http
401 Unauthorized
```

#### 4. Некорректный формат данных в запросе

**Сценарий:** Запрос содержит некорректные данные, что приводит к ошибке в обработке.

**Запрос:**
```http
POST /api/orders/last
Content-Type: application/json
Authorization: Bearer <valid_token>

{
  "unexpected_field": "unexpected_value"
}
```

**Ответ:**
```json
{
  "error": "Bad Request",
  "message": "Invalid request format."
}
```
Или:
```http
400 Bad Request
```

### Дополнительные сценарии

#### 5. Проверка доступности конечной точки

**Сценарий:** Проверка, что конечная точка доступна и работает.

**Запрос:**
```http
GET /api/orders/last
Authorization: Bearer <valid_token>
```

**Ответ:**
```http
200 OK
```
Или, в случае временной недоступности сервиса:
```json
{
  "error": "Service Unavailable",
  "message": "The service is temporarily unavailable. Please try again later."
}
```
Или:
```http
503 Service Unavailable
```

#### 6. Проверка корректности ответа при различных статусах заказа

**Сценарий:** Проверка, что хендлер корректно обрабатывает и отображает заказы с различными статусами (например, "pending", "cancelled", "shipped").

**Запрос:**
```http
GET /api/orders/last
Authorization: Bearer <valid_token>
```

**Ответ:**
```json
{
  "order_id": "123456",
  "date": "2024-07-27T12:34:56Z",
  "status": "pending",  // или "cancelled", "shipped" и т.д.
  "items": [
    {
      "item_id": "987654",
      "name": "Product 1",
      "quantity": 2,
      "price": 29.99
    },
    {
      "item_id": "654321",
      "name": "Product 2",
      "quantity": 1,
      "price": 99.99
    }
  ],
  "total_amount": 159.97,
  "delivery_address": {
    "street": "123 Main St",
    "city": "Moscow",
    "postal_code": "101000",
    "country": "Russia"
  },
  "payment_method": "credit_card"
}
```

Эти сценарии и примеры ответов в формате JSON помогут убедиться в корректной работе хендлера в различных ситуациях и обеспечат надежное поведение сервиса.

### Доменное имя

— это уникальный адрес, который используется для идентификации ресурса в интернете. Оно позволяет пользователям легко находить веб-сайты, вместо того чтобы запоминать числовые IP-адреса.

**Структура доменного имени:**
1. **Основная часть:** Это название, например, "google" в домене "google.com".
2. **Домен верхнего уровня (TLD):** Это окончание домена, например, ".com", ".ru", ".org" и т.д. TLD может обозначать страну, организацию или тип ресурса.

**Примеры доменных имен:**
- `example.com` 
- `пример.рф`

Доменные имена регистрируются через регистраторов доменных имен, и за их использование часто взимается ежегодная плата.


### 2 ВАРИАНТ ПРОВЕРКИ РУЧКИ НА PYTHON
Давайте создадим простой сервер на Python с использованием Flask и напишем тесты для проверки бизнес-сценариев. Ниже приведен код сервера и тестов.

### 1. Реализация сервера на Flask

```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/api/latest_order', methods=['GET'])
def get_latest_order():
    order = {
        "order_id": "123456",
        "date": "2024-07-27T12:34:56Z",
        "status": "delivered",
        "items": [
            {
                "item_id": "987654",
                "name": "Product 1",
                "quantity": 2,
                "price": 29.99
            },
            {
                "item_id": "654321",
                "name": "Product 2",
                "quantity": 1,
                "price": 99.99
            }
        ],
        "total_amount": 159.97,
        "delivery_address": {
            "street": "123 Main St",
            "city": "Moscow",
            "postal_code": "101000",
            "country": "Russia"
        },
        "payment_method": "credit_card"
    }
    
    return jsonify(order)

if __name__ == '__main__':
    app.run(debug=True)
```

### 2. Написание тестов

Теперь мы напишем тесты для проверки, что API возвращает правильные данные. Используем библиотеку `unittest` для тестирования.

```python
import unittest
from app import app  # Импортируем наше Flask приложение

class TestLatestOrderHandler(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.app = app.test_client()
        cls.app.testing = True

    def test_get_latest_order(self):
        response = self.app.get('/api/latest_order')
        self.assertEqual(response.status_code, 200)
        
        data = response.get_json()
        
        # Проверяем наличие всех ключей в ответе
        self.assertIn('order_id', data)
        self.assertIn('date', data)
        self.assertIn('status', data)
        self.assertIn('items', data)
        self.assertIn('total_amount', data)
        self.assertIn('delivery_address', data)
        self.assertIn('payment_method', data)

        # Проверяем значения
        self.assertEqual(data['order_id'], "123456")
        self.assertEqual(data['status'], "delivered")
        self.assertEqual(data['total_amount'], 159.97)
        self.assertEqual(data['delivery_address']['city'], "Moscow")
        self.assertEqual(data['payment_method'], "credit_card")

    def test_items_in_order(self):
        response = self.app.get('/api/latest_order')
        data = response.get_json()
        
        items = data['items']
        self.assertEqual(len(items), 2)  # Должно быть 2 товара

        # Проверяем первый товар
        self.assertEqual(items[0]['item_id'], "987654")
        self.assertEqual(items[0]['name'], "Product 1")
        self.assertEqual(items[0]['quantity'], 2)
        self.assertEqual(items[0]['price'], 29.99)

        # Проверяем второй товар
        self.assertEqual(items[1]['item_id'], "654321")
        self.assertEqual(items[1]['name'], "Product 2")
        self.assertEqual(items[1]['quantity'], 1)
        self.assertEqual(items[1]['price'], 99.99)

if __name__ == '__main__':
    unittest.main()
```

### Инструкции по запуску:

1. Убедитесь, что у вас установлен Flask. Если нет, установите его с помощью:
   ```bash
   pip install Flask
   ```

2. Сохраните код сервера в файл, например `app.py`.

3. Сохраните тестовый код в файл, например `test_app.py`.

4. Запустите сервер:
   ```bash
   python app.py
   ```

5. В другом терминале запустите тесты:
   ```bash
   python -m unittest test_app.py
   ```

Эти тесты проверят, что API возвращает правильные данные и что структура заказа соответствует ожиданиям. 
