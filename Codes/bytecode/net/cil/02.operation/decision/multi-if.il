/*
    Multi-If 
    Decision-Making

    Banyak pilihan keputusan dengan masing-masing memiliki kondisi sederhana.

Assembling:
    $ ilasm multi-if.il

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
    implementasi statement "Multi-If"
    Setiap cabang memiliki kondisi sederhana dan akan mengarahkan eksekusi ke blok
    tertentu jika kondisi terpenuhi.

Bentuk umum (3 case):
    if (condition_1) then 
        do_action_1
    else if (condition_2) then 
        do_action_2
    else 
        do_alternative_action

Padanan:
    if not (condition_1) then goto check_2
        do_action_1
        goto end
    check_2:
    if not (condition_2) then goto else
        do_action_2
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
                var = 1;
            else if (var == 1)
                var = 0;
            else 
                var = 2;
        */

            // pemeriksaan kondisi untuk condition_1
            ldloc       var 
            ldc.i4      2
            bne.un      check2   // berpindah jika var != 2

            // eksekusi do_action_1 karena kondisi terpenuhi
            ldc.i4      1
            stloc       var

            // hindari block lain
            br          end
        
        check2:
            // pemeriksaan kondisi untuk condition_2
            ldloc       var 
            ldc.i4      1
            bne.un      else    // berpindah jika var != 1

            // eksekusi do_action_2 karena kondisi terpenuhi
            ldc.i4      0
            stloc       var

            // hindari block lain
            br          end
        
        else:
            // eksekusi do_alternative_action karena kondisi (asli) tak terpenuhi.
            ldc.i4      2
            stloc       var

        end:
            // instruksi ini akan dieksekusi terlepas dari hasil percabangan.
        
            ret 
        }
    }
}