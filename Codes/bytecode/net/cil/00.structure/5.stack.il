/*
    Stack

    .NET IL terdiri atas beberapa komponen yang tersusun secara terstruktur
    dengan berorientasi objek.

Assembling:
    $ ilasm stack.il

*/

//-----------------------------------------------------------------------------

// -- Assembly Declaration --
.assembly extern mscorlib { auto }
.assembly 'stack' { }
.module 'program.exe'


/*
    Stack
    struktur data yang memiliki karakteristik Last In First Out (LIFO)
    untuk penyimpanan data. Stack (tumpukan) mendefinisikan kumpulan elemen
    dengan urutan tertentu. Puncak Stack adalah elemen pertama yang akan
    dikeluarkan dari Stack. Elemen baru akan diletakkan di atas puncak Stack
    lama dan berakhir sebagai elemen Puncak (Top) yang baru.


    Evaluation Stack
    .NET menggunakan struktur Stack sebagai penyimpanan sementara untuk
    operan instruksi, argumen method, hingga hasil operasi. Instruksi dapat 
    mempengaruhi Stack secara langsung maupun tidak langsung.

    Tidak ada instruksi .NET CIL yang dapat mengakses variabel lokal maupun 
    argumen method secara langsung. Stack menjadi perantara akses.

    
    Elemen Stack diimplementasikan sebagai slot, bukan byte atau word memory.
    Operasi pada Stack bersifat high-level. Slot menyimpan informasi tentang tipe
    dari item yang menempatinya terlepas dari ukuran masing-masing item.
    

    Kondisi awal Evaluation Stack adalah kosong, dimana tidak ada elemen apapun
    ketika program berjalan. Pada akhir program, Runtime pun mengharapkan agar 
    Evaluation Stack dalam keadaan kosong.
*/

// -- Namespace Declaration --
.namespace RevID
{
    // -- Class Declaration --
    .class  public auto ansi beforefieldinit 
            Program extends [mscorlib]System.Object
    {
        .field  public static int32     g_static;
        .field  public int32            g_instance;

        .method public static hidebysig 
                void Main (string [] args) cil managed 
        {
            .entrypoint
            .maxstack 8
            ret 
        }

        // Tipe operasi yang ada di CIL
        .method public hidebysig instance default 
                void _algorithm (int32 arg) cil managed 
        {
            // Slot maksimum untuk stack frame method ini.
            .maxstack 8

            .locals init (
                int32   l_int,
                string  l_str
            )

            // -- Load (Push) item ke Stack --
            ldarg.1                                     // argumen method
            ldc.i4.1                                    // nilai konstan
            ldstr   "Reversing.ID"                      // string
            ldsfld  int32 RevID.Program::g_static       // static field
            ldfld   int32 RevID.Program::g_instance     // field
            ldloc.0                                     // variabel lokal

            // -- Duplicate --
            // menggandakan nilai di puncak Stack
            dup 

            // -- Pop --
            // membuang item dari puncak Stack tanpa menyimpan ke lokasi lain
            pop 
            pop

            // -- Store item dari Stack --
            stfld   int32 RevID.Program::g_instance     // field
            stsfld  int32 RevID.Program::g_static       // static field
            stloc.1                                     // variabel lokal (string)
            stloc.0                                     // variabel lokal (konstanta)
            starg.s 1                                   // argumen method (sign)

            ret 
        }

        .method public hidebysig instance default 
                void _fcn () cil managed 
        {
            .maxstack 8
            ret 
        }

        .method public virtual hidebysig newslot instance default
                void _vfcn () cil managed 
        {
            .maxstack 8
            ret
        }

        // -- Operasi Load --
        // Daftar instruksi yang termasuk ke dalam operasi load
        // Hanya referensi instruksi.
        .method public hidebysig instance default 
                void _load (int32 a1, int32 a2, int32 a3, int32 a4) cil managed 
        {
            .maxstack 8

            .locals init (
                int32 v0, int32 v1, int32 v2, int32 v3, int32 v4
            )

            // argumen method
            ldarg.0                                     // argumen spesial untuk instance: THIS
            ldarg.3
            ldarg       4
            ldarga      4                               // alamat dari argumen a4

            // nilai konstan
            ldc.i4.8
            ldc.i4.m1                                   // nilai -1
            ldc.i4      9
            ldc.i8      10
            ldc.r4      9.0
            ldc.r8      10.0

            // field
            ldfld       int32 RevID.Program::g_instance     // field bertipe instance 
            ldflda      int32 RevID.Program::g_instance     // alamat dari g_instance
            ldsfld      int32 RevID.Program::g_static       // field bertipe static
            ldsflda     int32 RevID.Program::g_instance     // alamat dari g_static
            
            // elemen array
            // lihat penggunaan array
            ldelem      [mscorlib]System.Int32          // load elemen dengan tipe tertentu

            ldelem.i                                    // load native int
            
            ldelem.i1 
            ldelem.i2
            ldelem.i4
            ldelem.i8
            ldelem.r4
            ldelem.r8

            ldelem.u1
            ldelem.u2
            ldelem.u4
            ldelem.u8

            ldelem.ref          // push reference ke array dengan elemen yang ditunjuk sebagai elemen pertama

            ldelema     [mscorlib]System.Int32          // load address dari elemen pada indeks
            

            // alamat function
            ldftn       void  RevID.Program::_fcn()     // alamat dari fungsi _fcn()
            ldvirtftn   void  RevID.Program::_vfcn()    // alamat dari fungsi virtual _vfcn()
                                                        
            // local variable
            ldloc.3
            ldloc       4
            ldloca      4

            // null reference
            ldnull

            // object
            ldobj       [mscorlib]System.Guid

            // string 
            ldstr       "Reversing.ID"
            
            ret 
        }

        // -- Operasi Store --
        // Daftar instruksi yang termasuk ke dalam operasi store
        // Hanya referensi instruksi.
        .method public instance 
                void _store (int32 a1, int32 a2, int32 a3, int32 a4) cil managed 
        {
            .maxstack 8
            .locals init (
                int32 v0, int32 v1, int32 v2, int32 v3, int32 v4
            )

            // argumen method
            starg       4
            
            // field
            stfld   int32 RevID.Program::g_instance
            stsfld  int32 RevID.Program::g_static
            
            // local variable
            stloc.3
            stloc       4
            
            ret 
        }
    } 
}