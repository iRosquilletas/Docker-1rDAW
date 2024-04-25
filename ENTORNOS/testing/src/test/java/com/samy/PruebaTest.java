package com.samy;

import static org.junit.Assert.*;
import org.junit.Test;

public class PruebaTest {
    String str1 = new String("abc");
    String str2 = new String("abc");
    String str3 = null;
    String str4 = "abc";
    String str5 = "abc";

    int val1 = 5;
    int val2 = 6;

    String[] expectedArray = { "one", "two", "three" };
    String[] resultArray = { "one", "two", "three" };

    @Test
    public void TestTwoObjectsAreEquals() {
        assertEquals(val2, val1);
    }

    @Test
    public void TestConditionTrue() {
        assertTrue(val2 > val1);
    }

    @Test
    public void TestConditionFalse() {
        assertFalse(val1 > val2);
    }

    @Test
    public void TestObjectIsNotNull() {
        assertNotNull(expectedArray);
    }

    @Test
    public void TestObjectIsNull() {
        assertNotNull(resultArray);
    }

    @Test
    public void TestSomethingIsSame() {
        assertSame(str4, str5);
    }

    @Test
    public void TestSomethingNotSame() {
        assertNotSame(str1, str3);
    }

    @Test
    void TestAvergate() {

    }

}
