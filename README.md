## JIT для C/C++

LLVM-based JIT для C/C++.  

В папке `./TestRunner` - программа для запуска бенчмарок.  
Она читает поданные ей исходники бенчмарки в формате LLVM IR, парсит их, оптимизирует и исполняет.  
Во время исполнения замеряет, сколько раз выполнился скомпилированный код и выводит отчёт:

```txt
$ ./build/TestRunner/test-runner --benchmarks-dir=Benchmarks/
Found benchmark sink.ll in Benchmarks/sink
Preparing to run benchmark 'sink'...
Optimizing 'sink'...
Running 'sink':
Iteration #1:          1289.0 ops/s
Iteration #2:          1289.0 ops/s
Iteration #3:          1289.0 ops/s
Iteration #4:          1288.0 ops/s
Iteration #5:          1288.0 ops/s
Iteration #6:          1288.0 ops/s
Iteration #7:          1289.0 ops/s
Iteration #8:          1289.0 ops/s
Iteration #9:          1288.0 ops/s
Iteration #10:         1288.0 ops/s
Average score:         1288.5 ops/s
```
Исполнение происходит в том же процессе `test-runner` с помощью механизма LLJIT из LLVM.

В `./Optimizer` - оптимизатор LLVM IR. Эту часть нужно будет дополнять в ходе практики.  
Точка входа - метод `Optimizer::optimizeIR` из [Optimizer/Optimizer.cpp](Optimizer/Optimizer.cpp).  

В папке `Benchmarks` лежат бенчмарки на C.  
Каждый бенчмарк в своей папке. В каждом бенчмарке два файла - `<bench_name>.c` и `<bench_name>.ll`.

`<bench_name>.ll` - представление в виде LLVM IR кода из `<bench_name>.c`.  
Этот файл получается с помощью clang-a:
```sh
clang -S -emit-llvm -O0 -Xclang -disable-O0-optnone sink.c
```

### Задание 1. Приручаем дракона

1. Постройте LLVM и TestRunner.  
   Инструкция по построению - [BUILD.md](BUILD.md)

2. Запустите TestRunner на одном бенчмарке [sink](Benchmarks/sink):
    ```sh
    $ ./build/TestRunner/test-runner --benchmark=Benchmarks/sink
    ```
    В результате должен получиться выхлоп как выше ^^.

3. Прочитайте исходник бенчмарка, попробуйте сопоставить код на C и LLVM IR (`sink.c` и `sink.ll` файлы).  
   Найдите в IR цикл, аккумулятор цикла. Проследите, как ему присваиваются значения.

4. Постройте Control Flow Graph для этого теста:
    ```sh
    $ cd Benchmarks/sink
    $ /path/to/llvm-project/build/bin/opt -passes=dot-cfg sink.ll
    ```
    Должен появиться файл .test.dot. Из него можно сгенерировать SVG:
    ```sh
    $ dot -Tsvg .test.dot > sink.svg
    ```
    (Программа `dot` во многих дистрибутивах идёт в пакете `graphviz`)  
    Откройте SVG в браузере - перед вами CFG функции test.  
    Поймите, чему соответствуют цвета блоков и почему они разные.

5. Добавьте оптимизационных пассов в пайплайн:
    Найдите в [Optimizer/Optimizer.cpp](Optimizer/Optimizer.cpp) построение пайплайна (`ModulePassManager MPM`).  
    Добавьте `SinkingPass` пасс в пайплайн:
    ```cpp
    /// TODO: Extend pipeline here.
    ModulePassManager MPM;
    MPM.addPass(VerifierPass());

    {
        FunctionPassManager FPM;
        FPM.addPass(SROAPass(SROAOptions::ModifyCFG));
        FPM.addPass(SinkingPass()); // NOTE: Added this line
        MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
    }
    ```

    Постройте TestRunner (`cd build && ninja`), запустите и отследите изменения результатов:
    ```
    $ ./build/TestRunner/test-runner --benchmark=Benchmarks/sink
    Found benchmark sink.ll in Benchmarks/sink
    Preparing to run benchmark 'sink'...
    Optimizing 'sink'...
    Running 'sink':
    Iteration #1:         88086.0 ops/s
    ```

    Запустите test-runner ещё раз с опцией `-dump-ir`:
    ```sh
    $ ./build/TestRunner/test-runner --benchmark=Benchmarks/sink -dump-ir
    ```

    Рядом с `sink.ll` появятся `sink.ll.init` и `sink.ll.opt` файлы - это снепшоты IR-а до и после *всех ваших* оптимизаций.  
    Постройте и сравните CFG для обоих файлов.  
    Объясните, что сделал SinkingPass и почему от него наблюдается такой большой прирост.  
 
    В начале пайплайна стоит пасс SROA.  
    Он должен стоять в начале пайплайна из-за особенностей парсинга C/C++ clang-ом.  

    `sink.ll.init` - IR до работы SROA.  
    Чтобы увидеть только изменения от SinkingPass, распечатайте IR непосредственно до и после него:
    ```sh
    $ ./build/TestRunner/test-runner --benchmark=Benchmarks/sink -print-before='sink' -print-module-scope 2> before-sink.ll
    $ ./build/TestRunner/test-runner --benchmark=Benchmarks/sink -print-after='sink' -print-module-scope 2> after-sink.ll
    ```

    `'sink'` - название пасса. Посмотреть список всех пассов вместе с названиями из LLVM можно в файле `llvm-project/llvm/lib/Passes/PassRegistry.def`.

    В файлах `before-sink.ll` и `after-sink.ll` должен появиться IR до и после SinkingPass.  
    Постройте для них CFG и сравните.

    *Доп задача 1*:
    Попробуйте добавить другие пассы (например, GVN, InstCombine) и пронаблюдать изменения в IR и в производительности.

    *Доп задача 2*:
    Запустите
    ```sh
    $ ./build/TestRunner/test-runner --benchmark=Benchmarks/sink -print-after-all 2>&1 | grep 'IR Dump After'
    ```
    В выводе будет список всех пассов, которые запускались на бенчмарке.  
    Объясните, откуда они взялись, если в [Optimizer/Optimizer.cpp](Optimizer/Optimizer.cpp) они нигде не добавляются.

6. Попробуйте написать свой LLVM Pass и добавить его в пайплайн.  
    В [Optimizer/Passes](Optimizer/Passes) есть dummy пример пасса - CustomPass.  
    Либо скопируйте его, либо прямо в нём распечатайте сообщение из метода CustomPass::run:
    ```cpp
      errs() << " -- CustomPass::run(" << F.getName() << ")\n";
    ```
    Добавьте свой пасс в пайплайн, запустите бенчмарк и убедитесь, что ваш пасс запускается.
