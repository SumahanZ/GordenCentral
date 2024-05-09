// And that’s the beauty of unit tests! You can test the logic of the functions without even running the app.
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/auth_repository_impl.dart';

void main() {
  //2 parameters of "test": 1. Description, 2. Body where test is executed
  test('Divide with valid dividend and valid divisor', () {
    //arrange, act, and assert here!

    //ARRANGE (Prepare the data, dependencies, input, the class, etc)
    DivisionService divisionService = DivisionService();
    int dividend = 10;
    int divisor = 5;

    //ACT (Run the methods which you want to test)
    final quotient = divisionService.divide(dividend, divisor);

    //ASSERT (Check and expect the output returned)
    //This method has two required parameters, actual and matcher. We can pass our result from the divide method to the actual parameter, and the output we expect in the matcher parameter.
    //If the returned value from the divide method is different than what we expect in the matcher parameter, the expect method will throw an error and the test will fail. Otherwise, the test will pass.
    expect(quotient, 2);
  });

  test('Divide with valid dividend and valid divisor - 2', () {
    //ARRANGE
    DivisionService divisionService = DivisionService();
    int dividend = 10;
    int divisor = 1;

    //ACT
    final quotient = divisionService.divide(dividend, divisor);

    //ASSERT
    expect(quotient, 10);
  });

  test('Divide with valid dividend and valid divisor - 3', () {
    //ARRANGE
    DivisionService divisionService = DivisionService();
    int dividend = 10;
    int divisor = 0;

    //ACT
    final quotient = divisionService.divide(dividend, divisor);

    //ASSERT
    expect(quotient, 0);
  });
}

// Ground rules for unit testing

// The unit should be logically isolated
// If two unit tests run simultaneously, the execution of one should not impact the execution of the other.
// Unit tests should not talk to an actual database, network, file system, system configuration, or any external dependency. The sole purpose should be to test the code inside the unit, not how it impacts other units.
// Unit tests should not have conditional or loop statements (no if else and for ). This reduces the readability of the test.
// Tests should be fast. If they are not fast, well, you won’t run them often.
// Tests should not include complex logic, they should prepare some data — AKA arrange, execute a method — AKA act, and expect some output in return — AKA assert.
// A single test should verify a single behavior. If we are writing a test to check addition, it should only cover one specific case of addition from x number of cases.

//Conclusion
// Unit testing gives you confidence
// It helps you write cleaner code.
// It helps you cover multiple scenarios, making sure your units don’t break
// Testing with multiple inputs can help you cover unseen edge cases that you might not have thought about otherwise.
// It helps you debug code easier.
// It helps you document your code
// And much, much more once you get into it
