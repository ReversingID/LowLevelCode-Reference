# Low-Level Code Reference

Introduction to Python bytecode

## Python Bytecode

Python Bytecode adalah Instruction Set yang digunakan oleh Python Interpreter.

Python interpreter adalah Process Virtual Machine berbasis stack. Instruksi Python akan diterjemahkan secara dinamis menjadi kode yang berjalan secara native di host.

## Computation Model

Berdasarkan referensi CPython dengan bytecode untuk Python versi 3.x

CPython menggunakan tiga tipe stack:
    - Call Stack
    - Evaluation Stack
    - Block Stack

`Call Stack`, berisi informasi tentang fungsi, disebut pula Frame, yang dipanggil secara berurutan. Apabila sebuah fungsi dipanggil, maka Frame baru akan diletakkan di puncak Stack. Apabila fungsi berakhir, maka Frame terkait akan diambil. Dengan menelusuri tumpukan Frame yang ada, alur eksekusi sebuah program dapat ditelusuri. 

`Evaluation Stack` atau `Data Stack`, terdapat di setiap Frame. Evaluation Stack digunakan oleh fungsi terkait untuk menyimpan argumen yang diperlukan oleh sebuah instruksi dan juga nilai kembalian yang dihasilkan.

`Block Stack`, terdapat di setiap Frame. Block Stack digunakan untuk melacak banyaknya Block (loop, try/except, with, dsb) yang aktif.

Terdapat tiga jenis block (namespace): module, function body, dan class definition.

## Vendor

Terdapat beberapa implementasi Python:
    - CPython
    - Jython
    - IronPython

Namun masing-masing menerima format yang didefinisikan oleh CPython atau model yang menjadi rujukan.