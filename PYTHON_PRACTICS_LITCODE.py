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

################################### 


# VK - Live Coding пример из техсобеса

def max_in_mixed_array(array):
    # return max(array)
    lst = []
    for i in array:
        lst.append(int(i))
    return max(lst)
        
    # print(max(array))

# max_in_mixed_array([1, 2, 3])

assert max_in_mixed_array([1, 2, 3]) == 3
assert max_in_mixed_array(["5", "7"]) == 7
# assert max_in_mixed_array([3, "abc", "-2", "0x57"]) == 3
# assert max_in_mixed_array(["abc", "-2", "0x57"]) == -2
# assert max_in_mixed_array(["abc", "--2", "0x57"]) == None
