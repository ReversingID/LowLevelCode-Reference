;   Complex Condition
;   Decision-Making
;
;   Percabangan ke beragam alternatif berbeda berdasarkan Jump Table.
;
; LLVM Bitcode:
;   $ llvm-as switch.ll
;
; Assembly(x86):
;   $ llc -march=x86 -o switch.asm switch.ll
;
;-----------------------------------------------------------------------------

source_filename = "switch.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"


; Control-Flow
; Ketika suatu program berjalan, eksekusi instruksi dilakukan secara berurutan 
; dari awal hingga akhir. Namun dalam beberapa kondisi tertentu, terdapat
; kebutuhan untuk mengeksekusi instruksi di lokasi lain sebagai bentuk
; penanganan kasus.
;
; Konstruksi control-flow secara high-level dapat diterjemahkan menggunakan
; kombinasi percabangan antar Basic Block.


;   Percabangan adalah perpindahan eksekusi ke sekumpulan instruksi menggunakan
;   satu atau lebih instruksi branching.
;
; Tujuan:
;   implementasi statement "Switch" atau "Jump Table".
;   percabangan dengan beragam kondisi alternatif berdasarkan nilai.
;
; Bentuk umum:
;   switch (variable)
;   {
;       case val_1: do_action_1; break;
;       case val_2: do_action_2; break;
;       ...
;       default: do_alternative_action;
;   }
;
;   switch:   tes nilai variabel 
;   case:     label lokasi dari target, bergantung kepada nilai variabel
;   break:    lompat ke akhir blok "switch"
;   default:  aksi alternatif secara umum ketika tidak ada nilai terpenuhi


;-----------------------------------------------------------------------------
;   One Layer Jump Table
;
; Karakteristik:
;   label merupakan rangkaian nilai yang terurut atau memiliki gap yang minimum.
;
;           switch (variable)
;           {
;               case 1: action_1; break;
;               case 2: action_2; break;
;               default: action_default;
;           }
;    
; Catatan:
;    apabila terdapat beberapa cluster case yang memiliki nilai berurutan, maka dapat
;    dibentuk lebih dari 1 "switch" untuk menangani masing-masing cluster.

define i32 @one_layer_jumptable () {
entry:
    %ivar       = alloca i32, align 4
    store       i32 0, i32* %ivar, align 4

    ; case default merupakan case alternatif jika semua case tidak terpenuhi.
    ; case ini dituliskan secara eksplisit.

    %ivar.val   = load i32, i32* %ivar, align 4
    switch      i32 %ivar.val, label %action_default [
        i32 1, label %action_1 
        i32 2, label %action_2
    ]

action_1:
    ; eksekusi aksi 1

    ; lompat ke akhir switch
    br          label %end

action_2:
    ; eksekusi aksi 2

    ; lompat ke akhir switch
    br          label %end

action_default:
    ; eksekusi action_default ketika tidak ada kondisi terpenuhi
    br          label %end

end:
    ; block ini akan dieksekusi terlepas dari hasil percabangan
    ret i32 0
}


;-----------------------------------------------------------------------------
;   Jump Table with Gap
;
; Karakteristik:
;   label merupakan rangkaian nilai yang terurut namun terdapat beberapa case
;   yang memiliki kesenjangan dengan nilai sebelum atau sesudahnya.
;
;           switch (variable)
;           {
;               case 1: action_1; break;
;               case 2: action_2; break;
;               case 5: action_5; break;
;               default: action_default;
;           }
;    
; Catatan:
;   case yang tidak nampak akan diarahkan menuju case "default" jika ada,
;   atau menuju end

define i32 @gap_jumptable () {
entry:
    %ivar       = alloca i32, align 4
    store       i32 0, i32* %ivar, align 4

    ; case default merupakan case alternatif jika semua case tidak terpenuhi.
    ; case ini dituliskan secara eksplisit.

    %ivar.val   = load i32, i32* %ivar, align 4
    switch      i32 %ivar.val, label %action_default [
        i32 1, label %action_1 
        i32 2, label %action_2
        i32 5, label %action_5
    ]

action_1:
    ; eksekusi aksi 1

    ; lompat ke akhir switch
    br          label %end

action_2:
    ; eksekusi aksi 2

    ; lompat ke akhir switch
    br          label %end

action_5:
    ; eksekusi aksi 5

    ; lompat ke akhir switch
    br          label %end

action_default:
    ; eksekusi action_default ketika tidak ada kondisi terpenuhi
    br          label %end

end:
    ; block ini akan dieksekusi terlepas dari hasil percabangan
    ret i32 0
}