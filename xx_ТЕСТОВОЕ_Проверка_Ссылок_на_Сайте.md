Разбиna задачу на несколько частей для удобства реализации и тестирования.

**1. Общая структура проекта:**

```
project_root/
├── main.py         # Основной скрипт, запускающий проверки
├── utils.py        # Вспомогательные функции (получение карты сайта, проверка ссылок, canonical)
├── tests/
│   ├── test_main.py  # Pytest тесты
├── requirements.txt # Зависимости
```

**2. Зависимости (requirements.txt):**

```
requests
beautifulsoup4
pytest
```

Установи их: `pip install -r requirements.txt`

**3. utils.py:**

```python
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse

def get_sitemap_links(url):
    """Получает все ссылки из sitemap.xml."""
    try:
        sitemap_url = urljoin(url, 'sitemap.xml')
        response = requests.get(sitemap_url)
        response.raise_for_status()  # Проверка на 200 OK
        soup = BeautifulSoup(response.content, 'xml')
        links = [loc.text for loc in soup.find_all('loc')]
        return links
    except requests.exceptions.RequestException as e:
        print(f"Ошибка при получении sitemap: {e}")
        return []

def get_all_links(url):
    """Получает все ссылки со страницы."""
    try:
        response = requests.get(url)
        response.raise_for_status()
        soup = BeautifulSoup(response.content, 'html.parser')
        links = [urljoin(url, a['href']) for a in soup.find_all('a', href=True)]
        return links
    except requests.exceptions.RequestException as e:
        print(f"Ошибка при получении ссылок со страницы: {e}")
        return []

def check_link_status(url):
    """Проверяет статус код ссылки."""
    try:
        response = requests.head(url, allow_redirects=True, timeout=5)
        return response.status_code
    except requests.exceptions.RequestException:
        return None

def check_canonical(url, page_content):
    """Проверяет rel="canonical" на странице."""
    soup = BeautifulSoup(page_content, 'html.parser')
    canonical_tag = soup.find('link', rel='canonical')
    if canonical_tag:
        return canonical_tag['href']
    return None

def fetch_page_content(url):
    """Получает контент страницы."""
    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.text
    except requests.exceptions.RequestException as e:
        print(f"Ошибка при получении контента страницы: {e}")
        return None

def is_valid_url(url):
    """Проверяет, является ли URL валидным."""
    try:
        result = urlparse(url)
        return all([result.scheme, result.netloc])
    except:
        return False
```

**4. main.py:**

```python
from utils import get_sitemap_links, check_link_status, check_canonical, fetch_page_content, get_all_links, is_valid_url

def main(url):
    """Основная функция для проверки сайта."""
    sitemap_links = get_sitemap_links(url)
    all_links = []

    # Если sitemap недоступен, собираем все ссылки с главной страницы и следующих уровней
    if not sitemap_links:
        print("Sitemap не найден, собираем ссылки с сайта...")
        all_links.append(url)
        collected_links = set()
        for link in all_links:
            if link not in collected_links:
                collected_links.add(link)
                new_links = get_all_links(link)
                for new_link in new_links:
                    if is_valid_url(new_link) and urlparse(new_link).netloc == urlparse(url).netloc:  # Проверяем, что ссылка ведет на тот же домен
                        all_links.append(new_link)
        sitemap_links = list(collected_links)  # Используем собранные ссылки как sitemap_links

    bad_links = []
    canonical_errors = []

    with open("bad_links.txt", "w") as bad_links_file, open("canonical_errors.txt", "w") as canonical_errors_file:
        for link in sitemap_links:
            status_code = check_link_status(link)
            if status_code != 200:
                bad_links.append(f"{link} - {status_code}")
                bad_links_file.write(f"{link} - {status_code}\n")

            page_content = fetch_page_content(link)
            if page_content:
                canonical_url = check_canonical(link, page_content)
                if canonical_url and canonical_url != link:
                    canonical_errors.append(f"{link} - {canonical_url}")
                    canonical_errors_file.write(f"{link} - {canonical_url}\n")

    if bad_links:
        print("Обнаружены нерабочие ссылки:")
        for error in bad_links:
            print(error)
    else:
        print("Все ссылки в порядке (200 OK).")

    if canonical_errors:
        print("Обнаружены ошибки canonical:")
        for error in canonical_errors:
            print(error)
    else:
        print("Canonical URL в порядке.")

    return not (bad_links or canonical_errors)  # Возвращает True, если все проверки пройдены успешно

if __name__ == "__main__":
    target_url = "https://example.com"  # Замени на URL своего сайта
    result = main(target_url)
    if not result:
        exit(1)  # Выход с кодом ошибки, если есть несовпадения
```

