
### List comprehension 

трудно перевести правильно на русский, потому, раз он генерирует новый список, будем называть его просто генератором списков. Это одна из самых приятных вещей в python, научившись писать которую, будешь применять её везде. Как это выглядит? Пожалуй Вы точно видели записи такого вида:

squares = [x ** 2 for x in range(10)]
### [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
это и есть генератор списка, результатом которого будет список квадратов последовательности 0..9. Что здесь происходит? Это обычный цикл for, только записан в удобочитаемом виде, в развёрнутом виде это выглядело бы так:

squares = []
for x in range(10):
  squares.append(x ** 2)
### [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
Вот тут и видна разница в этих записях — генератор списка условно можно назвать синтаксическим сахаром для цикла for, но у них разное время выполнения. Под капотом генератор списка также использует цикл for но выигрывает по скорости из-за того, то не вызывает метод append у списка (подробности здесь).

Так же как и в обычных циклах в генераторах можно применять условия:

>>> odds = [x for x in range(10) if x % 2 != 0]
### [1, 3, 5, 7, 9]
если в условии нужен else, то всё условие пишется до for:

>>> [x ** 2 if x % 2 == 0 else x ** 3 for x in range(10)]
### [0, 1, 4, 27, 16, 125, 36, 343, 64, 729]

_List Comprehensions_ are a special kind of syntax that let us create lists out of other lists, [The Python Tutorial](https://docs.python.org/3/tutorial/datastructures.html#list-comprehensions)). They are incredibly useful when dealing with numbers and with one or two levels of nested _for loops_, but beyond that, they can become a little too hard to read.

In this article, we are going to make some _For Loops_ and rewrite them, step by step, into _Comprehensions_.

### Basics

The truth is, _List Comprehensions_ are not too complex, but they are still a bit difficult to understand at first because they look a _little_ weird. Why? Well, the order in which they are written is the **_opposite_** of what we usually see in a _For Loop_.

```python
>>> names = ['Charles', 'Susan', 'Patrick', 'George', 'Carol']
>>> for n in names:
...     print(n)
# Charles
# Susan
# Patrick
# George
# Carol
```

To do the same with a _List Comprehension_, we start at the very end of the _loop_:

```python
>>> names = ['Charles', 'Susan', 'Patrick', 'George', 'Carol']
>>> [print(n) for n in names]
# Charles
# Susan
# Patrick
# George
# Carol
```

Notice how we inverted the order:

- First, we have what the output of the loop will be `[print(n) ...]`.
- Then we define the variable that will store each of the items and point at the `List`, `Set` or `Dictionary` we will work on `[... for n in names]`.

### Creating a new List with a Comprehension

> This is the primary use of a _List Comprehension_. Other usages may result in a hard-to-read code for you and others.

This is how we create a new list from an existing collection with a _For Loop_:

```python
>>> names = ['Charles', 'Susan', 'Patrick', 'George', 'Carol']

>>> new_list = []
>>> for n in names:
...     new_list.append(n)

>>> print(new_list)
# ['Charles', 'Susan', 'Patrick', 'George', 'Carol']
```

And this is how we do the same with a _List Comprehension_:

```python
>>> names = ['Charles', 'Susan', 'Patrick', 'George', 'Carol']
>>> new_list = [n for n in names]
>>> print(new_list)
# ['Charles', 'Susan', 'Patrick', 'George', 'Carol']
```

The reason we can do this is that a _List Comprehension_ standard behavior is to return a list:

```python
>>> names = ['Charles', 'Susan', 'Patrick', 'George', 'Carol']
>>> [n for n in names]
# ['Charles', 'Susan', 'Patrick', 'George', 'Carol']
```

## Adding Conditionals

What if we want `new_list` to have only the names that start with `C`? With a _For Loop_, we would do it like this:

```python
>>> names = ['Charles', 'Susan', 'Patrick', 'George', 'Carol']

>>> new_list = []
>>> for n in names:
...     if n.startswith('C'):
...         new_list.append(n)

>>> print(new_list)
# ['Charles', 'Carol']
```

In a _List Comprehension_, we add the if statement at its end:

```python
>>> names = ['Charles', 'Susan', 'Patrick', 'George', 'Carol']
>>> new_list = [n for n in names if n.startswith('C')]
>>> print(new_list)
# ['Charles', 'Carol']
```

A lot more readable.

### Formatting long List Comprehensions

This time, we want `new_list` to have not only the names that start with a `C` but also those that end with an `e` and contain a `k`:

```python
>>> names = ['Charles', 'Susan', 'Patrick', 'George', 'Carol']
>>> new_list = [n for n in names if n.startswith('C') or n.endswith('e') or 'k' in n]
>>> print(new_list)
# ['Charles', 'Patrick', 'George', 'Carol']
```

That is quite messy. Fortunately, it is possible to break _Comprehensions_ in different lines:

```python
new_list = [
    n
    for n in names
    if n.startswith("C")
    or n.endswith("e")
    or "k" in n
]
```

### Set and Dict Comprehensions

If you learned the basics of _List Comprehensions_... Congratulations! You just did it with <router-link to="/cheatsheet/sets">Sets</router-link> and <router-link to="/cheatsheet/dictionaries">Dictionaries</router-link>.

### Set comprehension

```python
>>> my_set = {"abc", "def"}

>>> # Here, we create a new set with uppercase elements with a for loop
>>> new_set = set()
>>> for s in my_set:
...    new_set.add(s.upper())
>>> print(new_set)
# {'DEF', 'ABC'}

>>> # The same, but with a set comprehension
>>> new_set = {s.upper() for s in my_set}
>>> print(new_set)
# {'DEF', 'ABC'}
```

### Dict comprehension

```python
>>> my_dict = {'name': 'Christine', 'age': 98}

>>> # A new dictionary out of an existing one with a for loop
>>> new_dict = {}
>>> for key, value in my_dict.items():
...     new_dict[key] = value
>>> print(new_dict)
# {'name': 'Christine', 'age': 98}

# Using a dict comprehension
>>> new_dict = {key: value for key, value in my_dict.items()}  # Notice the ":"
>>> print(new_dict)
# {'name': 'Christine', 'age': 98}
```

> Recommended Article: [Python Sets: What, Why and How ](https://www.pythoncheatsheet.org/blog/python-sets-what-why-how).
