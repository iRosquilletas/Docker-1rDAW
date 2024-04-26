package org.antonio;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class CalculatorIntegrationTest {

    @Test
    public void testAddAndSubstract() {
        Calculator ej = new Calculator();
        assertEquals(2, ej.add(2, 4), ej.subtract(6, 2));
    }

    @Test
    public void testAddWithZero() {
        Calculator ej = new Calculator();

        assertEquals(5, ej.add(5, 0));
    }

    @Test
    public void testSubstractWithZero() {
        Calculator ej = new Calculator();
        assertEquals(10, ej.subtract(10, 0));
    }

    @Test
    public void testMultiplyAndDivide() {
        Calculator ej = new Calculator();
        assertEquals(25, ej.multiply(5, ej.divide(10, 2)), 0.0);
    }

    @Test
    public void testMultiplyWithZero() {

        Calculator ej = new Calculator();
        assertEquals(0, ej.multiply(5, 0), 0.0);

    }

    @Test
    public void testDivideWithZero() {

    }
}
