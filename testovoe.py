# Задание 1:
# Используя Selenium и DevTools, напишите тест, который:
# •	Открывает страницу (сайт можно выбрать самостоятельно);
# •	Использует DevTools для получения консольных ошибок (если таковые имеются);

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
