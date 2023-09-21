---
layout: post
title: Java Optional missing feature
---

(Un)boxing!

What if we lived in world where it's possible to compile such code:

```java
class Unboxing {
    public static void myIntegerAcceptingMethog(Integer value) {
    }

    public static void main(String[] args) {
        Optional<Integer> value = Optional.of(1);
        
        // look man! Optional<Integer> automatically converted to Integer:
        myIntegerAcceptingMethog(value); 
    }
    
}
```

Why do I need this possibility you would ask? For simplicity. Currently, the best we can do in such case is:

```java
Optional<Integer> optionalValue = Optional.of(1);
Integer value = optionalValue.get();
myIntegerAcceptingMethog(value);
```

or 

```java
Optional<Integer> optionalValue = Optional.of(1);
optionalValue.ifPresent(value -> myIntegerAcceptingMethog(value));
```

There is significant inconvenience in these lines: I have to name the same thing twice and this leads to artificial and absurd names (like `optionalValue`). This is visible especially well when working with Spring Data repositories:

```java
void doSmthWithOrder(Order) {
}

void evenMoreOrderProcessing(Order) {
}

void processOrder(Long id) {
    Optional<Order> a = orderRepository.findById(id);
    if (a.isPresent()) {
        b = a.get();
        doSmthWithOrder(b);
        evenMoreOrderProcessing(b);
    } else {
        throw new NotFoundException();
    }
}
```

Now my question is: what are good names instead of `a` and `b`? And why do I have to name it twice? In my dream world I could write:

```java
void doSmthWithOrder(Order) {
}

void evenMoreOrderProcessing(Order) {
}

void processOrder(Long id) {
    Optional<Order> order = orderRepository.findById(id);
    if (order.isPresent()) {
        doSmthWithOrder(order);
        evenMoreOrderProcessing(order);
    } else {
        throw new NotFoundException();
    }
}
```

All it requires from Java is the ability to convert from `Optional<E>` to `E` under the hood. If only had mechanism which takes one physical representation of object and coverts it to the different one keeping logical value intact! Oh wait! We [do](https://docs.oracle.com/javase/specs/jls/se8/html/jls-5.html#jls-5.1.7) ;)

PS. TIL that JLS defines [conversions](https://docs.oracle.com/javase/specs/jls/se8/html/jls-5.html). I should probably rename this post title as my imaginary feature isn't really (un)boxing, but this way it's more clickbait-y ;)




