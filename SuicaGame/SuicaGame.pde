ArrayList <Fruit> fruits = new ArrayList <Fruit>();
ArrayList <Fruit> addList = new ArrayList <Fruit>();
ArrayList <Fruit> removeList = new ArrayList <Fruit>();

void setup() {
    size(512, 512);
}

void draw() {
    background(128);
    for (Fruit fruit : addList) {
        fruits.add(fruit);
    }
    for (Fruit fruit : removeList) {
        fruits.remove(fruit);
    }
    for (Fruit fruit : fruits) {
        fruit.step();
        fruit.display();
    }
}

void mousePressed() {
    fruits.add(new Cherry(int(random(40,width - 40)),45));
}

class Fruit {
    PVector pos = new PVector();
    PVector vel = new PVector(0, 0);
    float radius, mass;
    final float g = 0.2;
    final float e = 0.2;
    Fruit(float x, float y) {
        pos.x = x;
        pos.y = y;
    }
    void display() {
        circle(pos.x, pos.y, radius * 2);
    }
    void collision(Fruit fruit) {
        PVector n = pos.copy().sub(fruit.pos).normalize();
        pos = fruit.pos.copy().add(n.copy().mult(fruit.radius + radius));
        float v1cos = vel.copy().dot(n);
        float v2cos = fruit.vel.copy().dot(n) *-  1.0;
        float totalMomentum = mass * v1cos + fruit.mass * v2cos;
        float relativeSpeedAfter = e * (v1cos + v2cos);
        float totalMass = mass + fruit.mass;
        vel.sub(n.copy().mult(PVector.dot(vel, n))).sub(n.copy().mult(( -totalMomentum + fruit.mass * relativeSpeedAfter) / totalMass));
        fruit.vel.add(n.copy().mult(PVector.dot(vel, n))).add(n.copy().mult(( -totalMomentum + mass * relativeSpeedAfter) / totalMass));
    }
    void step() {
        vel.y += g;
        pos.add(vel);
        
        for (Fruit fruit : fruits) {
            if (fruit == this) {continue;}
            if (pos.dist(fruit.pos) < radius + fruit.radius) {collision(fruit);}
        }
        
        if (pos.y > height - radius) { // bottom
            pos.y = height - radius;
            vel.y = -e * vel.y;
        } else if (pos.y < radius) {   // top
            println(pos);
            println("gameover");
            noLoop();
        }
        if (pos.x > width - radius) {  // right
            pos.x = width - radius;
            vel.x = -e * vel.x;
        } else if (pos.x < radius) {   // left
            pos.x = radius;
            vel.x = -e * vel.x;
        }
    }
}

class Cherry extends Fruit {
    Cherry(float x, float y) {
        super(x, y);
        super.radius = 10.0;
        super.mass = 1.0;
    }
    void collision(Fruit fruit) {
        super.collision(fruit);
        
    }
}

class Strawberry extends Fruit {
    Strawberry(float x, float y) {
        super(x, y);
        super.radius = 15.0;
        super.mass = 1.5;
    }
    void collision(Fruit fruit) {
        if (fruit instanceof Strawberry) {
            removeList.add(this);
            removeList.add(fruit);
            PVector newPos = fruit.pos.copy().add(pos).mult(0.5);
            addList.add(new Grapes(newPos.x, newPos.y));
        } else {
            super.collision(fruit);
        }
    }
}

class Grapes extends Fruit {
    Grapes(float x, float y) {
        super(x, y);
        super.radius = 25.0;
        super.mass = 2.5;
    }
    void collision(Fruit fruit) {
        if (fruit instanceof Grapes) {
            removeList.add(this);
            removeList.add(fruit);
            PVector newPos = fruit.pos.copy().add(pos).mult(0.5);
            addList.add(new Dekopon(newPos.x, newPos.y));
        } else {
            super.collision(fruit);
        }
    }
}

class Dekopon extends Fruit {
    Dekopon(float x, float y) {
        super(x, y);
        super.radius = 30.0;
        super.mass = 3.0;
    }
    void collision(Fruit fruit) {
        if (fruit instanceof Dekopon) {
            removeList.add(this);
            removeList.add(fruit);
            PVector newPos = fruit.pos.copy().add(pos).mult(0.5);
            addList.add(new Persimmon(newPos.x, newPos.y));
        } else {
            super.collision(fruit);
        }
    }
}

class Persimmon extends Fruit {
    Persimmon(float x, float y) {
        super(x, y);
        super.radius = 40.0;
        super.mass = 4.0;
    }
    void collision(Fruit fruit) {
        if (fruit instanceof Persimmon) {
            removeList.add(this);
            removeList.add(fruit);
            PVector newPos = fruit.pos.copy().add(pos).mult(0.5);
            addList.add(new Apple(newPos.x, newPos.y));
        } else {
            super.collision(fruit);
        }
    }
}

class Apple extends Fruit {
    Apple(float x, float y) {
        super(x, y);
        super.radius = 45.0;
        super.mass = 4.5;
    }
    void collision(Fruit fruit) {
        if (fruit instanceof Apple) {
            removeList.add(this);
            removeList.add(fruit);
            PVector newPos = fruit.pos.copy().add(pos).mult(0.5);
            addList.add(new Pear(newPos.x, newPos.y));
        } else {
            super.collision(fruit);
        }
    }
}

class Pear extends Fruit {
    Pear(float x, float y) {
        super(x, y);
        super.radius = 50.0;
        super.mass = 5.0;
    }
    void collision(Fruit fruit) {
        if (fruit instanceof Pear) {
            removeList.add(this);
            removeList.add(fruit);
            PVector newPos = fruit.pos.copy().add(pos).mult(0.5);
            addList.add(new Peach(newPos.x, newPos.y));
        } else {
            super.collision(fruit);
        }
    }
}

class Peach extends Fruit {
    Peach(float x, float y) {
        super(x, y);
        super.radius = 60.0;
        super.mass = 6.0;
    }
    void collision(Fruit fruit) {
        if (fruit instanceof Peach) {
            removeList.add(this);
            removeList.add(fruit);
            PVector newPos = fruit.pos.copy().add(pos).mult(0.5);
            addList.add(new Pineapple(newPos.x, newPos.y));
        } else {
            super.collision(fruit);
        }
    }
}

class Pineapple extends Fruit {
    Pineapple(float x, float y) {
        super(x, y);
        super.radius = 70.0;
        super.mass = 7.0;
    }
    void collision(Fruit fruit) {
        if (fruit instanceof Pineapple) {
            removeList.add(this);
            removeList.add(fruit);
            PVector newPos = fruit.pos.copy().add(pos).mult(0.5);
            addList.add(new Melon(newPos.x, newPos.y));
        } else {
            super.collision(fruit);
        }
    }
}

class Melon extends Fruit {
    Melon(float x, float y) {
        super(x, y);
        super.radius = 90.0;
        super.mass = 9.0;
    }
    void collision(Fruit fruit) {
        if (fruit instanceof Melon) {
            removeList.add(this);
            removeList.add(fruit);
            PVector newPos = fruit.pos.copy().add(pos).mult(0.5);
            addList.add(new Watermelon(newPos.x, newPos.y));
        } else {
            super.collision(fruit);
        }
    }
}

class Watermelon extends Fruit {
    Watermelon(float x, float y) {
        super(x, y);
        super.radius = 110.0;
        super.mass = 11.0;
    }
}

