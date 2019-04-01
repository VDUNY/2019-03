
// Q# doesn't require any type annotations for variables; the type of a variable is inferred by the compiler.
// Q# uses tuples as a way to pass multiple values, rather than using structures or records.
namespace Quantum.QSharpApplication1
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    
	// An operation is the basic unit of quantum execution in Q#. 
	// It is roughly equivalent to a function in C or C++ or Python, 
	// or a static method in C# or Java.
    operation HelloQ () : Unit 
	{
        Message("Hello quantum world!");
    }

	// set a qubit in a known state (Zero or One). We measure the qubit, 
	// if it's in the state we want, we leave it alone,
	// otherwise, we flip it with the X gate.
	operation Set (desired: Result, q1: Qubit) : Unit
    {
        let current = M(q1); // current equals the measured value in qubit q1
        if (desired != current)
        {
            X(q1); // flip the qubit; note there is NO superposition here.
        }
    } // 	operation Set (desired: Result, q1: Qubit) : Unit

	// The arguments to an operation are specified as a tuple, within parentheses. 
	// The return type of the operation is specified after a colon. 
	// In this case, the Set operation has no return, so it is marked as returning Unit. 
	operation Superposition (count : Int, initial: Result) : (Int, Int)
    {
		// A mutable variable's value may be changed using a set statement.
        mutable numOnes = 0;
        using (qubit = Qubit())
        {
			// loop for count iterations
            for (test in 1..count)
            {
			// set a specified initial value on a qubit 
                Set (initial, qubit);
				X(qubit); // flip the qubit. Still classical computing thru this point.

				H(qubit); //Instead of flipping the qubit all the way from 0 to 1, we will only flip it halfway. 
				// and then measure (M) the result. 
				// The let keyword is used to indicate the binding of an immutable variable.
                let res = M (qubit);

                // Count the number of ones we saw:
                if (res == One)
                {
					// statistics on how many ones measured 
                    set numOnes = numOnes + 1;
                }
            }
			// resets the qubit to a known state (Zero) before returning it 
			// allowing others to allocate this qubit in a known state. 
			// This is required by the using statement.
            Set(Zero, qubit);
        }

        // Return number of times we saw a |0> and number of times we saw a |1>
        return (count-numOnes, numOnes);
    } // operation Superposition (count : Int, initial: Result) : (Int, Int)

	// The arguments to an operation are specified as a tuple, within parentheses. 
	// The return type of the operation is specified after a colon. 
	// In this case, the Set operation has no return, so it is marked as returning Unit. 
	operation Entanglement (count : Int, initial: Result) : (Int, Int, Int)
    {
		// A mutable variable's value may be changed using a set statement.
        mutable numOnes = 0;
		mutable agree = 0;
        using (qubits = Qubit[2])
        {
			// loop for count iterations
            for (test in 1..count)
            {
			// set a specified initial value on a qubit 
                Set (initial, qubits[0]);
				Set (Zero, qubits[1]);

				H(qubits[0]); //Instead of flipping the qubit all the way from 0 to 1, we will only flip it halfway. 
				// Now we entangle qubits[1] with qubits[0]
				CNOT(qubits[0], qubits[1]);
				// The let keyword is used to indicate the binding of an immutable variable.
				// and then measure (M) the result. 
                let res = M (qubits[0]);

				if (M (qubits[1]) == res) 
                {
                    set agree = agree + 1;
                }

                // Count the number of ones we saw:
                if (res == One)
                {
					// statistics on how many ones measured 
                    set numOnes = numOnes + 1;
                }
            }
			// resets the qubit to a known state (Zero) before returning it 
			// allowing others to allocate this qubit in a known state. 
			// This is required by the using statement.
            Set(Zero, qubits[0]);
            Set(Zero, qubits[1]);
        }

        // Return number of times we saw a |0> and number of times we saw a |1>
        return (count-numOnes, numOnes, agree);
    } // operation Entanglement (count : Int, initial: Result) : (Int, Int)

} // namespace Quantum.QSharpApplication1
