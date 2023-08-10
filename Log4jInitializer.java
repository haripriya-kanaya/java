package com.infinite.java;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.config.Configurator;

public class Log4jInitializer {
    public static void initLog4j() {
        String log4jConfigFile = "log4j2.xml"; // Change this if using a different log4j2 configuration file
        Configurator.initialize(null, log4jConfigFile);
    }
}
