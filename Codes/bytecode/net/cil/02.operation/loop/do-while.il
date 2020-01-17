/*
    Do-While 
    Loop 

    Perulangan sederhana dengan satu kondisi.

Assembling:
    $ ilasm do-while.il

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
    Implementasi konstruksi "Do-While" sebagai perulangan sederhana.
    Struktur Do-While adalah struktur perulangan dimana sekelompok instruksi
    dieksekusi setidaknya sebanyak sekali.
    Kondisi perulangan akan diperiksa di akhir struktur.

Bentuk umum:
    do 
        do_action
    while (condition)

Padanan:
    loop_body:
        do_action 
    if not (condition) then goto loop_body

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

//-----------------------------------------------------------------------------

/*
    Blok instruksi dieksekusi, kondisi diperiksa saat akhir perulangan dan lompat
    kembali ke awal block jika kondisi terpenuhi.

            do 
            {
                var ++;
            } while (var <= 10);
    
    Pada kasus tertentu, beberapa instruksi dapat mengubah kondisi.
    Misal: perubahan counter, perubahan treshold, dsb.
*/
            // lakukan inisialisasi apapun jika diperlukan di sini.
            ldc.i4      0
            stloc       var

            // block instruksi dimulai di sini.
        loop_body:

            // eksekusi do_action
            ldloc       var 
            ldc.i4      1
            add 
            stloc       var 

            // conditional jump
            // periksa apakah perulangan akan dilakukan lagi 
            ldloc       var 
            ldc.i4      10
            ble         loop_body

            // di luar loop

            ret 
        }
    }
}