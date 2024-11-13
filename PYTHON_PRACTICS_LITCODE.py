#977. 
Квадраты отсортированного массива
#Дан массив целых чисел , nums отсортированный в неубывающем порядке.
#Вернуть массив квадратов каждого числа, отсортированный в неубывающем порядке .

Пример :

Ввод: nums = [-4,-1,0,3,10]
 Вывод: [0,1,9,16,100]
 Пояснение: После возведения в квадрат массив становится равным [16,1,0,9,100].
После сортировки получается [0,1,9,16,100].

def sortedSquares(nums):  
    n = len(nums)  
    result = [0] * n  # Создаем массив для результатов  
    left, right = 0, n - 1  # Указатели на начало и конец массива  

    for i in range(n - 1, -1, -1):  # Заполняем результат с конца  
        if abs(nums[left]) > abs(nums[right]):  
            result[i] = nums[left] ** 2  
            left += 1  
        else:  
            result[i] = nums[right] ** 2  
            right -= 1  

    return result  

# Пример использования  
nums = [-4, -1, 0, 3, 10]  
result = sortedSquares(nums)  
print(result)  # Вывод: [0, 1, 9, 16, 100]   