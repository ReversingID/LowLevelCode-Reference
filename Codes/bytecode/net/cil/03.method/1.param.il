/*
    Parameter

    Tipe parameter sebuah method

Assembling:
    $ ilasm param.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'param' { }
.module 'program.exe'


/*
    Parameter 
    Parameter adalah variabel khusus yang digunakan dalam method, merujuk kepada 
    nilai yang diberikan sebagai input untuk method tersebut.
    
    C# dan CIL memiliki perbedaan pada mekanisme parameter, dimana CIL memiliki 
    tipe reference dan instruksi yang dapat secara langsung memanipulasi alamat
    seperti C++.
*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object
    {
        .method public static
                void mt_none () cil managed 
        {
            .maxstack 8

            ret 
        }
        // Signature: void class RevID.Program::mt_none ()
        
        .method public static
                void mt_param (int32 arg) cil managed 
        {
            .maxstack 8

            .locals init (
                int32   l_int
            )

            // load argumen ke stack dan pindahkan ke variabel lokal
            ldarg.0             // [arg]
            stloc.0             // []

            ret 
        }
        // Signature: void class RevID.Program::mt_param ()

        .method public static
                void mt_ref (int32& arg) cil managed 
        {
            .maxstack 8

            .locals init (
                int32   l_int 
            )

            // load nilai dari argumen ke Stack dan pindahkan ke variabel lokal
            ldarg.0             // [arg&]
            ldind.i4            // [arg]
            stloc.0             // []

            // simpan nilai dari Stack ke parameter 
            ldarg.0             // [arg&]
            ldloc.0             // [l_int, arg&]
            stind.i4            // []

            ret 
        }
        // Signature: void class RevID.Program::mt_ref (int32&)


        // Method dengan parameter struct
        .method public static 
                void mt_strct (valuetype RevID.struct_t arg) cil managed 
        {
            .maxstack 8

            .locals init (
                valuetype RevID.struct_t l_strct
            )

            // load nilai dari argumen ke Stack dan pindahkan ke variabel lokal
            ldarg.0
            stloc.0

            ret 
        }
        // Signature: void class RevID.Program::mt_strct (valuetype RevID.struct_t)
        
        // Method dengan parameter enum
        .method public static 
                void mt_enum (valuetype RevID.enum_t arg) cil managed 
        {
            .maxstack 8

            .locals init (
                valuetype RevID.enum_t l_enum
            )

            // load nilai dari argumen ke Stack dan pindahkan ke variabel lokal
            ldarg.0
            stloc.0

            ret 
        }
        // Signature: void class RevID.Program::mt_strct (valuetype RevID.struct_t)

        // Method dengan parameter struct
        .method public static 
                void mt_class (class RevID.class_t arg) cil managed 
        {
            .maxstack 8

            .locals init (
                class RevID.class_t l_strct
            )

            // load nilai dari argumen ke Stack dan pindahkan ke variabel lokal
            ldarg.0
            stloc.0

            ret 
        }
        // Signature: void class RevID.Program::mt_strct (valuetype RevID.struct_t)
        

        .method public static
                void Main() cil managed 
        {
            .entrypoint
            .maxstack 8

            .locals init (
                int32       l_int,
                valuetype RevID.struct_t     l_strct
            )

        // -- Method Call (Static) --
            // pemanggilan method tanpa argumen
            call        void class RevID.Program::mt_none ()

            // pemanggilan method dengan parameter primitif
            ldc.i4      135
            call        void class RevID.Program::mt_param (int32)
            
            // pemanggilan method dengan out parameter
            ldc.i4      135
            stloc.0
            ldloca.s    0
            call        void class RevID.Program::mt_ref (int32&)

            // pemanggilan method dengan parameter struct
            ldloca      l_strct
            initobj     RevID.struct_t
            ldloc       l_strct
            call        void class RevID.Program::mt_strct (valuetype RevID.struct_t)
            
            // pemanggilan method dengan parameter enum
            ldc.i4      0           // enum_t._token1
            call        void class RevID.Program::mt_enum (valuetype RevID.enum_t)

            // pemanggilan method dengan 
            newobj      instance void class RevID.class_t::'.ctor' ()
            call        void class RevID.class_t::mt_class (class RevID.class_t)
            
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
    
//-----------------------------------------------------------------------------
// -- class --

    .class  public 
            class_t extends [mscorlib]System.Enum 
    {
        .method public instance 
                int32 mt_none () cil managed 
        {
            .maxstack 8

            ldc.i4      135
            ret
        }
    }
}