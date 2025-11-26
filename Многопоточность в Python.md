Многопоточность в Python — это выполнение нескольких потоков в рамках одного процесса для параллельной обработки задач. Однако из-за GIL (Global Interpreter Lock) настоящая параллельность потоков для CPU-задач невозможна — GIL позволяет работать только одному потоку за раз. Потоки эффективны для I/O-операций (сеть, файлы), где есть ожидание.

Пример:
```
import threading

def worker():
    print("Поток работает")

threads = []
for _ in range(3):
    t = threading.Thread(target=worker)
    threads.append(t)
    t.start()

for t in threads:
    t.join()

```
Для CPU-задач лучше использовать multiprocessing. Потоки же подходят для задач с блокировками (например, HTTP-запросы).
