/*
    Pointer
    .NET CIL Data Type 

    Pointer dan akses data secara tak langsung.

Assembling:
    $ ilasm pointer.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'pointer' { }
.module   'program.exe'


/*
    Pointer 
    Entitas yang menyimpan alamat memory dari nilai atau entitas lain.
    .NET CIL mendefinisikan dua jenis pointer untuk mengakses memory di CLR, yaitu:
        - managed pointer 
        - unmanaged pointer 
    
    Managed Pointer adalah pointer yang menunjuk ke objek yang valid dan melakukan 
    operasi terhadapnya. Pointer ini dipastikan menunjuk ke awal dari objek.
    Managed Pointer dapat menunjuk ke:
        - variabel lokal: baik reference ke objek yang dialokasikan di Heap atau 
          dialokasikan di Stack.
        - parameter
        - field dari tipe majemuk
        - elemen dari array

    Unmanaged Pointer adalah pointer raw yang dapat secara bebas menunjuk ke alamat 
    apapun.
*/

.namespace RevID
{
    .class  public
            Program extends [mscorlib]System.Object
    {
        .method public static
                void Main () cil managed
        {
            .entrypoint
            .maxstack 8

            .locals init (
                int32   var,
                int32[] arr,        // array
                int32*  ptr,        // pointer
                int32&  pinned ref  // pinning oleh GC
            )

            ldc.i4      5
            newarr      [mscorlib]System.Int32 
            stloc       arr

        // Pointer -> Variabel
            // Store Address
            // menyimpan alamat dari var ke ptr
            ldloca      var
            stloc       ptr     // ptr = &var

            // Indirect store
            // mengubah nilai var secara tak langsung
            ldloc       ptr 
            ldc.i4      15
            stind.i4            // *ptr = 15

            // Indirect load
            // mendapatkan nilai var secara tak langsung
            ldloc       ptr 
            ldind.i4


        /*
            Reference yang berada dalam status pinned tidak akan otomatis dibersihkan
            oleh Garbage Collector.
        */
        
            // pinning
            ldloc       arr 
            ldc.i4      0
            ldelema     [mscorlib]System.Int32 
            stloc       ref

        // Pointer -> Array
            // menunjuk elemen pertama yang telah di-pin
            ldloc       ref 
            stloc       ptr

            // menunjuk elemen dengan index tertentu
            ldloc       arr 
            ldc.i4      3
            ldelema     [mscorlib]System.Int32 
            stloc       ptr     // ptr = &arr[3]

            // maju ke elemen berikutnya
            // pastikan ukuran elemen tepat
            ldloc       ptr
            ldc.i4      4       // menunjuk ke int32 (4 byte)
            add 
            stloc       ptr


            ret 
        }
    }
}