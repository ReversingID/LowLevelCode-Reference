/*
    If-Else 
    Decision-Making

    Percabangan, pengambilan keputusan dengan pengecekan kondisi tunggal, aksi,
    dan alternatifnya

Assembling:
    $ ilasm if-else.il

*/

//-----------------------------------------------------------------------------

// -- Assembly Declaration --
.assembly extern mscorlib { auto }
.assembly 'branching' { }
.module 'program.exe'


/*
    Branching (percabangan) adalah perpindahan eksekusi ke sekumpulan instruksi
    menggunakan satu atau lebih instruksi branching.

Tujuan:
    implementasi statement "If-Else"
    percabangan sederhana yang mengarahkan ke sekelompok instruksi jika kondisi 
    terpenuhi.

Bentuk umum:
    if (condition) then
        do_action
    else 
        do_alternative_action

Padanan:
    if not (condition) then goto else; 
        do_action
        goto end 
    else:
        do_alternative_action
    end:

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

            ldc.i4      0
            stloc       var 


        /*
            if (var == 2)
            {
                var = 1;
            }
            else 
            {
                var = 0;
            }

            periksa apakah kondisi terpenuhi dan lakukan percabangan jika false
            (negasi dari kondisi terpenuhi).
            ini adalah implementasi efisien karena hanya butuh satu percabangan.
        */

            // pemeriksaan kondisi
            ldloc       var 
            ldc.i4      2
            bne.un      else     // berpindah jika var != 2

            // eksekusi do_action karena kondisi (asli) terpenuhi
            ldc.i4      1
            stloc       var

            // hindari block untuk "else" atau aksi alternatif
            br          end
        
        else:
            // eksekusi do_alternative_action karena kondisi (asli) tak terpenuhi.
            ldc.i4      0
            stloc       var

        end:
            // instruksi ini akan dieksekusi terlepas dari hasil percabangan.
        
            ret 
        }
    }
}