**5. tests/test_main.py:**

```python
import pytest
from unittest.mock import patch
from main import main
from utils import is_valid_url

def test_main_success():
    """Тест, когда все проверки проходят успешно."""
    with patch('main.get_sitemap_links', return_value=['https://example.com/']):
        with patch('main.check_link_status', return_value=200):
            with patch('main.fetch_page_content', return_value='<link rel="canonical" href="https://example.com/"/>'):
                result = main("https://example.com")
                assert result == True

def test_main_bad_links():
    """Тест, когда есть нерабочие ссылки."""
    with patch('main.get_sitemap_links', return_value=['https://example.com/']):
        with patch('main.check_link_status', return_value=404):
            with patch('main.fetch_page_content', return_value='<link rel="canonical" href="https://example.com/"/>'):
                result = main("https://example.com")
                assert result == False

def test_main_canonical_errors():
    """Тест, когда есть ошибки canonical."""
    with patch('main.get_sitemap_links', return_value=['https://example.com/']):
        with patch('main.check_link_status', return_value=200):
            with patch('main.fetch_page_content', return_value='<link rel="canonical" href="https://example.com/wrong"/>'):
                result = main("https://example.com")
                assert result == False

def test_is_valid_url():
    """Тест для проверки валидации URL."""
    assert is_valid_url("https://example.com") == True
    assert is_valid_url("invalid-url") == False
```

**Как запускать тесты:**

1.  Перейти в директорию `project_root`.
2.  Запустить `pytest`.

**Пояснения:**

*   **`utils.py`**: Содержит функции для получения ссылок из sitemap или со страниц, проверки статуса кодов и canonical URL.
*   **`main.py`**: Основной скрипт, который использует функции из `utils.py` для проверки сайта и записи результатов в файлы.  Функция `main` возвращает `True`, если все проверки прошли успешно, и `False` в противном случае.  В случае неудачи скрипт завершается с кодом `1`, что позволяет использовать его в CI/CD.
*   **`tests/test_main.py`**: Содержит Pytest тесты для проверки основной логики.  Используются `mock`-и для изоляции тестов и избежания реальных HTTP запросов во время тестирования.
*   Я добавил обработку ситуации, когда `sitemap.xml` отсутствует. В этом случае скрипт будет пытаться собрать ссылки, начиная с главной страницы, и проверять их.
*   Добавлена функция `is_valid_url` для проверки валидности URL.

**Как использовать:**

1.  Замени `"https://example.com"` на URL своего сайта в `main.py`.
2.  Запусти `main.py`.
3.  Проверь файлы `bad_links.txt` и `canonical_errors.txt` на наличие ошибок.
4.  Запусти тесты с помощью `pytest`.

Этот код предоставляет базовую структуру и функциональность. может потребоваться адаптировать его под конкретные нужды твоего сайта.  Например, можно добавить логирование, улучшить обработку ошибок или добавить больше тестов.

_________________________________

добавлео логирование

Реализация с добавленным логированием, а также адаптированный для обработки сайта "vicuna":

**1. Обновлённый `utils.py`:**

