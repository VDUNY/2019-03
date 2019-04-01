/*
Code Example
    https://docs.microsoft.com/en-us/quantum/quickstart?view=qsharp-preview&tabs=tabid-vs2017 
*/


/*
 * requires dotnet core 2.0 be installed.
 * requires microsoft quantum development kit be installed
 * will need to re-do the nuget refs in the sln exp to point to the .nuget loc on your machine
 */

using System;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.QSharpApplication1
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var qsim = new QuantumSimulator())
            {
                //  Each Q# operation generates a C# class with the same name. 
                // This class has a Run method that asynchronously executes the operation. 
                // The execution is asynchronous because execution on actual hardware will be asynchronous.
                // However, Result blocks execution until task completes; return synchronously
                var res = HelloQ.Run(qsim).Result;
            }
            System.Console.WriteLine("Press any key to continue...");
            System.Console.WriteLine("Next up: Superposition: ");
            Console.ReadKey();
                // work with superposition
            using (var qsim = new QuantumSimulator())
            {
                // Try initial values
                Result[] initials = new Result[] { Result.Zero, Result.One };
                foreach (Result initial in initials)
                {
                    // '.Result' blocks execution until the task completes and returns the result synchronously.
                    var res = Superposition.Run(qsim, 1000, initial).Result;
                    var (numZeros, numOnes) = res;
                    System.Console.WriteLine(
                        $"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4}");
                }
            }

            System.Console.WriteLine("Press any key to continue...");
            System.Console.WriteLine("Next up: Entanglement: ");
            Console.ReadKey();
                // work with entanglement
            using (var qsim = new QuantumSimulator())
            {
                Result[] initials = new Result[] { Result.Zero, Result.One };
                foreach (Result initial in initials)
                {
                    var res = Entanglement.Run(qsim, 1000, initial).Result;
                    var (numZeros, numOnes, agree) = res;
                    System.Console.WriteLine(
                        $"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4} agree={agree,-4}");
                }
            }

            System.Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }
    } // class Driver

} // namespace Quantum.QSharpApplication1