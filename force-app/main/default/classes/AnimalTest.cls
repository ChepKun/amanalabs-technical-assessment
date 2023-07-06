@IsTest
private class AnimalTest {

    @IsTest
    static void animalLionTest() {
        Test.startTest();
        Animal.IAnimal testTarget = new Animal.Lion();
        Test.stopTest();
        System.assertEquals(true, testTarget.makeNoise(), 'This animal should make noise.');
        System.assertEquals(true, testTarget.move(), 'This animal should be able to move.');
        System.assertEquals(true, testTarget.swim(), 'This animal should be able to swim.');
    }

    @IsTest
    static void animalCatTest() {
        Test.startTest();
        Animal.IAnimal testTarget = new Animal.Cat();
        Test.stopTest();
        System.assertEquals(true, testTarget.makeNoise(), 'This animal should make noise.');
        System.assertEquals(true, testTarget.move(), 'This animal should be able to move.');
        System.assertEquals(false, testTarget.swim(), 'This animal should not be able to swim.');
    }


    @IsTest
    static void animalHorseTest() {
        Test.startTest();
        Animal.IAnimal testTarget = new Animal.Horse();
        Test.stopTest();
        System.assertEquals(true, testTarget.makeNoise(), 'This animal should make noise.');
        System.assertEquals(true, testTarget.move(), 'This animal should be able to move.');
        System.assertEquals(false, testTarget.swim(), 'This animal should not be able to swim.');
    }

    @IsTest
    static void animalAlligatorTest() {
        Test.startTest();
        Animal.IAnimal testTarget = new Animal.Alligator();
        Test.stopTest();
        System.assertEquals(true, testTarget.makeNoise(), 'This animal should make noise.');
        System.assertEquals(true, testTarget.move(), 'This animal should be able to move.');
        System.assertEquals(true, testTarget.swim(), 'This animal should be able to swim.');
    }

    @IsTest
    static void animalBearTest() {
        Test.startTest();
        Animal.IAnimal testTarget = new Animal.Bear();
        Test.stopTest();
        System.assertEquals(true, testTarget.makeNoise(), 'This animal should make noise.');
        System.assertEquals(true, testTarget.move(), 'This animal should be able to move.');
        System.assertEquals(true, testTarget.swim(), 'This animal should be able to swim.');
    }

    @IsTest
    static void animalCowTest() {
        Test.startTest();
        Animal.IAnimal testTarget = new Animal.Cow();
        Test.stopTest();
        System.assertEquals(true, testTarget.makeNoise(), 'This animal should make noise.');
        System.assertEquals(true, testTarget.move(), 'This animal should be able to move.');
        System.assertEquals(false, testTarget.swim(), 'This animal should not be able to swim.');
    }

    @IsTest
    static void animalDogTest() {
        Test.startTest();
        Animal.IAnimal testTarget = new Animal.Dog();
        Test.stopTest();
        System.assertEquals(true, testTarget.makeNoise(), 'This animal should make noise.');
        System.assertEquals(true, testTarget.move(), 'This animal should be able to move.');
        System.assertEquals(true, testTarget.swim(), 'This animal should be able to swim.');
    }

}