```python
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse
import logging

# Настройка логгера
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def get_sitemap_links(url):
    """Получает все ссылки из sitemap.xml."""
    try:
        sitemap_url = urljoin(url, 'sitemap.xml')
        logging.info(f"Попытка получить sitemap по адресу: {sitemap_url}")
        response = requests.get(sitemap_url)
        response.raise_for_status()  # Проверка на 200 OK
        soup = BeautifulSoup(response.content, 'xml')
        links = [loc.text for loc in soup.find_all('loc')]
        logging.info(f"Найдено {len(links)} ссылок в sitemap.")
        return links
    except requests.exceptions.RequestException as e:
        logging.error(f"Ошибка при получении sitemap: {e}")
        return []

def get_all_links(url):
    """Получает все ссылки со страницы."""
    try:
        logging.info(f"Получение ссылок со страницы: {url}")
        response = requests.get(url)
        response.raise_for_status()
        soup = BeautifulSoup(response.content, 'html.parser')
        links = [urljoin(url, a['href']) for a in soup.find_all('a', href=True)]
        logging.info(f"Найдено {len(links)} ссылок на странице: {url}")
        return links
    except requests.exceptions.RequestException as e:
        logging.error(f"Ошибка при получении ссылок со страницы {url}: {e}")
        return []

def check_link_status(url):
    """Проверяет статус код ссылки."""
    try:
        logging.info(f"Проверка статуса ссылки: {url}")
        response = requests.head(url, allow_redirects=True, timeout=5)
        status_code = response.status_code
        logging.info(f"Статус код для {url}: {status_code}")
        return status_code
    except requests.exceptions.RequestException as e:
        logging.error(f"Ошибка при проверке статуса ссылки {url}: {e}")
        return None

def check_canonical(url, page_content):
    """Проверяет rel="canonical" на странице."""
    soup = BeautifulSoup(page_content, 'html.parser')
    canonical_tag = soup.find('link', rel='canonical')
    if canonical_tag:
        canonical_url = canonical_tag['href']
        logging.info(f"Canonical URL для {url}: {canonical_url}")
        return canonical_url
    else:
        logging.warning(f"Canonical URL не найден на странице: {url}")
        return None

def fetch_page_content(url):
    """Получает контент страницы."""
    try:
        logging.info(f"Получение контента страницы: {url}")
        response = requests.get(url)
        response.raise_for_status()
        return response.text
    except requests.exceptions.RequestException as e:
        logging.error(f"Ошибка при получении контента страницы {url}: {e}")
        return None

def is_valid_url(url):
    """Проверяет, является ли URL валидным."""
    try:
        result = urlparse(url)
        return all([result.scheme, result.netloc])
    except:
        return False
```

**2. Обновлённый `main.py`:**

