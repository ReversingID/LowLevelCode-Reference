/*
    While 
    Loop

    Instruksi perulangan sederhana

Assembling:
    $ ilasm while.il

*/

//-----------------------------------------------------------------------------

// -- Assembly Declaration --
.assembly extern mscorlib { auto }
.assembly 'loop' { }
.module 'program.exe'


/*
    Loop (perulangan) adalah serangkaian instruksi yang ditulis sekali namun
    dapat dieksekusi berkali-kali secara berturut-turut.

    Instruksi perulangan dapat dikendalikan berdasarkan banyaknya perulangan
    maupun kondisi perulangan yang harus dipenuhi.

    Di .NET CL, struktur loop dapat diterjemahkan sebagai mekanisme branching
    yang mengalihkan eksekusi ke awal struktur dalam kondisi tertentu.

Tujuan:
    Implementasi konstruksi "While" sebagai perulangan sederhana.
    While memiliki konstruksi yang mirip dengan Do-While namun dengan 
    pemeriksaan kondisi terjadi di awal.

Bentuk umum:
    while (condition)
        do_action

Padanan:
    if not (condition) then goto loop_end 
    loop_body:
        do_action
    if (condition) then goto loop_body
    loop_end:

*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object 
    {
        .method public static 
                void Main() cil managed
        {
            .entrypoint
            .maxstack 8
            ret 
        }

        .method public instance 
                void _algorithm () cil managed 
        {
            .maxstack 8

            .locals init (
                int32   var
            )
            
/*
    Konstruksi While terlihat lebih sederhana namun memiliki pemeriksaan kondisi
    lebih (dibandingkan Do-While) untuk dapat menciptakan perulangan.

            while (var <= 10)
                var ++;
    
    Pada kasus tertentu, beberapa instruksi dapat mengubah kondisi.
    Misal, perubahan counter, perubahan treshold, dsb.
*/

//-----------------------------------------------------------------------------

/*
    Implementasi 1

    Pada implementasi ini, terdapat dua percabangan yang membentuk loop While.

        - Conditional Branching untuk mengeksekusi blok atau melewatinya.
        - Conditional Branching untuk melanjutkan perulangan atau tidak.

*/
            // lakukan inisialisasi apapun jika diperlukan di sini.
            ldc.i4      0
            stloc       var

            // periksa apakah eksekusi dilakukan atau dilewati
            ldloc       var 
            ldc.i4      10
            bgt         loop_end

            // block instruksi dimulai di sini.
        loop_body_1:

            // eksekusi do_action
            ldloc       var 
            ldc.i4      1
            add 
            stloc       var 

            // periksa apakah perulangan akan dilakukan lagi 
            ldloc       var 
            ldc.i4      10
            ble         loop_body_1

            // di luar loop
        loop_end:

//-----------------------------------------------------------------------------

/*
    Implementasi 2

    Pada implementasi ini, terdapat dua percabangan yang membentuk loop While 

        - Unconditional Branching untuk mengarah ke pemeriksaan kondisi 
        - Conditional Branching untuk melanjutkan perulangan atau tidak.
*/

            // lakukan inisialisasi apapun jika diperlukan di sini.
            ldc.i4      0
            stloc       var

            // lakukan pemeriksaan kondisi
            br          loop_check

            // block instruksi dimulai di sini.
        loop_body_2:

            // eksekusi do_action
            ldloc       var 
            ldc.i4      1
            add 
            stloc       var 

        loop_check:
            // periksa apakah perulangan akan dilakukan lagi 
            ldloc       var 
            ldc.i4      10
            ble         loop_body_2

            // di luar loop
                        
            ret 
        }
    }
}