package org.antonio;

import org.junit.Test;
import static org.junit.Assert.*;
import java.beans.*;

public class CalculatorTest {

    @Test
    public void testAdd() {
        Calculator ej = new Calculator();
        assertEquals(6, ej.add(4, 2));
        assertTrue(ej.add(5, 5) >= 10);

    }

    @Test
    public void testSubstract() {
        Calculator ej = new Calculator();
        assertEquals(ej.subtract(5, 5), 5 - 5);
        assertTrue(ej.add(5, 5) >= 10);
    }

    @Test
    public void testMultiply() {
        Calculator ej = new Calculator();
        assertEquals(16, ej.multiply(4, 4), 0.0);
        assertTrue(ej.multiply(4, 4) >= 10);

    }

    @Test
    public void testDivide() {
        Calculator ej = new Calculator();
        assertEquals(ej.divide(10, 2), 5, 0.0);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testDivideByZero() {
        Calculator ej = new Calculator();
        assertEquals(0, ej.divide(0, 2), 0.0);
    }

}
