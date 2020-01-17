/*
    For 
    Loop

    Instruksi perulangan sederhana

Assembling:
    $ ilasm for.il

*/

//-----------------------------------------------------------------------------

// -- Assembly Declaration --
.assembly extern mscorlib { auto }
.assembly 'for' { }
.module 'program.exe'


/*
    Loop (perulangan) adalah serangkaian instruksi yang ditulis sekali namun
    dapat dieksekusi berkali-kali secara berturut-turut.

    Instruksi perulangan dapat dikendalikan berdasarkan banyaknya perulangan
    maupun kondisi perulangan yang harus dipenuhi.

    Di .NET CL, struktur loop dapat diterjemahkan sebagai mekanisme branching
    yang mengalihkan eksekusi ke awal struktur dalam kondisi tertentu.

Tujuan:
    Implementasi konstruksi "For" sebagai perulangan sederhana.
    For adalah konstruksi perulangan yang dikontrol menggunakan sebuah counter
    untuk mengeksekusi blok sebanyak sekian kali.

Bentuk umum:
    for (initialization; condition; counter_update)
        do_action

Padanan:
    initialization
    if not (condition) then goto loop_end 
    loop_body:
        do_action 
        counter_increment
    if not (condition) then goto loop_body
    loop_end

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
                int32 []    arrd,
                int32       i
            )

//-----------------------------------------------------------------------------
            
/*
    Struktur loop For dapat dipecah menjadi empat bagian:
        - initialization
        - condition checking 
        - counter update (increment/decrement) 
        - loop body 

    sehingga struktur for dapat dipecah dari 

            for (i = 0; i < 10; i++)
                arrd[i] = i;
    
    menjadi 

            i = 0;
            while (i < 10)
            {
                arrd[i] = i;
                i ++;
            }
*/

            ldc.i4      10
            newarr      [mscorlib]System.Int32 
            stloc       arrd 

            // inisialisasi
            ldc.i4      0
            stloc       i
            
            // periksa apakah eksekusi dilakukan atau dilewati
            br          loop_check
        
            // block instruksi dimulai di sini.
        loop_body:

            // eksekusi do_action
            ldloc       arrd 
            ldloc       i 
            ldloc       i 
            stelem.i4               // arrd[i] = i

            // tingkatkan nilai counter
            ldloc       i 
            ldc.i4      1
            add 

        loop_check:
            // periksa apakah perulangan akan dilakukan lagi 
            ldloc       i 
            ldc.i4      10
            ble         loop_body

            // di luar loop

                        
            ret 
        }
    }
}