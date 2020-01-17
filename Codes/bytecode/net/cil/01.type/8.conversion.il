/*
    Type Conversion
    .NET CIL Data Type 

    Konversi objek menjadi suatu tipe data berbeda.

Assembling:
    $ ilasm conversion.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'conversion' { }
.module 'program.exe'


/*
    Type Conversion 
    Mengubah suatu data dengan tipe tertentu menjadi tipe lain.
    Pada level .NET CIL, terdapat dua tipe type conversion secara eksplisit yaitu:
        - pemanggilan instruksi conv 
        - mekanisme Boxing dan Unboxing 
    
    Kedua mekanisme hanya dapat melakukan konversi terhadap tipe native (int, float).


    Boxing + Unboxing 
    Boxing adalah proses konversi sebuah valuetype ke tipe object.
    Ketika boxing, nilai akan disimpan di dalam instance System.Object ke Managed Heap.
    Unboxing adalah proses ekstraksi value type dari object.   
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

            ldc.i4.1

        // -- Type conversion --
            // tanpa pengecekan overflow
            conv.i1         // convert ke int8,  push int32 ke Stack
            conv.i2         // convert ke int16, push int32 ke Stack
            conv.i4         // convert ke int32, push int32 ke Stack
            conv.i8         // convert ke int64, push int64 ke Stack
            conv.u1         // convert ke unsigned int8,  push int32 ke Stack
            conv.u2         // convert ke unsigned int16, push int32 ke Stack
            conv.u4         // convert ke unsigned int32, push int32 ke Stack
            conv.u8         // convert ke unsigned int64, push int64 ke Stack
            conv.r4         // convert ke float32, push F ke Stack
            conv.r8         // convert ke float64, push F ke Stack

            // exception jika terjadi overflow
            conv.ovf.i1     // convert ke int8,  push int32 ke Stack
            conv.ovf.i2     // convert ke int16, push int32 ke Stack
            conv.ovf.i4     // convert ke int32, push int32 ke Stack
            conv.ovf.i8     // convert ke int64, push int64 ke Stack
            conv.ovf.u1     // convert ke unsigned int8,  push int32 ke Stack
            conv.ovf.u2     // convert ke unsigned int16, push int32 ke Stack
            conv.ovf.u4     // convert ke unsigned int32, push int32 ke Stack
            conv.ovf.u8     // convert ke unsigned int64, push int64 ke Stack

            // operasi unsigned, exception jika terjadi overflow
            conv.ovf.i1.un  // convert unsigned ke int8,  push int32 ke Stack
            conv.ovf.i2.un  // convert unsigned ke int16, push int32 ke Stack
            conv.ovf.i4.un  // convert unsigned ke int32, push int32 ke Stack
            conv.ovf.i8.un  // convert unsigned ke int64, push int64 ke Stack
            conv.ovf.u1.un  // convert unsigned ke unsigned int8,  push int32 ke Stack
            conv.ovf.u2.un  // convert unsigned ke unsigned int16, push int32 ke Stack
            conv.ovf.u4.un  // convert unsigned ke unsigned int32, push int32 ke Stack
            conv.ovf.u8.un  // convert unsigned ke unsigned int64, push int64 ke Stack

            pop 


        // Boxing + Unboxing
            // boxing int32 ke System.Int32
            ldc.i4      135
            box         [mscorlib]System.Int32 

            // Unboxing Int32
            unbox.any   [mscorlib]System.Int32 

            ret
        }
    } 
}
