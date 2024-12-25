#### Задание 1:
#### Используя Selenium и DevTools, напишите тест, который:
#### Открывает страницу (сайт можно выбрать самостоятельно);
#### Использует DevTools для получения консольных ошибок (если таковые имеются);
```python
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# Настройка опций для Chrome
chrome_options = Options()
# chrome_options.add_argument("--headless")  # Запуск в фоновом режиме
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")

# Создание экземпляра драйвера
driver = webdriver.Chrome(service=Service(), options=chrome_options)

try:
    # Открытие страницы Vikunja
    url = "https://try.vikunja.io"
    driver.get(url)

    # Печать HTML-кода страницы для отладки
    print(driver.page_source)

    # Ожидание, пока элемент будет доступен
    WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.CSS_SELECTOR, 'head > title'))) 
    # Получение логов консоли
    logs = driver.get_log('browser')

    # Вывод консольных ошибок
    errors = [log for log in logs if log['level'] == 'SEVERE']
    if errors:
        print("Консольные ошибки:")
        for error in errors:
            print(f"Время: {error['timestamp']}, Сообщение: {error['message']}")
    else:
        print("Консольные ошибки отсутствуют.")

finally:
    # Закрытие браузера
    driver.quit()

```

# #############################

```python

import pytest
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager


@pytest.fixture()
def browser():
    """Фикстура для настройки WebDriver."""
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))
    yield driver
    driver.quit()


@pytest.fixture(scope="class", params=[
    "podchasova11@yandex.ru"
])
def cur_login(request):
    """Фикстура для логина."""
    return request.param


@pytest.fixture(scope="class", params=[
    "Mila4114"
])
def cur_password(request):
    """Фикстура для пароля."""
    return request.param


@pytest.mark.usefixtures("cur_login", "cur_password")
class TestLoginPage:
    """Класс для тестирования страницы входа."""

    def test_login_redirect_and_input(self, browser, cur_login, cur_password):
        """Проверка перехода на страницу входа и ввода логина и пароля."""
        browser.get("https://preprod-ox7ia7ea.stroycode.ru/")

        # Ожидание загрузки страницы входа
        WebDriverWait(browser, 10).until(EC.presence_of_element_located((By.XPATH, "//*[@id='cookie-notice']/div/button")))

        # Принять куки, если возникает такое окно
        try:
            accept_cookies_button = WebDriverWait(browser, 5).until(
                EC.element_to_be_clickable((By.XPATH, "//*[@id='cookie-notice']/div/button")))
            accept_cookies_button.click()
        except Exception as e:
            print("Кнопка принятия куки не найдена или не доступна:", e)

        # Переход на страницу регистрации
        next_page_button = WebDriverWait(browser, 10).until(
            EC.element_to_be_clickable((By.XPATH, "//*[@id='registration']/div/div[2]/div[3]/a")))
        next_page_button.click()

        # Ввод логина и пароля
        email_input = WebDriverWait(browser, 20).until(
            EC.presence_of_element_located((By.XPATH, "//*[@id='authorization_section']/div/div/div[3]/form/div[1]/div/div/div[2]/div/input")))
        password_input = WebDriverWait(browser, 20).until(
            EC.presence_of_element_located((By.XPATH, "//*[@id='authorization_section']/div/div/div[3]/form/div[2]/div[1]/div/div/div[2]/div/input")))

        email_input.send_keys(cur_login)  # Ввод логина
        password_input.send_keys(cur_password)  # Ввод пароля

        # Клик на кнопку "Авторизоваться"
        submit_button = browser.find_element(By.XPATH, '//*[@id="authorization_section"]/div/div/div[3]/form/button')
        submit_button.click()

        time.sleep(10)

        # # Проверка, произошел ли вход на страницу авторизации
        # WebDriverWait(browser, 10).until(EC.url_contains("verify-email"))
        # assert "verify-email" in browser.current_url, "Не удалось войти: текущий URL не содержит 'verify-email'"


if __name__ == "__main__":
    pytest.main()
```
Можно разобрать код по шагам, чтобы объяснить, как он работает. Код автоматизирует тестирование страницы Авторизации/Регистрации с использованием библиотеки Selenium и фреймворка тестирования Pytest.

### Шаг 1: Импорт библиотек

```python
import pytest
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager
```
- Импортируем:
- **selenium:** Библиотека для автоматизации браузеров.
- **webdriver:** Интерфейс для работы с веб-драйверами.
- **Service:** Позволяет запускать драйвер Chrome.
- **WebDriverWait:** Явные ожидания. Используются для ожидания каких-то условий (например, появления элемента на странице).
- **ChromeDriverManager:** Упрощает установку и управление драйвером Chrome.

### Шаг 2: Определение фикстуры для браузера

```python
@pytest.fixture()
def browser():
    """Фикстура для настройки WebDriver."""
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))
    yield driver
    driver.quit()
```

- **Фикстура**, в нашем случае прописана как метод или функция **`def browser`:**
- Создает экземпляр веб-драйвера Chrome, который будет использоваться в тестах. После завершения тестов драйвер закрывается с помощью `driver.quit()`.

