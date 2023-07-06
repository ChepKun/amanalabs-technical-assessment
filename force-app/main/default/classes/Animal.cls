public inherited sharing class Animal {

    private abstract class BaseAnimal {

        virtual protected Boolean roar() {
            // roaring behavior here
            return true;
        }

        virtual protected Boolean meow() {
            // meowing behavior here
            return true;
        }

        virtual protected Boolean neigh() {
            // neighing behavior here
            return true;
        }

        virtual protected Boolean hiss() {
            // hissing behavior here
            return true;
        }

        virtual protected Boolean growl() {
            // growling behavior here
            return true;
        }

        virtual protected Boolean moo() {
            // mooing behavior here
            return true;
        }

        virtual protected Boolean bark() {
            // barking behavior here
            return true;
        }

        virtual protected Boolean run() {
            // running behavior here
            return true;
        }

        virtual protected Boolean walk() {
            // walking behavior here
            return true;
        }

        virtual protected Boolean slide() {
            // sliding behavior here
            return true;
        }

        virtual protected Boolean doSwim() {
            // swimming behavior here
            return true;
        }
    
    }

    public interface IAnimal {
        
        Boolean makeNoise();

        Boolean move();

        Boolean swim();

    }

    public class Lion extends BaseAnimal implements IAnimal {

        public Boolean makeNoise() {
            return this.roar();
        }

        public Boolean move() {
            return this.run();
        }

        public Boolean swim() {
            return this.doSwim();
        }

    }

    public class Cat extends BaseAnimal implements IAnimal {

        public Boolean makeNoise() {
            return this.meow();
        }

        public Boolean move() {
            return this.walk();
        }

        public Boolean swim() {
            return false;
        }

    }

    public class Horse extends BaseAnimal implements IAnimal {

        public Boolean makeNoise() {
            return this.neigh();
        }

        public Boolean move() {
            return this.slide();
        }

        public Boolean swim() {
            return false;
        }

    }

    public class Alligator extends BaseAnimal implements IAnimal {

        public Boolean makeNoise() {
            return this.hiss();
        }

        public Boolean move() {
            return this.hiss();
        }

        public Boolean swim() {
            return this.doSwim();
        }

    }

    public class Bear extends BaseAnimal implements IAnimal {

        public Boolean makeNoise() {
            return this.growl();
        }

        public Boolean move() {
            return this.walk();
        }

        public Boolean swim() {
            return this.doSwim();
        }

    }

    public class Cow extends BaseAnimal implements IAnimal {

        public Boolean makeNoise() {
            return this.moo();
        }

        public Boolean move() {
            return this.walk();
        }

        public Boolean swim() {
            return false;
        }

    }

    public class Dog extends BaseAnimal implements IAnimal {

        public Boolean makeNoise() {
            return this.bark();
        }

        public Boolean move() {
            return this.run();
        }

        public Boolean swim() {
            return this.doSwim();
        }

    }

}
