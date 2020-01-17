/*
    Method

    .NET IL terdiri atas beberapa komponen yang tersusun secara terstruktur
    dengan berorientasi objek.

Assembling:
    $ ilasm method.il

*/

//-----------------------------------------------------------------------------

// -- Assembly Declaration --
.assembly extern mscorlib { auto }
.assembly 'method' { }
.module 'program.exe'


/*
    Method / Function
    Sebuah method merupakan kumpulan instruksi yang diidentifikasi sebagai 
    entitas tersendiri berdasarkan nama. Sebuah method berasosiasi dengan 
    objek untuk membentuk operasi yang dapat dilakukan. Umumnya method 
    digunakan untuk memanipulasi nilai di objek.
    
    Method terdiri atas beberapa komponen:
        - Argument
        - Code
        - Return value (jika ada)
    
    Terdapat tiga jenis method:
        - instance method 
        - static method 
        - virtual method

    Pada badan method terdapat dua kategori item:
        - instruksi, yang akan diubah (compile) menjadi IL code 
        - directive, yang akan diubah (compile) menjadi metadata, header setting,
            managed exception handling clauses, dll.
    

    Type Signature
    Type Signature atau Type Annotation menyatakan tipe yang menjadi penanda
    suatu method, identifikasi unik suatu method.
    Terdiri atas dua komponen utama:
        - tipe return value 
        - method reference 
        - tipe dan jenis (value, reference, output) tiap argumen
    
    Beberapa instruksi menggunakan Type Signature sebagai MethodRef atau 
    mengidentifikasi method. Format umum:

        RetVal   [AssemblyRef] Namespace.ClassName :: MethodName (ArgTypeList)
*/

// -- Namespace Declaration --
.namespace RevID
{
    // -- Class Declaration --
    .class  public auto ansi beforefieldinit 
            Program extends [mscorlib]System.Object
    {
        // Instance Method
        // Method yang terikat pada objek, membutuhkan objek (instance sebuah Class) 
        // ketika dipanggil.
        // Digunakan untuk memanipulasi data pada objek spesifik.
        .method public hidebysig instance default 
                void mtd_instance () cil managed 
        {
            .maxstack 8
            ret   
        }
        // Signature: void RevID.Program::mtd_instance ()


        // Static Method
        // Method yang terikat pada Class, tidak membutuhkan objek ketika dipanggil.
        // Badan method hanya dapat mengakses static method lain, tidak dapat mengakses
        // Instance Method.
        .method public static hidebysig default 
                void mtd_static () cil managed 
        {
            .maxstack 8
            ret 
        }
        // Signature: void class RevID.Program::mtd_static ()


        // Virtual Method
        // Instance Method yang dapat didefinisikan ulang pada Class turunan.
        .method public virtual hidebysig newslot instance default 
                void mtd_virtual() cil managed 
        {
            .maxstack 8
            ret 
        }
        // Signature: void class RevID.Program::mtd_virtual ()


        // Main() adalah method khusus yang menjadi entrypoint bagi aplikasi.
        .method public static hidebysig 
                void Main() cil managed 
        {
            // entrypoint adalah user-defined method yang dieksekusi pertama kali.
            .entrypoint
            .maxstack 8
            ret 
        }
    } 
}