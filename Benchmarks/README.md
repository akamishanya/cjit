# Бенчмарки для тестирования производительности компилированного кода

Основное задание - оптимизировать весь набор бенчмарок как можно лучше.  
Инструкции по запуску для замера производительности см. в [../README.md](../README.md)  

Для оптимизации нужно построить свой пайплайн в оптимизаторе (файл [Optimizer.cpp](../Optimizer/Optimizer.cpp), коммент `/// TODO: Extend pipeline here.`).  
Можно использовать LLVM-ные пассы, можно писать свои.  
При использовании LLVM пасса нужно уметь объяснить, зачем он нужен в конкретном примере (бенчмарке) и что делает вообще.  
Список всех доступных LLVM пассов можно найти в `llvm-project/llvm/lib/Passes/PassRegistry.def`.  

Для выяснения, каких же пассов не хватает в вашем пайплайне, можно подсматривать в то, что делает llvm opt при запуске с O3 - какие пассы запускает и какие изменения они делают в IR-е.  
Подробнее об этом см. в описании `sum-1`.  

Разные бенчмарки направлены на проверку разных оптимизаций, но всё равно есть пересечения. Т.е. при улучшении одной бенчмарки вполне вероятно улучшатся остальные.  
Периодически проверяйте влияние ваших правок на всём наборе.

Выход алгоритмов в бенчмарках проверяется с референсным, поэтому некорректные оптимизации не сработают.  

## Бенчмарки

- `sum-1` - сумма двух массивов. Нужно оптимизировать функцию `sum_1`.  
  Основная оптимизация здесь - векторизация. Однако для того, чтобы она смогла отработать, необходимо упростить цикл.  
  Запустите бенчмарк, распечатайте и посмотрите в начальный IR (CFG) (опция `-dump-ir`).  
  Попробуйте запустить LLVM пайплайн -O3 (пайплайн по умолчанию высокого оптимизационного уровня LLVM) на начальном IR:
  ```sh
  $ llvm/bin/opt -O3 sum-1.ll.init -S > sum-1.opt-O3.ll
  $ cjit/generate-cfgs.sh /path/to/llvm/build/bin/opt sum-1.opt-O3.ll
  ```
  _Note: запускайте именно на .ll.init файле. На sum-1.ll не получится - в нём нет информации о вашем CPU. В init она добавляется автоматически._   
  Другой способ получить IR с O3 - запустить TestRunner c `-O3`:
  ```sh
  $ ./build/TestRunner/test-runner --benchmark=Benchmarks/sum-1 -O3 -dump-ir
  ```
  Откройте CFG `sum_1` - в нём видно, что цикл векторизовался.  
  Распечатайте IR до векторизатора:
  ```sh
  $ llvm/bin/opt -O3 -print-before=loop-vectorize -print-module-scope -filter-print-funcs=sum_1 sum-1.ll.init -disable-output > sum-1.before-vectorize.ll
  ```
  Посмотрите его CFG, сравните его с CFG начального IR.  
  Для векторизации в этом примере можно сократить цикл до одного блока.  
  Попробуйте понять, какие пассы сделали необходимые упрощения в `-O3`.  
  Например, для этого можно распечатать список всех запущенных пассов:
  ```sh
  $ llvm/bin/opt -O3 -debug-pass-manager sum-1.ll.init -disable-output
  ```
  Также можно распечатать IR before/after all passes:
  ```sh
  $ llvm/bin/opt -O3 -print-before-all -print-after-all -filter-print-funcs=sum_1 sum-1.ll.init -disable-output > sum-1.before-after-all.ll
  ```
  В этом логе достаточно много пассов. Hint: в этом примере можно обойтись всего несколькими цикловыми пассами.  
  Добавьте нужные для векторизации цикла пассы в пайплайн.

- `sum-2` - сумма двух массивов, но при каждом доступе к массиву проверяются границы. Нужно оптимизировать функцию `sum_2`.  
  Основная оптимизация здесь также векторизация. Скорее всего, пайплайн из прошлого теста здесь не отработает.  
  Попробуйте понять почему (распечатайте IR до векторизатора, сравните его с IR-ом от `opt -O3`)
  Добавьте необходимые пассы для того, чтобы цикл векторизовался.

- `sum-3` - тоже сумма двух массивов, при каждом доступе к массиву проверяются границы, размеры массивов в разных переменных. Нужно оптимизировать функцию `sum_3`.  
  История та же. Пайплайн, скорее всего, не сработает.  
  LLVM же по-прежнему векторизует цикл.  
  Поймите как он это делает и добавьте нужные пассы.  

- `sum-4` - тоже сумма массивов. Последний тест из этой серии. Проверки границ зачем-то вынесли в отдельную функцию. Нужно оптимизировать функцию `sum_4`.  
  Задание то же самое - добавьте нужные пассы для векторизации цикла.  