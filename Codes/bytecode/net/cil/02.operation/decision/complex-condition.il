/*
    Complex condition
    Decision-Making 

    Percabangan dengan pemeriksaan kondisi kompleks

Assembling:
    $ ilasm complex-condition.il

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
    Percabangan dengan pemeriksaan kondisi kompleks dan mengarahkan ke sekelompok
    instruksi jika kondisi terpenuhi. Kondisi kompleks adalah kombinasi dari kondisi 
    sederhana.

Bentuk umum (2 case):
    if (complex_condition) then 
        do_action 
    
    tipe complex_condition:
        - condition_1 AND condition_2
        - condition_1 OR condition_2

Padanan:
    if not (complex_condition) then goto end
        do_action
    end:

    Perlu diketahui bahwa kondisi kompleks adalah kombinasi dari beberapa kombinasi 
    kondisi sederha yang dirangkai. Sehingga perlu dilakukan pemisahan kondisi dan
    identifikasi untuk menentukan struktur yang tepat.
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
        

/*-----------------------------------------------------------------------------
    condition_1 AND condition_2

    Ekspresi logika ini akan bernilai TRUE jika kedua kondisi bernilai TRUE.
    Karena itu, ketika evaluasi kondisi dari kiri ke kanan, jika terdapat satu
    kondisi bernilai FALSE, maka aksi tidak akan dieksekusi.

            if (var1 > 0 && var2 < 10)
            {
                var1 = 10;
            }
*/
        .method public instance 
                void _complex_and () cil managed 
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

            // pemeriksaan kondisi

            // jika var1 lebih kecil atau sama dengan 0
            // kondisi kompleks akan dievaluasi sebagai FALSE
            ldloc       var1 
            ldc.i4      0
            ble         fail 

            // jika var2 lebih kecil atau sama dengan 10
            // kondisi kompleks akan dievaluasi sebagai FALSE
            ldloc       var2 
            ldc.i4      10
            ble         fail 

            // eksekusi do_action karena kondisi (asli) terpenuhi
            ldc.i4      10
            stloc       var1

        fail:
            // instruksi ini akan dieksekusi terlepas dari hasil percabangan.

            ret
        }


/*-----------------------------------------------------------------------------
    condition_1 OR condition_2

    Ekspresi logika ini akan bernilai TRUE jika salah satu kondisi bernilai TRUE.
    Karena itu, ketika evaluasi kondisi dari kiri ke kanan, jika terdapat satu
    kondisi bernilai TRUE, maka aksi akan dieksekusi.

            if (var1 > 0 || var2 > 10)
            {
                var1 = 10;
            }
*/
        .method public instance 
                void _complex_or () cil managed 
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

            // pemeriksaan kondisi

            // jika var1 lebih besar daripada 0
            // kondisi kompleks akan dievaluasi sebagai TRUE
            ldloc       var1 
            ldc.i4      0
            bgt         success

            // jika var2 lebih kecil atau sama dengan 10
            // kondisi kompleks akan dievaluasi sebagai FALSE
            ldloc       var2 
            ldc.i4      10
            ble         fail

        success:
            // eksekusi do_action karena kondisi (asli) terpenuhi
            ldc.i4      10
            stloc       var1

        fail:
            // instruksi ini akan dieksekusi terlepas dari hasil percabangan.
        
            ret 
        }
    }
}