```python
from utils import get_sitemap_links, check_link_status, check_canonical, fetch_page_content, get_all_links, is_valid_url
import logging

# Настройка логгера
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def main(url):
    """Основная функция для проверки сайта."""
    sitemap_links = get_sitemap_links(url)
    all_links = []

    # Если sitemap недоступен, собираем все ссылки с главной страницы и следующих уровней
    if not sitemap_links:
        logging.info("Sitemap не найден, собираем ссылки с сайта...")
        all_links.append(url)
        collected_links = set()
        for link in all_links:
            if link not in collected_links:
                collected_links.add(link)
                new_links = get_all_links(link)
                for new_link in new_links:
                    if is_valid_url(new_link) and urlparse(new_link).netloc == urlparse(url).netloc:  # Проверяем, что ссылка ведет на тот же домен
                        all_links.append(new_link)
        sitemap_links = list(collected_links)  # Используем собранные ссылки как sitemap_links

    bad_links = []
    canonical_errors = []

    with open("bad_links.txt", "w") as bad_links_file, open("canonical_errors.txt", "w") as canonical_errors_file:
        for link in sitemap_links:
            status_code = check_link_status(link)
            if status_code != 200:
                bad_links.append(f"{link} - {status_code}")
                bad_links_file.write(f"{link} - {status_code}\n")
                logging.warning(f"Некорректный статус код для {link}: {status_code}")

            page_content = fetch_page_content(link)
            if page_content:
                canonical_url = check_canonical(link, page_content)
                if canonical_url and canonical_url != link:
                    canonical_errors.append(f"{link} - {canonical_url}")
                    canonical_errors_file.write(f"{link} - {canonical_url}\n")
                    logging.warning(f"Ошибка canonical URL для {link}: {canonical_url}")

    if bad_links:
        logging.error("Обнаружены нерабочие ссылки:")
        for error in bad_links:
            logging.error(error)
    else:
        logging.info("Все ссылки в порядке (200 OK).")

    if canonical_errors:
        logging.error("Обнаружены ошибки canonical:")
        for error in canonical_errors:
            logging.error(error)
    else:
        logging.info("Canonical URL в порядке.")

    return not (bad_links or canonical_errors)  # Возвращает True, если все проверки пройдены успешно

if __name__ == "__main__":
    target_url = "https://vicuna.xyz"  # URL сайта vicuna
    result = main(target_url)
    if not result:
        exit(1)  # Выход с кодом ошибки, если есть несовпадения
```

**Основные изменения:**

*   **`import logging`**: Добавлен модуль `logging`.
*   **`logging.basicConfig`**:  Настроена базовая конфигурация логгера.  `level=logging.INFO` означает, что будут записываться сообщения INFO и выше (WARNING, ERROR, CRITICAL).  `format` определяет формат сообщений лога.
*   **Логирование в функциях**:  В функции `utils.py` добавлены логи для отслеживания процесса:
    *   `logging.info`:  Для общих информационных сообщений.
    *   `logging.warning`:  Для предупреждений (например, если canonical URL не найден).
    *   `logging.error`:  Для ошибок.

**Как использовать:**

1.  Замени `"https://example.com"` на `"https://vicuna.xyz"` в `main.py`.
2.  Убедись, что у тебя установлены все необходимые библиотеки из `requirements.txt`.
3.  Запусти `main.py`.  Логи будут выводиться в консоль.
4.  Проверь файлы `bad_links.txt` и `canonical_errors.txt` на наличие ошибок.

Теперь скрипт будет более информативным благодаря логированию.  Можно отслеживать процесс выполнения и быстрее находить причины ошибок.

__________________________________
 Простыми словами 
 Представь, что у тебя есть карта сокровищ (sitemap) или тебе нужно исследовать местность (страницы сайта), чтобы найти полезную информацию (ссылки).  И ещё тебе нужно убедиться, что все дороги (ссылки) ведут туда, куда нужно, и что указатели (canonical URL) показывают правильный путь.

Фраза "Содержит функции для получения ссылок из sitemap или со страниц, проверки статуса кодов и canonical URL" описывает модуль (обычно это файл, например `utils.py` в нашем случае) как набор инструментов, каждый из которых выполняет определенную задачу, связанную с анализом веб-сайта.  Разберем каждую часть этой фразы по отдельности:

*   **"Содержит функции..."**:  Это значит, что в этом модуле определены несколько функций.  Функция – это как маленький блок кода, который выполняет конкретную задачу.  Ты передаешь ей какие-то данные (например, URL сайта), она их обрабатывает и возвращает результат (например, список ссылок).

*   **"...для получения ссылок из sitemap..."**:  Первая группа функций занимается поиском ссылок на сайте, используя файл `sitemap.xml`. Sitemap – это файл, который лежит на сервере сайта и содержит список всех страниц, которые владелец сайта хочет, чтобы поисковые системы (например, Google) проиндексировали.  Представь, что это оглавление всей книги (сайта). Функция, которая это делает, открывает этот файл, читает его и извлекает оттуда все URL-адреса.  Это быстрый способ получить список всех важных страниц сайта.

