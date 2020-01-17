# Low-Level Code Reference

LLVM Tools & Commands

## Standard Tools Command

LLVM menyediakan beberapa tools untuk memproses dan memanipulasi LLVM IR. Tools bawaan yang berperan dalam manipulasi LLVM IR, dan juga digunakan dalam repository ini, adalah:


| Name        | Function               | Reads        | Writes      | Arguments       |
|-------------|------------------------|--------------|-------------|-----------------|
| clang       | C Compiler             | .c           | .ll         | -emit-llvm -S   |
| clang++     | C++ Compiler           | .cpp         | .ll         | -emit-llvm -S   |
| opt         | Optimizer              | .bc/.ll      | .bc         |                 |
| llvm-dis    | Bitcode Disasssembler  | .bc          | .ll         |                 |
| llc         | IR Compiler            | .ll          | .s          |                 |


LLVM Terdiri atas tiga komponen yang mewakili setiap tahapan kompilasi: Front End, Middle End, Back End. Dalam infrastruktur LLVM, LLVM IR lebih dominan digunakan pada Middle End.

#### Front End

Komponen yang menerima input source code dan menghasilkan LLVM IR.

```
# Preprocessing
$ clang -E code.c

# Type checking
$ clang -fsyntax-only code.c

# Code generation, bangkitkan IR dalam bentuk assembly
$ clang -emit-llvm -o code.ll -c -S code.c

# Code generation, bangkitkan IR dalam bentuk bitcode
$ clang -emit-llvm -o code.bc -c code.c

# Lexical analysis (tokenizer)
$ clang -cc1 -dump-tokens code.c

# Syntax analysis 
$ clang -cc1 -ast-dumps code.c

# Semantic analysis
$ clang -cc1 -print-decl-contexts code.c
```

#### Middle End

Komponen yang mengolah LLVM IR untuk mencapai optimisasi dengan melakukan serangkaian analisis dan transformasi.

```
# Conversion, ubah LLVM IR dari assembly ke bitcode
$ llvm-as -o code.bc code.ll

# Conversion, ubah LLVM IR dari bitcode ke assembly
$ llvm-dis -o code.ll code.bc

# Merge (linking) bitcode
$ llvm-link -o merge.bc code-1.bc code-2.bc

# Eksekusi LLVM bitcode
$ lli code.bc

# Jalankan LLVM Pass terhadap bitcode
$ opt -load-pass-plugin=libpass.so -passes="PassFunction" code.bc -o output.bc

# Jalankan LLVM Pass terhadap bitcode (legacy)
$ opt -load ./libpass.so -PassFunction code.bc -o output.bc
```

#### Back End

Komponen yang menerima LLVM IR dan membangkitkan kode mesin yang sesuai.

```
# Static compile ke kode assembly
$ llc -o code.asm code.bc
$ llc -o code.asm -march=x86 code.bc

# Linking
$ ld.lld code.o
```


## Code Processing with LLVM

LLVM sebagai infrastruktur compiler sangat cocok digunakan untuk melakukan kompilasi program:

- compiler
- debugger
- JIT system

Namun selain jenis-jenis tools di atas, LLVM dapat diperluas untuk melakukan hal-hal di antaranya:

- architecture simulator
- dynamic binary instrumentation
- source-level transformation
- simple hypervisor

LLVM IR merupakan objek utama analisis dalam berbagai tools yang dibangun di atas infrastruktur LLVM. LLVM sangat fleksibel dan dapat digunakan untuk membangun tools analisis menyesuaikan kebutuhan. 

Beberapa jenis tools yang dapat dibangun:

- Dynamic Analysis
    - Profiler
    - Test generator
    - Emulation
    - Instrumentation
- Static Analysis
    - Data-Flow Analysis
    - Constraint-Based Analysis
    - Type Analysis


#### Profiler 

Eksekusi program dan mencatat event yang terjadi saat runtime.

Example: gprof


#### Test generator

Mencoba bangkitkan test case yang mencakup (cover) sebagian besar kode program, atau menghasilkan event tertentu.

Example: KLEE


#### Emulation 

Eksekusi program di atas Virtual Machine, untuk mengumpulkan dan menganalisis data.

Example: valgrind


#### Instrumentation

Memodifikasi (menambahkan perilaku) sebuah program saat runtime untuk mengawasi (monitor) perilaku dari aplikasi.

Example: AssressSanitizer


#### Dataflow Analysis

Meneruskan / menyalurkan informasi (propagate) berdasarkan ketergantungan antar elemen program. 

Hal yang bisa dilakukan:

- liveness analysis 
- reaching definitions
- constant propagation
- available expressions
- very busy expressions


#### Constraint-Based analysis

Menurunkan constraint program. Constraint adalah kendala atau batasan yang ditemui untuk mengeksekusi suatu blok instruksi.

Hubungan antar constraint tidak ditentukan secara eksplisit oleh sintaks. 

Hal yang bisa dilakukan:

- control flow analysis
- pointer analysis 


#### Type analyses

Meneruskan informasi sebagai type annotation. Informasi ini dapat digunakan untuk membuktikan property dari program, seperti progress dan preservation.