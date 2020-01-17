/*
    Comparison 

    Mekanisme perbandingan nilai.

Assembling:
    $ ilasm comparison.il 

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'comparison' { }
.module 'program.exe'


/*
    Comparison
    Comparison (perbandingan) adalah sekelompok instruksi untuk membandingkan dua 
    nilai. Perbandingan di .NET CIL secara spesifik menguji hubungan kedua nilai 
    apakah sama (equal), lebih besar (greater), maupun lebih kecil (less) dan 
    menghasilkan nilai 1 jika kondisi terpenuhi.
    
    Pada .NET CIL, tidak ada flag tertentu selain kondisi terpenuhi dan tidak.
    Hasil dari perbandingan tidak menjadi mandatory dalam percabangan.
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

        // -- Arithmetic --
        // CEQ (Compare if equal)
            // memeriksa apakah kedua operan memiliki nilai yang sama
            // menghasilkan 1 (tipe int32) jika kedua value sama, atau 0 jika
            // sebaliknya
            ldc.i4      4
            ldc.i4      3
            ceq                 // 4 == 3 ?

        // CGT (Compare if greater)
            // memeriksa apakah operan pertama lebih besar daripada operan kedua
            // menghasilkan 1 (tipe int32) jika operan pertama lebih besar,
            // atau 0 jika sebaliknya 
            ldc.i4      4
            ldc.i4      3
            cgt                 // 4 > 3 ?
            
            // memeriksa kedua bilangan yang unsigned
            ldc.i4      4
            ldc.i4      3
            cgt.un 
        
        // CLT (Compare if less than)
            // memeriksa apakah operan pertama lebih kecil daripada operan kedua
            // menghasilkan 1 (tipe int32) jika operan pertama kecil besar,
            // atau 0 jika sebaliknya 
            ldc.i4      4
            ldc.i4      3
            clt                 // 4 < 3 ?
            
            // memeriksa kedua bilangan yang unsigned
            ldc.i4      4
            ldc.i4      3
            clt.un 


            ret 
        }
    }
}