### Шаг 3: Определение фикстур для логина и пароля

```python
@pytest.fixture(scope="class", params=[
    "podchasova11@yandex.ru"
])
def cur_login(request):
    """Фикстура для логина."""
    return request.param


@pytest.fixture(scope="class", params=[
    "Mila4114"
])
def cur_password(request):
    """Фикстура для пароля."""
    return request.param
```

- **Фикстуры `cur_login` и `cur_password`:** Определяют параметры для логина и пароля, которые будут использоваться в тестах. В данном случае используется один логин и один пароль. Но мы можем подставить множество позитивных и негативных проверок логин/пароль в качестве параметров в этот тест.

### Шаг 4: Определение класса тестов

```python
@pytest.mark.usefixtures("cur_login", "cur_password")
class TestLoginPage:
    """Класс для тестирования страницы входа."""
```

- **Класс `TestLoginPage`:** Содержит тесты для проверки функциональности страницы входа. Декоратор `@pytest.mark.usefixtures` указывает, что фикстуры `cur_login` и `cur_password` будут использоваться в этом классе.

### Шаг 5: Определение теста

```python
def test_login_redirect_and_input(self, browser, cur_login, cur_password):
    """Проверка перехода на страницу входа и ввода логина и пароля."""
    browser.get("https://preprod-ox7ia7ea.stroycode.ru/")
```

- **Метод `test_login_redirect_and_input`:** Основной тест, который выполняет проверку. Он принимает параметры `browser`, `cur_login` и `cur_password`.

### Шаг 6: Ожидание загрузки страницы и принятие куки

```python
# Ожидание загрузки страницы входа
WebDriverWait(browser, 10).until(EC.presence_of_element_located((By.XPATH, "//*[@id='cookie-notice']/div/button")))

# Принять куки, если возникает такое окно
try:
    accept_cookies_button = WebDriverWait(browser, 5).until(
        EC.element_to_be_clickable((By.XPATH, "//*[@id='cookie-notice']/div/button")))
    accept_cookies_button.click()
except Exception as e:
    print("Кнопка принятия куки не найдена или не доступна:", e)
```

- **Ожидание:** Используется `WebDriverWait` для ожидания появления кнопки принятия куки на странице.
- **Принятие куки:** Если кнопка доступна, она нажимается. Если кнопка не найдена, выводится сообщение об ошибке.

### Шаг 7: Переход на страницу авторизации и ввод данных

```python
# Переход на страницу регистрации
next_page_button = WebDriverWait(browser, 10).until(
    EC.element_to_be_clickable((By.XPATH, "//*[@id='registration']/div/div[2]/div[3]/a")))
next_page_button.click()

# Ввод логина и пароля
email_input = WebDriverWait(browser, 20).until(
    EC.presence_of_element_located((By.XPATH, "//*[@id='authorization_section']/div/div/div[3]/form/div[1]/div/div/div[2]/div/input")))
password_input = WebDriverWait(browser, 20).until(
    EC.presence_of_element_located((By.XPATH, "//*[@id='authorization_section']/div/div/div[3]/form/div[2]/div[1]/div/div/div[2]/div/input")))

email_input.send_keys(cur_login)  # Ввод логина
password_input.send_keys(cur_password)  # Ввод пароля
```

- **Переход на страницу регистрации:** Ожидается, пока кнопка для перехода на страницу регистрации станет кликабельной, и затем происходит клик.
- **Ввод данных:** Ожидается, пока поля для ввода логина и пароля станут доступными, после чего в них вводятся соответствующие значения.

### Шаг 8: Клик на кнопку авторизации и ожидание

```python
# Клик на кнопку "Авторизоваться"
submit_button = browser.find_element(By.XPATH, '//*[@id="authorization_section"]/div/div/div[3]/form/button')
submit_button.click()

time.sleep(10)
```

- **Клик на кнопку авторизации:** Находится кнопка для входа и происходит клик по ней.
- **Ожидание:** Используется `time.sleep(10)` для ожидания (это не рекомендуется, лучше использовать явные ожидания).

### Шаг 9: Проверка успешного входа (закомментировано)

```python
# Проверка, произошел ли вход на страницу авторизации
# WebDriverWait(browser, 10).until(EC.url_contains("verify-email"))
# assert "verify-email" in browser.current_url, "Не удалось войти: текущий URL не содержит 'verify-email'"
```

- **Проверка успешного входа:** Эти строки закомментированы, но они предназначены для проверки, что после входа в систему URL содержит "verify-email", что указывает на успешный вход.

### Шаг 10: Запуск тестов

```python
if __name__ == "__main__":
    pytest.main()
```

- **Запуск тестов:** Если скрипт выполняется как основной модуль, запускаются тесты с помощью `pytest`.

### Заключение

Этот код представляет собой тест для автоматизации процесса входа на веб-сайт с использованием Selenium и Pytest. Он включает в себя этапы инициализации браузера, ожидания элементов, ввода данных, а также проверки успешного выполнения входа. Вы можете улучшить тест, добавив проверки и удалив ненужные задержки. Если у вас есть дополнительные вопросы или нужно объяснить что-то конкретное, дайте знать!
