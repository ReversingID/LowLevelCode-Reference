/*
    Platform Invoke

Assembling:
    $ilasm pinvoke.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'call' { }
.module 'program.exe'


/*
    P/Invoke
    P/Invoke, atau Platform Invoke, adalah teknologi yang memungkinkan aplikasi 
    managed  code untuk mengakses struct, callback, dan function di library unmanaged.

    Unmanaged code yang umumnya terletak di library eksternal akan dipetakan sebagai
    ke dalam managed code sebagai method maupun struktur yang ekivalen. Selanjutnya,
    pemanggilan terhadap method tersebut akan diteruskan kepada kode yang sesuai.
*/

.namespace RevID
{
    .class  public 
            Program extends [mscorlib]System.Object
    {
        // -- PInvoke Declaration --
        // Memetakan MessageBox di User32.dll sebagai MsgBox
        .method assembly static pinvokeimpl ("User32.dll" as "MessageBox" autochar winapi)
                int32 MsgBox (int32 hwnd, string text, string caption, unsigned int32 tipe) cil managed preservesig
        { }

        .method public static
                void Main() cil managed 
        {
            .entrypoint
            .maxstack 8

        // Memanggil MsgBox, meneruskan ke MessageBox
            ldc.i4.0
            ldstr       "Text"
            ldstr       "Caption"
            ldc.i4.0
            call        int32 class RevID.Program::MsgBox(int32, string, string, unsigned int32)

            pop
            ret 
        }
    }
}