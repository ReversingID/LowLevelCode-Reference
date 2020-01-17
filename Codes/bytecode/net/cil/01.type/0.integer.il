/*
    Integer
    .NET CIL Data Type 

    Bilangan bulat dan operasinya.

Assembling:
    $ ilasm integer.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'integer' { }
.module   'program.exe'


/*
    Integer
    Integer atau bilangan bulat adalah bilangan yang dapat diekspresikan tanpa 
    komponen pecahan.
    Bilangan bulat dapat memiliki 3 kemungkinan nilai:
        - bilangan bulat positif: 1, 2, 3, ...
        - bilangan bulat negatif: -1, -2, -3, ...
        - nol 

    Secara matematis, bilangan bulat dapat mencapai nilai tak terhingga (positf/negatif)
    Namun dalam komputer dan mesin digital umumnya, bilangan bulat direpresentasikan dalam
    rentang yang terbatas. Batas nilai yang dapat ditampung tergangung kepada panjang data 
    yang dapat dioperasikan oleh mesin tersebut (dalam bit). Antar mesin dapat memiliki
    kapasitas yang berbeda.
*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object
    {
        /*
            Sebuah integer dideklarasikan dengan sintaks intN, dimana N adalah panjang bit integer.

            Beberapa integer yang umum: int8, int16, int32, int64

            Terdapat dua jenis integer, yakni signed dan unsigned.
            Sebuah angka dapat bernilai positif dan negatif. 
            Signed integer adalah bilangan bulat yang dapat menampung nilai negatif dan positif.
            Unsigned integer adalah bilangan bulat yang hanya dapat menampung nilai positif.  
        */

        // -- Deklarasi variabel global --
        // sign integer
        .field  public int8     g_i8
        .field  public int16    g_i16
        .field  public int32    g_i32
        .field  public int64    g_i64

        // unsigned integer
        .field  public unsigned int8    g_s8
        .field  public unsigned int16   g_s16
        .field  public unsigned int32   g_s32
        .field  public unsigned int64   g_s64


        .method public static
                void Main () cil managed
        {
            .entrypoint
            .maxstack 8
            ret
        }


        .method public instance 
                void _algorithm () cil managed 
        {
            .maxstack 8

            // alokasi local variable
            .locals init (
            // signed integer
                int8    var_0,                  // sbyte
                int16   var_1,                  // short
                int32   var_2,                  // int
                int64   var_3,                  // long
            
            // unsigned integer
                unsigned int8       var_4,      // byte
                unsigned int16      var_5,      // ushort
                unsigned int32      var_6,      // uint
                unsigned int64      var_7       // ulong
            )

            ldc.i4.1        // [1]

        /*
            Store (simpan) nilai ke variabel akan mengambil nilai di puncak Stack.
            Load (muat) nilai dari variabel akan menaruh nilai ke puncak Stack.

            Sebuah variabel dapat diidentifikasi berdasarkan indeks deklarasi dan nama.
            Akses melalui indeks hanya berlaku untuk variabel dengan indeks 0 hingga 3.
            
            Apabila nilai disimpan ke dalam tipe yang lebih pendek (int32 disimpan ke int8)
            maka truncate akan terjadi. Nilai akan dipotong hingga sesuai dengan tipe.
        */
        // simpan nilai ke variabel
            stloc.0
            stloc       var_1

        // memuat nilai dari variabel
            ldloc.0
            ldloc       var_1
        
        // memuat alamat dari variabel
            ldloca      var_1
            
        // load nilai konstan integer (int32)
            ldc.i4      135   


            ret 
        }
    }
}