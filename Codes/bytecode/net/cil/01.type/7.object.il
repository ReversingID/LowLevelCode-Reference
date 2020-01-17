/*
    Class - Object
    .NET CIL Data Type 

    Deklarasi, instansiasi, dan eksekusi.

Assembling:
    $ ilasm object.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'object' { }
.module   'program.exe'


/*
    Object 
    Object adalah perwujudan konkret dari suatu Class di memory, sebagai entitas
    mandiri. Object-object yang dicetak dari Class yang sama akan bersifat saling lepas 
    dengan masing-masing Object memiliki atribut atau properti tersendiri yang tidak
    akan saling mempengaruhi.
*/

.namespace RevID
{
    /*
        Sebuah Object di .NET diturunkan dari [mscorlib]System.Object
    */
    .class  private
            rectangle_t extends [mscorlib]System.Object
    {
        .field public float64  length
        .field public float64  width

        .method public instance 
                void '.ctor' (float64 length, float64 width) cil managed 
        {
            .maxstack 8

            // memanggil constructor Parent Class untuk konstruksi object
            ldarg.0
            call    instance void object::'.ctor'()

            // -- inisialisasi field -- 
            ldarg.0
            ldarg.1
            stfld   float64 RevID.rectangle_t::length

            ldarg.0
            ldarg.2
            stfld   float64 RevID.rectangle_t::width

            ret 
        }

        .method public instance 
                float64 getArea () cil managed
        {
            .maxstack 8

            /*
                Akses terhadap variabel instance dilakukan dengan melakukan
                push terhadap ldarg.0 yang merepresentasikan reference ke "this".
            */

            ldarg.0
            ldfld   float64     RevID.rectangle_t::length
            ldarg.0
            ldfld   float64     RevID.rectangle_t::width
            mul 
            ret 
        }
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
                class   RevID.rectangle_t   l_rect
            )

            // -- instansiasi --
            // l_rect = new rectangle_t (4.5, 3.5)
            ldc.r8      4.5
            ldc.r8      3.5 
            newobj      instance void class RevID.rectangle_t::'.ctor' (float64, float64)
            stloc.0

            // -- load nilai dari field --
            ldloc.0                     // objek didefinisikan di lokal
            ldfld       float64 RevID.rectangle_t::width

            // -- store nilai ke field --
            ldloc.0                     // objek didefinisikan di lokal
            ldc.r8      7
            stfld       float64 RevID.rectangle_t::length

            // -- method calling --
            ldloc.0
            callvirt    instance float64 class RevID.rectangle_t::getArea()

            pop                         // bersihkan stack
            pop

            ret 
        }
    }
}