/*
    Module

    .NET IL terdiri atas beberapa komponen yang tersusun secara terstruktur
    dengan berorientasi objek.

Assembling:
    $ ilasm module.il

*/

//-----------------------------------------------------------------------------

/*
    .NET Assembly 
    Assembly adalah unit hasil kompilasi, dapat berupa executable maupun 
    shared library.

    .NET Module 
    Module merupakan himpunan kode secara logic di dalam Assembly.
    Module terdiri atas beberapa Class.
*/

/*
    Directive .assembly menyatakan metadata sebuah Assembly Reference (AssemblyRef).
    Sebuah assembly dapat berupa assembly eksternal maupun assembly untuk module 
    tersebut.

    Atribut eksternal menyatakan bahwa Assembly berada di luar Assembly ini.

    Assembly diidentifikasi dengan nama file tanpa ekstensi.
*/

// mscorlib, shared library inti dari .NET
.assembly extern mscorlib
{
    // informasi tambahan terkait assembly disebutkan di sini
    .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
    .ver 4:0:0:0
}

// assembly untuk module ini.
.assembly 'module'
{
    .custom instance void [mscorlib]System.Runtime.CompilerServices.RuntimeCompatibilityAttribute::.ctor() = ( 
        01 00 01 00 54 02 16 57 72 61 70 4E 6F 6E 45 78   // ....T..WrapNonEx
        63 65 70 74 69 6F 6E 54 68 72 6F 77 73 01 )       // ceptionThrows.

    .hash   algorithm 0x00008004
    .ver    0:0:0:0
}


// Directive .module digunakan sebagai identifikasi module ini.
.module 'program.exe'

// -- Namespace Declaration -- 
.namespace RevID
{
    // -- Class Declaration --
    .class  public auto ansi beforefieldinit 
            Program extends [mscorlib]System.Object
    {
        .method public static hidebysig 
                void Main() cil managed 
        {
            // entrypoint adalah user-defined method yang dieksekusi pertama
            // kali dieksekusi.
            .entrypoint
            .maxstack 8
            ret 
        }
    } 
}

// -- Global Items Declaration --
// deklarasi semua item yang digunakan global terhadap modul ini.

// Data
.field  public static valuetype CharArray8 resource at AddrResource
.data   AddrResource = bytearray(01 02 03 04 00 00 00 00)
.class  public explicit CharArray8
        extends [mscorlib]System.ValueType { .size 8 }
    
// Unmanaged code
.method public static pinvokeimpl("library.dll" cdecl)
        int32 native_function () cil managed { }
