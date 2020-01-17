/*
    Nested-If 
    Decision-Making

    Pemilihan keputusan secara bersarang.

Assembling:
    $ ilasm nested-if.il

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
    implementasi percabangan bersarang.
    Sebuah percabangan dapat didefinisikan di dalam blok aksi percabangan lain. 

Bentuk umum:
    if (condition_1) then 
        do_action_1 
        if (condition_2) then 
            do_action_2

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
                int32   var1,
                int32   var2
            )

            ldc.i4      0
            stloc       var1

            ldc.i4      0
            stloc       var2

/*
    Perlu dicatat bahwa pemeriksaan kondisi condition_2 hanya terjadi jika condition_1 terpenuhi.
    Dapat dikatakan bahwa pemeriksaan condition_2 berada pada block sama dengan do_action_1

            if (var1 == 0) 
            {
                var1 = 10;
                if (var2 == 0)
                    var2 = 20;
            }
*/

            // pemeriksaan kondisi condition_1
            ldloc       var1 
            ldc.i4      0
            bne.un      end     // berpindah jika var1 != 0

            // eksekusi do_action_1
            ldc.i4      10
            stloc       var1    // var1 = 10

            // pemeriksaan kondisi condition_2
            ldloc       var2 
            ldc.i4      0
            bne.un      end     // berpindah jika var2 != 0

            // eksekusi do_action_2
            ldc.i4      20
            stloc       var2

        end:
            // instruksi ini akan dieksekusi terlepas dari hasil percabangan.
        
            ret 
        }
    }
}