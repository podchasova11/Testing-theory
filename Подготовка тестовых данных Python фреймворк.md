Подготовка тестовых данных — ключевой этап в тестировании Python-приложений. Вот комплексный подход:

## 1. **Изоляция тестовых данных**

### Фикстуры (Fixtures) в Pytest
```python
import pytest
from app.models import User

@pytest.fixture
def sample_user():
    """Создает тестового пользователя"""
    return User(
        id=1,
        username="testuser",
        email="test@example.com"
    )

@pytest.fixture
def auth_client(sample_user):
    """Клиент с аутентификацией"""
    client = TestClient(app)
    client.login_as(sample_user)
    return client
```

## 2. **Фабрики данных (Factory Pattern)**

### Использование Factory Boy
```python
import factory
from factory.alchemy import SQLAlchemyModelFactory
from app.models import User, db

class UserFactory(SQLAlchemyModelFactory):
    class Meta:
        model = User
        sqlalchemy_session = db.session
    
    id = factory.Sequence(lambda n: n)
    username = factory.Faker("user_name")
    email = factory.Faker("email")
    is_active = True

# В тестах
def test_user_creation():
    user = UserFactory()  # Создает случайного пользователя
    admin = UserFactory(is_admin=True)  # Переопределение
```

## 3. **Инициализация БД**

### Фикстуры для БД
```python
@pytest.fixture(scope="session")
def test_db():
    """Создание тестовой БД"""
    engine = create_engine("sqlite:///test.db")
    Base.metadata.create_all(engine)
    yield engine
    Base.metadata.drop_all(engine)
    os.remove("test.db")

@pytest.fixture
def db_session(test_db):
    """Сессия БД с откатом"""
    connection = test_db.connect()
    transaction = connection.begin()
    session = Session(bind=connection)
    
    yield session
    
    session.close()
    transaction.rollback()
    connection.close()
```

## 4. **Моки и стабы**

### Использование unittest.mock
```python
from unittest.mock import Mock, patch, MagicMock

def test_external_api():
    # Мок внешнего API
    mock_response = Mock()
    mock_response.json.return_value = {"status": "ok"}
    mock_response.status_code = 200
    
    with patch("requests.get", return_value=mock_response):
        result = call_external_api()
        assert result["status"] == "ok"
```

## 5. **Параметризованные тесты**

### Параметризация в Pytest
```python
import pytest

@pytest.mark.parametrize("input_data,expected", [
    ({"age": 25}, True),
    ({"age": 17}, False),
    ({"age": None}, False),
    ({}, False)
])
def test_age_validation(input_data, expected):
    result = validate_age(input_data)
    assert result == expected
```

## 6. **Данные из файлов**

### Загрузка из JSON/CSV
```python
import json
import csv
from pathlib import Path

@pytest.fixture
def test_users():
    with open("tests/data/users.json") as f:
        return json.load(f)

@pytest.fixture
def csv_data():
    data = []
    with open("tests/data/test_cases.csv") as f:
        reader = csv.DictReader(f)
        for row in reader:
            data.append(row)
    return data
```

## 7. **Генерация тестовых данных**

### Использование Faker
```python
from faker import Faker

fake = Faker()

@pytest.fixture
def fake_user_data():
    return {
        "name": fake.name(),
        "email": fake.email(),
        "address": fake.address(),
        "phone": fake.phone_number()
    }
```

## 8. **Управление состоянием**

### Очистка после тестов
```python
@pytest.fixture(autouse=True)
def cleanup():
    # Код перед тестом
    yield
    # Код после теста
    clear_test_directory()
    reset_global_state()
```

## 9. **Рекомендации по организации**

### Структура проекта
```
tests/
├── conftest.py           # Общие фикстуры
├── fixtures/             # Файлы с данными
│   ├── users.json
│   └── products.csv
├── factories/            # Фабрики
│   └── user_factory.py
├── unit/                 # Модульные тесты
└── integration/          # Интеграционные тесты
```

### conftest.py с общими фикстурами
```python
import pytest
from app import create_app
from app.db import init_db, clear_db

@pytest.fixture(scope="session")
def app():
    app = create_app(testing=True)
    with app.app_context():
        init_db()
        yield app
        clear_db()

@pytest.fixture
def client(app):
    return app.test_client()
```

## 10. **Лучшие практики**

1. **Идемпотентность**: Каждый тест должен работать независимо
2. **Изоляция**: Данные одного теста не влияют на другие
3. **Читаемость**: Данные должны быть понятными
4. **Поддержка**: Легко добавлять новые тестовые случаи
5. **Производительность**: Минимизация времени подготовки

## Пример полного теста
```python
class TestUserAPI:
    @pytest.fixture(autouse=True)
    def setup(self, db_session, auth_client):
        self.db = db_session
        self.client = auth_client
        self.user_data = UserFactory.build()
    
    def test_create_user(self):
        response = self.client.post(
            "/api/users/",
            json=self.user_data.dict()
        )
        assert response.status_code == 201
        assert self.db.query(User).count() == 1
```

Выбор подхода зависит от типа тестов (unit/integration/e2e) и сложности приложения. Начать с простых фикстур, добавляя фабрики и моки по мере роста проекта.
