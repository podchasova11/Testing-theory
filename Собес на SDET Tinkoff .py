#Задачи: 
#1) Дан массив A, заполненный числами от 0 до n - 1 (числа вразброс). Дубликатов нет, 
#и есть одно потерянное значение. Надо его найти. // const array = [3, 6, 1, 4, 2, 5, 7, 8, 10, 11] !!! - ЗДЕСЬ НЕТ ЗНАЧЕНИЯ "0"

#Для того чтобы найти потерянное число в массиве от 0 до n - 1, можно использовать математическое 
#свойство суммы арифметической прогрессии. Сумма всех чисел от 0 до n - 1 вычисляется по формуле:
#сложить первое и последнее числа, разделитьих на два и умножить на N (количество чисел)

#𝑆=((A_1 + A_n)/2)×N
 
#Мы можем найти сумму всех элементов массива и вычесть её из суммы прогрессии, чтобы получить потерянное число.

def find_missing_number(arr):
    n = len(arr) + 1  # Длина должна быть на 1 больше из-за потерянного числа
    total_sum = n * (n - 1) // 2  # Сумма чисел от 0 до n-1
    actual_sum = sum(arr)  # Сумма элементов в массиве
    return total_sum - actual_sum  # Потерянное число

# Пример
array = [0, 3, 6, 1, 4, 2, 5, 7, 8, 10, 11] # добавили значение "0"
missing_number = find_missing_number(array)
print(f"Потерянное число: {missing_number}") # это число 9
#______________________________________________________________________________________________________________________



# 2) 
# Дан интерфейс калькулятора с простейшими арифметическими операциями - сложение, вычитание, умножение, деление.
# Выберите типы аргументов и результата операций, напишите реализацию интерфейса и покройте его unit-тестами.
# (p.s сразу подумать о проверке типа аргументов и чтобы не пропускал 0 в операцию деления в знаменатель)

# Для реализации калькулятора с простейшими арифметическими операциями мы выберем
# типы аргументов и результата как float для работы с числами с плавающей запятой. 

# Реализация интерфейса будет включать следующие операции:

#- Сложение
#- Вычитание
#- Умножение
#- Деление (с проверкой на деление на ноль)
# Добавим проверку типа аргументов, чтобы операции могли выполняться только над числами, и если деление на 0 обнаружится, выбросим исключение.

# Вот пример реализации: 

class Calculator:
    @staticmethod
    def add(a: float, b: float) -> float: #Аннотация результата float
        Calculator._validate_numbers(a, b)
        return a + b

    @staticmethod
    def subtract(a: float, b: float) -> float:
        Calculator._validate_numbers(a, b)
        return a - b

    @staticmethod
    def multiply(a: float, b: float) -> float:
        Calculator._validate_numbers(a, b)
        return a * b

    @staticmethod
    def divide(a: float, b: float) -> float:
        Calculator._validate_numbers(a, b)
        if b == 0:
            raise ValueError("Деление на ноль запрещено!")
        return a / b

    @staticmethod
    def _validate_numbers(a, b):
        if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
            raise TypeError("Операции поддерживают только числовые значения!")

#____________________________________________________________________________________________________
#Unit-тесты
#Далее напишем unit-тесты для проверки всех операций:

import unittest


class TestCalculator(unittest.TestCase):
    def test_add(self):
        self.assertEqual(Calculator.add(2, 3), 5)
        self.assertEqual(Calculator.add(-2, 3), 1)
        self.assertEqual(Calculator.add(0, 0), 0)
        self.assertEqual(Calculator.add(2.5, 3.5), 6.0)

    def test_subtract(self):
        self.assertEqual(Calculator.subtract(5, 3), 2)
        self.assertEqual(Calculator.subtract(2, 3), -1)
        self.assertEqual(Calculator.subtract(0, 0), 0)
        self.assertEqual(Calculator.subtract(5.5, 1.5), 4.0)

    def test_multiply(self):
        self.assertEqual(Calculator.multiply(5, 3), 15)
        self.assertEqual(Calculator.multiply(-5, 3), -15)
        self.assertEqual(Calculator.multiply(0, 5), 0)
        self.assertEqual(Calculator.multiply(2.5, 4), 10.0)

    def test_divide(self):
        self.assertEqual(Calculator.divide(6, 3), 2)
        self.assertEqual(Calculator.divide(5, 2), 2.5)
        self.assertEqual(Calculator.divide(-6, 3), -2)
        self.assertRaises(ValueError, Calculator.divide, 5, 0)

    def test_invalid_arguments(self):
        self.assertRaises(TypeError, Calculator.add, "2", 3)
        self.assertRaises(TypeError, Calculator.subtract, 2, "3")
        self.assertRaises(TypeError, Calculator.multiply, "a", "b")
        self.assertRaises(TypeError, Calculator.divide, 5, "0")

if __name__ == '__main__':
    unittest.main()

