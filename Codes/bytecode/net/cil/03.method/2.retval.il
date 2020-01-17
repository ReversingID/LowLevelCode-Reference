/*
    Return Value

    Beragam kemungkinan nilai kembalian sebuah method.

Assembling:
    $ ilasm retval.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'retval' { }
.module 'program.exe'


/*
    Return Value
    Return Value (nilai kembalian) adalah sebuah nilai yang dihasilkan oleh 
    sebuah method setelah menyelesaikan eksekusi.

    Method dapat mengembalikan nilai tunggal, berupa ValueType maupun RefType.
    Nilai yang dikembalikan oleh sebuah method akan disimpan di evaluation stack.
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

        // tidak menghasilkan nilai apapun
        .method public static 
                void mt_none () cil managed 
        {
            .maxstack 8
            ret 
        }

        // menghasilkan nilai natif dan primitif 
        .method public static 
                int32 mt_i32 () cil managed 
        {
            .maxstack 8

            // load konstanta in32 sebagai return value
            ldc.i4      135
            ret 
        }

        // menghasilkan nilai reference ke objek
        .method public static 
                valuetype RevID.struct_t 
                mt_strct () cil managed 
        {
            .maxstack 8

            .locals init (
                valuetype RevID.struct_t retval
            )

            // bangun objek baru yang ditampung dalam variabel
            ldloca      retval 
            initobj     RevID.struct_t

            // load objek sebagai return value
            ldloc       retval 
            ret 
        }

        // menghasilkan nilai dari enum
        .method public static 
                valuetype RevID.enum_t 
                mt_enum () cil managed 
        {
            .maxstack 8

            // nilai dari setiap token di enum dapat dianggap sebagai integer

            ldc.i4      0
            ret 
        }

        // menghasilkan array tipe primitif
        .method public static 
                int32 [] mt_arr () cil managed 
        {
            .maxstack 8

            // bangun array dengan kapasitas 10 elemen int32
            // reference ke array akan disimpan dalam Stack
            ldc.i4      10
            newarr      [mscorlib]System.Int32 

            // kembalikan reference ke array
            ret
        }
    }
    
//-----------------------------------------------------------------------------
// -- structure --

    .class  public 
            struct_t extends [mscorlib]System.ValueType 
    {
        .field  public int32 _field
    }
    
//-----------------------------------------------------------------------------
// -- enumeration --

    .class  public 
            enum_t extends [mscorlib]System.Enum 
    {
        .field  public specialname rtspecialname int32 value__
        .field  public static literal valuetype RevID.enum_t    _token1 = int32(0)
        .field  public static literal valuetype RevID.enum_t    _token2 = int32(1)
        .field  public static literal valuetype RevID.enum_t    _token3 = int32(2)
    }
}