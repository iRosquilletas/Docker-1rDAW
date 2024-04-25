package com.samy;

import static org.junit.Assert.*;

import org.junit.Test;

public class EjerciciosTest {

    /*
     * @Test
     * public void testSuma() {
     * Ejercicios ej = new Ejercicios();
     * assertEquals(5, ej.suma(3, 2));
     * 
     * assertNotEquals(5, ej.suma(1, 9));
     * 
     * assertFalse(false);
     * assertTrue(false);
     * 
     * }
     */
    @Test
    public void testArray() {
        Ejercicios ej = new Ejercicios();

        // assertEquals(new int[] { 1, 2, 3, 4 }, ej.sort(new int[] { 4, 3, 2, 1 }));
        assertArrayEquals(new int[] { -1, 0, 7 }, ej.sort(new int[] { 0, 7, -1 }));
    }

    @Test
    public void testAverage() {
        Ejercicios xd = new Ejercicios();
        assertEquals(2.5, xd.average(new int[] { 1, 2, 3, 4 }), 0.0);

    }

    @Test
    public void testBinarySeach() {
        Ejercicios ej = new Ejercicios();
        // assertTrue(ej.binarySearch(new int[] { 1, 2, 3, 4 }, 5) < 0);
        assertFalse(ej.binarySearch(new int[] { 1, 2, 3, 4 }, 6) >= 0);
    }

    @Test
    public void testCelsiusToFahrenheit() {
        Ejercicios ej = new Ejercicios();
        assertNotEquals(5, ej.celsiusToFahrenheit(5), 0.0);
    }
}