*   **"...или со страниц..."**:  Если sitemap отсутствует или нужно найти ссылки, которые не указаны в sitemap, используются другие функции.  Эти функции берут URL страницы, загружают ее содержимое (HTML-код), анализируют этот HTML-код и ищут в нем все теги `<a href="...">`, которые и содержат ссылки.  Это как если бы ты вручную просматривал каждую страницу сайта и записывал все ссылки, которые находишь.  Этот процесс может быть более медленным, чем использование sitemap, но он более надежный, так как позволяет найти все ссылки, даже те, которые не были добавлены в sitemap.

*   **"...проверки статуса кодов..."**:  После того, как мы получили список ссылок, нужно убедиться, что они работают.  Когда ты переходишь по ссылке в браузере, сервер, на котором находится сайт, возвращает тебе так называемый "статус код".  Код `200` означает "ОК, все хорошо, страница существует и доступна". Код `404` означает "Страница не найдена". Код `500` означает "Ошибка на сервере".  Функции для проверки статуса кодов отправляют запросы по каждой ссылке и проверяют, какой статус код возвращает сервер.  Это позволяет выявить "битые" ссылки, которые ведут на несуществующие страницы.

*   **"...и canonical URL"**:  Canonical URL – это способ указать поисковым системам, какая версия страницы является основной, если у одной и той же страницы есть несколько URL-адресов.  Например, страницы `example.com/product` и `example.com/product?color=red` могут отображать один и тот же продукт, но с разными параметрами.  Чтобы поисковая система не считала их разными страницами и не понижала сайт в рейтинге за дублированный контент, на обеих страницах указывается canonical URL, который ведет на основную страницу (например, `example.com/product`).  Функции для работы с canonical URL загружают содержимое каждой страницы и ищут в HTML-коде тег `<link rel="canonical" href="...">`.  Они проверяют, что canonical URL указан правильно и что он ведет на ту же страницу, что и текущий URL.  Это помогает улучшить SEO сайта (Search Engine Optimization).

**В итоге:**

Этот модуль – набор инструментов для анализа структуры и состояния веб-сайта.  Он позволяет:

1.  Найти все страницы сайта (с помощью sitemap или анализа страниц).
2.  Проверить, что все страницы доступны (проверка статуса кодов).
3.  Убедиться, что поисковые системы правильно индексируют страницы (проверка canonical URL).

Такой модуль полезен для SEO-специалистов, веб-мастеров и разработчиков, чтобы выявлять проблемы на сайте и улучшать его видимость в поисковых системах.
_______________________________

BeautifulSoup  можно заменить на пайдентик

Да, `BeautifulSoup` можно заменить на `pydantic`, но важно понимать, что они выполняют разные задачи, и замена не будет прямой.  `BeautifulSoup` – это библиотека для парсинга HTML и XML, то есть для извлечения информации из структурированного текста. `Pydantic` – это библиотека для валидации данных и управления настройками с использованием аннотаций типов Python.

**Почему `BeautifulSoup` используется в данном контексте:**

В коде, который мы рассматривали, `BeautifulSoup` используется для:

1.  **Парсинга HTML**:  Загруженный HTML-код веб-страницы преобразуется в структуру, с которой удобно работать.
2.  **Поиска элементов**:  Ищет определенные теги, такие как `<a href="...">` для извлечения ссылок или `<link rel="canonical" ...>` для извлечения canonical URL.
3.  **Извлечения атрибутов**:  Получает значения атрибутов тегов, например, значение атрибута `href` у тега `<a`.

**Когда `pydantic` может быть полезен:**

`pydantic` может быть полезен в контексте веб-скрейпинга или анализа сайтов в следующих случаях:

