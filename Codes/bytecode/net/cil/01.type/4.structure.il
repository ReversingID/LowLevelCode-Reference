/*
    Structure
    .NET CIL Data Type 

    Structure dan tipe komposit.

Assembling:
    $ ilasm structure.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'structure' { }
.module   'program.exe'


/*
    Structure
    Kumpulan beberapa data dengan tipe yang dapat berlainan dan dianggap sebagai satu kesatuan.

    Structure akan menempati ruang memori secara kontigu.

    Tidak ada batasan banyaknya komponen yang membentuk sebuah struktur. Komponen 
    struktur atau field dapat berupa tipe dasar (integer, float, dsb) maupun tipe 
    agregasi lain (struct, array, dsb).

    Setiap komponen dapat diakses (load/store) secara individu.
*/

.namespace RevID
{
    /*
        Structure merupakan Class dengan karakteristik tertentu dan digunakan 
        hanya sebagai data.

        Struktur diturunkan dari [mscorlib]System.ValueType
    */
    .class  private sequential
            book_t extends [mscorlib]System.ValueType
    {
        .field  public  string  title
        .field  public  string  author
        .field  public  string  subject
        .field  public  int32   id
    }

    .class  public
            Program extends [mscorlib]System.Object
    {
        .method public static
                void Main () cil managed
        {
            .entrypoint
            .maxstack 8

            // -- alokasi variabel lokal --
            .locals init (
                valuetype   RevID.book_t    l_book
            )

            // -- instansiasi objek --
            ldloca.s    0                   // load address dari variabel lokal 
            initobj     RevID.book_t        // inisialisasi objek di alamat tujuan

            // -- akses field --
            // store
            ldloca.s    0
            ldstr       ".NET CIL Reversing"
            stfld       string RevID.book_t::title 

            ldloca.s    0
            ldc.i4      6495407
            stfld       int32 RevID.book_t::id

            // load
            ldstr       "Book title: {0}"
            ldloca.s    0
            ldfld       string RevID.book_t::title 
            call        void class [mscorlib]System.Console::WriteLine(string, object)
            
            ldstr       "Book id: {0}"
            ldloca.s    0
            ldfld       int32 RevID.book_t::id 
            box         [mscorlib]System.Int32 
            call        void class [mscorlib]System.Console::WriteLine(string, object)

            ret 
        }
    }
}