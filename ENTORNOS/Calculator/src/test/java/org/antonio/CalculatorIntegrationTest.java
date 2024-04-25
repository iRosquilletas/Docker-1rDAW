package org.antonio;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class CalculatorIntegrationTest {

    @Test
    public void testAddAndSubstract() {
        Calculator ej = new Calculator();
        assertEquals(2, ej.add(2, 4), ej.subtract(6, 2));
    }

}
