Отличная задача, примерный план и код, который поможет её решить. Я разбиna задачу на несколько частей для удобства реализации и тестирования.

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

1.  Перейди в директорию `project_root`.
2.  Запусти `pytest`.

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
