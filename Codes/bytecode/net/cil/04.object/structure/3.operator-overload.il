/*
    Operator Overload

Assembling:
    $ ilasm operator-overload.il

*/

//-----------------------------------------------------------------------------

.assembly extern mscorlib { auto }
.assembly 'operator-overload' { }
.module 'program.exe'


/*
    Operator Overload
    C# dan .NET CIL mendukung pendefinisian ulang (overload) terhadap operator 
    built-in. Overload memungkinkan untuk memberikan perilaku berbeda pada
    operator. Operator merupakan method dengan nama khusus dan perilaku yang
    ditetapkan hanya berlaku bagi objek Class yang mendefinisikan.

    Operator yang diperbolehkan:
        - unary: + - ! ~ ++ --
        - binary: + - * / % == != < > <= >=
*/

.namespace RevID
{
    .class  public
            Sample extends [mscorlib]System.Object 
    {
        .field  private int32 _data

        .method public specialname rtspecialname instance 
                void '.ctor' () cil managed 
        {
            .maxstack 8
            ldarg.0
            call        instance void object::'.ctor' ()

            // this._data = 0
            ldarg.0
            ldc.i4.0
            stfld       int32 RevID.Sample::_data 

            ret 
        }

        // Deklarasi overload operator ++
        // Semua overload operator harus bersifat Static
        // Method mengembalikan object Sample
        .method public static specialname 
                class RevID.Sample op_Increment (class RevID.Sample self) 
                cil managed 
        {
            .maxstack 8

            // self._data = self._data + 1
            ldarg.0
            dup
            ldfld       int32 RevID.Sample::_data 
            ldc.i4.1
            add
            stfld       int32 RevID.Sample::_data 

            // return self
            ldarg.0
            ret 
        }
    }

    .class  public 
            Program extends [mscorlib]System.Object
    {
        .method public static
                void Main() cil managed 
        {
            .entrypoint
            .maxstack 8

            .locals init (
                class RevID.Sample  sample
            )

            // instansiasi objek
            newobj      instance void class RevID.Sample::'.ctor' ()
            stloc       sample

            // pemanggilan operator
            ldloc       sample 
            call        class RevID.Sample class RevID.Sample::op_Increment(class RevID.Sample)
            stloc       sample             

            ret 
        }
    }
}

/*
Daftar pemetaan operator dan method 

Unary 
---
    +       class RevID.Sample op_UnaryPlus (class RevID.Sample)      
    -       class RevID.Sample op_UnaryNegation (class RevID.Sample)      
    !       class RevID.Sample op_LogicalNot (class RevID.Sample)      
    ~       class RevID.Sample op_OnesComplement (class RevID.Sample)      
    ++      class RevID.Sample op_Increment (class RevID.Sample)
    --      class RevID.Sample op_Decrement (class RevID.Sample)

Binary
---
Arithmetic
    +       class RevID.Sample op_Addition (class RevID.Sample, class RevID.Sample) 
    -       class RevID.Sample op_Subtraction (class RevID.Sample, class RevID.Sample) 
    *       class RevID.Sample op_Multiply (class RevID.Sample, class RevID.Sample) 
    /       class RevID.Sample op_Division (class RevID.Sample, class RevID.Sample) 
    %       class RevID.Sample op_Modulus  (class RevID.Sample, class RevID.Sample)

Relational
    ==      class bool op_Equality      (class RevID.Sample, class RevID.Sample)
    !=      class bool op_Inequalyty    (class RevID.Sample, class RevID.Sample) 
    <       class bool op_LessThan      (class RevID.Sample, class RevID.Sample) 
    >       class bool op_GreaterThan   (class RevID.Sample, class RevID.Sample) 
    <=      class bool op_LessThanOrEqual (class RevID.Sample, class RevID.Sample) 
    >=      class bool op_GreaterThanOrEqual (class RevID.Sample, class RevID.Sample)
*/