1.  **Валидация извлеченных данных**:  После того, как ты извлек данные с помощью `BeautifulSoup` (или другой библиотеки), ты можешь использовать `pydantic` для проверки, что данные соответствуют ожидаемому формату и типу.  Например, ты можешь определить модель данных для товара на сайте и убедиться, что извлеченные данные содержат все необходимые поля (название, цена, описание) и что они имеют правильные типы (строка, число, текст).
2.  **Управление конфигурацией**:  Если твой скрипт имеет различные настройки (например, URL сайта, параметры запросов, пути к файлам), ты можешь использовать `pydantic` для определения структуры конфигурации и валидации значений.

**Как можно использовать `pydantic` вместе с `BeautifulSoup` (пример):**

Предположим, ты хочешь извлечь информацию о товарах с сайта.

```python
from bs4 import BeautifulSoup
from pydantic import BaseModel, HttpUrl, validator
from typing import Optional

class Product(BaseModel):
    name: str
    price: float
    description: str
    image_url: Optional[HttpUrl] = None
    product_url: HttpUrl

    @validator('price')
    def price_must_be_positive(cls, value):
        if value <= 0:
            raise ValueError('Price must be positive')
        return value

def extract_product_data(html: str, product_url: str) -> Product | None:
    """Извлекает данные о товаре из HTML и возвращает объект Product."""
    soup = BeautifulSoup(html, 'html.parser')

    try:
        name = soup.find('h1', class_='product-name').text.strip()
        price_str = soup.find('span', class_='product-price').text.strip().replace('$', '')
        price = float(price_str)
        description = soup.find('div', class_='product-description').text.strip()
        image_tag = soup.find('img', class_='product-image')
        image_url = image_tag['src'] if image_tag else None

        return Product(
            name=name,
            price=price,
            description=description,
            image_url=image_url,
            product_url=product_url
        )
    except Exception as e:
        print(f"Ошибка при извлечении данных: {e}")
        return None

# Пример использования:
html_content = """
<div class="product">
    <h1 class="product-name">Awesome T-Shirt</h1>
    <span class="product-price">$25.00</span>
    <div class="product-description">This is an awesome t-shirt.</div>
    <img class="product-image" src="https://example.com/t-shirt.jpg">
</div>
"""

product = extract_product_data(html_content, "https://example.com/awesome-t-shirt")

if product:
    print(product.model_dump_json(indent=2)) # Вывод в формате JSON
```

**Объяснение:**

1.  **`Product(BaseModel)`**:  Определяется модель данных `Product` с использованием `pydantic`.  Указываются типы данных для каждого поля (name: str, price: float, и т.д.).  `HttpUrl` – это специальный тип от `pydantic`, который проверяет, что строка является валидным URL. `Optional[HttpUrl]` означает, что поле может быть URL или `None`.
2.  **`@validator('price')`**:  Добавляется валидатор для поля `price`, который проверяет, что цена больше нуля.
3.  **`extract_product_data`**:  Эта функция принимает HTML-код и URL товара, использует `BeautifulSoup` для извлечения данных (название, цена, описание, URL изображения), а затем создает экземпляр класса `Product` с использованием извлеченных данных.  `pydantic` автоматически проверяет, что данные соответствуют типам, указанным в модели.  Если данные невалидны, будет выброшено исключение `ValidationError`.
4.  **`product.model_dump_json(indent=2)`**:  Преобразует объект `Product` в JSON-строку с отступами для удобочитаемости.

**Вывод:**

*   `BeautifulSoup` – для парсинга HTML и извлечения данных.
*   `pydantic` – для валидации данных, определения структуры данных и управления настройками.

Ты не можешь просто заменить `BeautifulSoup` на `pydantic` в исходном коде.  Тебе нужно использовать `BeautifulSoup` (или другую библиотеку для парсинга HTML) для извлечения данных, а затем использовать `pydantic` для валидации и структурирования этих данных.  В некоторых случаях, если тебе нужно только проверить, соответствует ли HTML определенной схеме, можно использовать другие библиотеки валидации HTML, но это не прямая замена `BeautifulSoup`.
