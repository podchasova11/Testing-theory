### Вопрос :


Для тестирования хендлера, который отображает последний заказ в личном кабинете в формате JSON, нужно проверить несколько ключевых бизнес-сценариев.


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
