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



# #############################

объясни по шагамкод для босса 

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

