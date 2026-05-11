package com.reto.KarateTest;

import com.intuit.karate.junit5.Karate;

class KarateIgnoredRunner {
    
    @Karate.Test
    Karate testTags() {

        return Karate.run().tags("~@ignore").relativeTo(getClass());
    }
}