/*
    Enumeration
    .NET CIL Data Type 

    Enumerasi dan nilai dalam rentang tertentu.

Assembling:
    $ ilasm enumeration.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'enumeration' { }
.module   'program.exe'


/*
    Enumeration 
    Sekumpulan konstanta bilangan bulat (integer) yang diidentifikasi dengan token.
    Enum adalah value data type, mengandung nilai sendiri dan tidak dapat diwariskan.
*/

.namespace RevID
{
    /*
        Enum merupakan Class dengan karakteristik tertentu dan digunakan 
        hanya sebagai tipe data.

        Enum diturunkan dari [mscorlib]System.Enum
    */
    .class  private 
            month_t extends [mscorlib]System.Enum
    {
        .field  public specialname rtspecialname int32 value__
        .field  public static literal valuetype RevID.month_t Jan = int32(0)
        .field  public static literal valuetype RevID.month_t Feb = int32(1)
        .field  public static literal valuetype RevID.month_t Mar = int32(2)
        .field  public static literal valuetype RevID.month_t Apr = int32(3)
        .field  public static literal valuetype RevID.month_t May = int32(4)
        .field  public static literal valuetype RevID.month_t Jun = int32(5)
        .field  public static literal valuetype RevID.month_t Jul = int32(6)
        .field  public static literal valuetype RevID.month_t Aug = int32(7)
        .field  public static literal valuetype RevID.month_t Sep = int32(8)
        .field  public static literal valuetype RevID.month_t Oct = int32(9)
        .field  public static literal valuetype RevID.month_t Nov = int32(10)
        .field  public static literal valuetype RevID.month_t Dec = int32(11)
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
                valuetype   RevID.month_t   ls_month
            )

            // -- assignment nilai --
            ldc.i4.s    7               // month_t::Aug
            stloc.0
            
            ret 
        }
    }
}