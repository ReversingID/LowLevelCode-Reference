# Low-Level Code Reference

Introduction to LLVM Pass

## LLVM Pass 

LLVM Pass merupakan inti dari transformasi yang dilakukan pada Middle End di LLVM Compiler Infrastructure.

Sebuah Pass adalah sebuah unit transformasi dan optimisasi. LLVM mengaplikasikan serangkaian analisis dan transformasi terhadap program (direpresentasikan dengan LLVM IR). LLVM memiliki Pass Framework yang sangat _customizable_ untuk mengakomodir berbagai keperluan.

Beberapa Pass yang bersifat Machine Independent, dipanggil melalui `opt`. Sementara sebagian lain yang bersifat Machine Dependent, dipanggil melalui `llc`.

Sebuah Pass dapat membutuhkan informasi yang dihasilkan oleh Pass lain. Ketergantungan ini haruslah disebutkan secara eksplisit.

Semua LLVM Pass merupakan subclass dari class Pass, yang mengimplementasikan fungsionalitas dengan cara override virtual methods yang diturunkan dari `Pass`.

Class dasar yang tersedia sebagai base class:

- ModulePass
- CallGraphSCCPass
- FunctionPass
- LoopPass
- RegionPass
- BasicBlockPass

Sebuah informasi komprehensif diberikan oleh LLVM dalam [official guide](http://llvm.org/docs/WritingAnLLVMPass.html).


## Pass Hierarchy and LLVM IR

LLVM memandang sebuah program sebagai komponen-komponen yang tersusun dalam container, satu komponen berada di dalam komponen lain. Sebuah `Module` berisi `Function`. `Function` berisi `BasicBlock`. `BasicBlock` berisi `Instruction`.

Penjelasan terhadap hirarki LLVM IR dapat dilihat pada bagian [layout](layout.md).

Sebuah Pass dijalankan untuk setiap komponen yang berkaitan dengan tipe Pass tersebut.

## Pass List

Terdapat beberapa Pass yang didefinisikan di LLVM Pass Framework.

Sebuah Pass dapat memanggil Pass lain sebelum atau saat dieksekusi. Tujuan yang ingin dicapai adalah:

- untuk transformasi suatu bagian, misal BreakCriticalEdges.
- untuk mendapatkan informasi pada bagian tertentu, misal AliasAnalysis.

#### ModulePass

Pass yang diturunkan dari `ModulePass` mengindikasikan bahwa Pass menggunakan program secara keseluruhan sebagai sebuah unit. Contoh operasi yang dilakukan adalah memproses daftar fungsi dan menambah atau menghapus fungsi tertentu.

Daftar fungsi yang diimplementasikan (override):

- `virtual bool runOnModule(Module &M) = 0`

#### CallGraphSCCPass

Pass yang diturunkan dari `CallGraphSCCPass` dapat menelusuri program secara bottom-up pada callgraph (callee sebelum caller).

Daftar fungsi yang diimplementasikan (override):

- `virtual bool doInitialization(CallGraph &CG);`
- `virtual bool runOnSCC(CallGraph &CG);`
- `virtual bool doFinalization(CallGraph &CG);`

#### FunctionPass

Daftar fungsi yang diimplementasikan (override):

- `virtual bool doInitialization(Module &M);`
- `virtual bool runOnFunction(Function &F) = 0;`
- `virtual bool doFinalization(Module &M);`

#### LoopPass

Pass yang diturunkan dari `LoopPass` akan dieksekusi untuk setiap loop di dalam fungsi secara independen terhadap loop lain.

Daftar fungsi yang diimplementasikan (override):

- `virtual bool doInitialization(Loop *, LPPassManager &LPM);`
- `virtual bool runOnLoop(Loop *, LPPassManager &LPM) = 0;`
- `virtual bool doFinalization();`

#### RegionPass

Daftar fungsi yang diimplementasikan (override):

- `virtual bool doInitialization(Region *, RGPassManager &RGM);`
- `virtual bool runOnRegion(Region *, RGPassManager &RGM) = 0;`
- `virtual bool doFinalization();`

#### BasicBlockPass

Daftar fungsi yang diimplementasikan (override):

- `virtual bool doInitialization(Function &F);`
- `virtual bool runOnFunction(BasicBlock &BB) = 0;`
- `virtual bool doFinalization(Function &F);`

#### MachineFunctionPass

Pass yang diturunkan dari `MachineFunctionPass` akan dieksekusi pada representasi kode dalam bentuk machine dependent.

Daftar fungsi yang diimplementasikan (override):

- `virtual bool runOnFunction(MachineFunction &MF) = 0;`
