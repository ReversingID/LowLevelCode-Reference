/*
    Array
    .NET CIL Data Type 

    Array dan operasi elemen bertipe seragam

Assembling:
    $ ilasm array.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'array' { }
.module 'program.exe'


/*
    Array 
    Himpunan objek atau elemen dengan tipe seragam dan terletak secara sekuensial
    (berurutan) di memory.

    Elemen Array dapat berupa tipe dasar (integer, float, pointer, dsb) maupun tipe
    agregat (Array, Struct, dsb). Setiap elemen dapat diakses secara individual 
    melalui pengalamatan berbasis indeks.

    .NET CIL mendukung penggunaan array multidimensi. Dimensi pada Array adalah
    banyaknya titik atau index yang digunakan untuk memilih sebuah elemen.

    Array dimensi satu dapat diandaikan sebagai sebuah daftar.
    Array dimensi dua dapat diandaikan sebagai sebuah tabel.
    Array dimensi tiga dapat diandaikan sebagai kubus data.
    dsb.

    Semakin banyak dimensi maka memory yang dibutuhkan akan semakin besar untuk menampung data.
*/

.namespace RevID
{
    .class  public
            Program extends [mscorlib]System.Object
    {
        /*
            Deklarasi & instansiasi
            Array adalah objek yang menyimpan kumpulan elemen bertipe sama dengan urutan tertentu.
            Deklarasi sebuah Array hanya menciptakan sebuah reference namun tidak menciptakan 
            objek Array secara aktual. 
            Instansiasi Array harus dilakukan terlebih dahulu dengan menyebut kapasitas Array. 
        */

        // array global
        // instansiasi dan inisialisasi akan dilakukan di .ctor
        .field  public  int32[]     iarr_uninit
        .field  public  int32[]     iarr_init
        
        .method public instance 
                void '.ctor' () cil managed
        {
            .maxstack 8

            // -- instansiasi Array --
            // Array uninitialized (int32)
            // Hanya instansiasi saja, tidak ada assignment nilai awal ke array
            ldarg.0
            ldc.i4.s    10
            newarr      [mscorlib]System.Int32
            stfld       int32[] RevID.Program::iarr_uninit

            // array initialized (int32)
            // inisialisasi tak langsung dengan salin data dari class khusus.
            ldarg.0
            ldc.i4.s    10
            newarr      [mscorlib]System.Int32 
            dup                                     // duplikasi array yang baru dibangun
            ldtoken     field valuetype DataWrapper/ArrType_40 DataWrapper::fld_array_int
            call        void class [mscorlib]System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(class [mscorlib]System.Array, valuetype [mscorlib]System.RuntimeFieldHandle)
            stfld       int32[] RevID.Program::iarr_init 

            // panggil Parent Class
            ldarg.0
            call        instance void object::'.ctor'()
            ret 
        }

        .method public static 
                void Main() cil managed 
        {
            .entrypoint
            .maxstack 8

            .locals init (int32[] arr)

            // instansiasi array
            // buat array dengan 5 slot dan simpan di variabel lokal
            ldc.i4.5
            newarr      [mscorlib]System.Int32 
            stloc.0

            // dapatkan panjang array
            ldloc.0
            ldlen 

            // store data ke elemen array
            ldloc.0
            ldc.i4      2
            ldc.i4      15
            stelem.i4           // arr[2] = 15            

            // load data dari elemen array
            ldloc.0
            ldc.i4      2
            ldelem.i4           // arr[2]

            pop
            pop
            ret 
        }
    }
}

/*
    Inisialisasi Array pada .NET 
    .NET mendefinisikan sebuah class untuk menampung referensi menuju data statis dan resource.
*/

.class  private auto ansi abstract sealed beforefieldinit 
        DataWrapper extends [mscorlib]System.Object 
{
    .custom instance void class [mscorlib]System.Runtime.CompilerServices.CompilerGeneratedAttribute::'.ctor'() =  (01 00 00 00 )

    .field  assembly static initonly  valuetype DataWrapper/ArrType_40 fld_array_int at D_initarr

    .class  nested private sequential ansi sealed beforefieldinit 
            ArrType_40 extends [mscorlib]System.ValueType 
    {
        .pack 1
        .size 40
    }
} 

.data D_initarr = bytearray (
    00 00 00 00 01 00 00 00 02 00 00 00 03 00 00 00
    04 00 00 00 05 00 00 00 06 00 00 00 07 00 00 00
    08 00 00 00 09 00 00 00
)