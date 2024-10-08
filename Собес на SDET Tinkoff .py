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

Описание:
Calculator включает методы для каждой операции.
В методе _validate_numbers проверяется, что аргументы — числа.
Деление проверяет, что знаменатель не равен нулю.
Unit-тесты проверяют корректность работы всех операций и обработки ошибок.
__________________________________________________________
# Проверка на четность числа
 # Цикл для чисел от 1 до 10 только для четных чисел
for i in range(1, 11):
    if i % 2 == 0:  # Проверка на четность числа
        print(i) 
________________________
suma = [100, 200, 300]
total = sum(suma)
print(total) 
_______________________________________
#получить новй список все значентя которого умножены на 2     

suma = [1, 2, 5, 3, 4]
new_list = [x * 2 for x in suma] # new_list — это просто список, созданный с помощью спискового включения (list comprehension) это компактный способ создания списка
print(new_list)

       # то же самое циклом:
suma = [1, 2, 5, 3, 4]
new_list = []

for x in suma:
    new_list.append(x * 2)

print(new_list)
______________________

 #Дан массив натуральных чисел, найти наибольшее по сумме цифр. 
 # Вывести на экран это число и сумму его цифр [91, 22, 89]

def sum_of_digits(n):
    return sum(int(digit) for digit in str(n))#Эта функция принимает одно целое число n и возвращает сумму его цифр.
#Она преобразует число в строку, перебирает каждую цифру, преобразует её обратно в целое число и суммирует все цифры.

def find_number_with_max_digit_sum(arr):#Эта функция принимает массив arr, состоящий из целых чисел.
    max_sum = 0 #Она инициализирует переменные для хранения максимальной суммы цифр и числа с наибольшей суммой цифр
    number_with_max_sum = None
    
    for num in arr:
        digit_sum = sum_of_digits(num)#Затем она перебирает каждое число в массиве, вычисляет его сумму цифр sum_of_digits(),
        if digit_sum > max_sum:# если текущая сумма цифр больше значения max_sum
            max_sum = digit_sum# #обновляет max_sum 
            number_with_max_sum = num #и запоминает текущее число как number_with_max_sum
    
    return number_with_max_sum, max_sum #В конце функция возвращает число с максимальной суммой цифр и саму максимальную сумму.

# Пример:
arr = [91, 22, 89]
number, digit_sum = find_number_with_max_digit_sum(arr)

print(f"Число с наибольшей суммой цифр: {number}")
print(f"Сумма цифр: {digit_sum}")
    
_______________________________________________________
Декораторы в Python — это функции, которые модифицируют или оборачивают другие функции.
Они позволяют добавлять дополнительное поведение к уже существующим функциям. Вот простой пример декоратора:
def my_decorator(func):  
    def wrapper():  
        print("Что-то делаем до вызова функции.")  
        func()  # Вызов оригинальной функции  
        print("Что-то делаем после вызова функции.")  
    return wrapper  

@my_decorator  # Использование декоратора  
def say_hello():  
    print("Привет!")  

say_hello() 
____________________________________
Что-то делаем до вызова функции.  
Привет!  
Что-то делаем после вызова функции. 
