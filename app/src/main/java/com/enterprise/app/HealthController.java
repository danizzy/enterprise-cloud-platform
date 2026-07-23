package com.enterprise.app;


import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RestController;


@RestController

public class HealthController {


    @GetMapping("/")

    public String home(){

        return "Enterprise Cloud Platform Running";

    }



    @GetMapping("/health")

    public String health(){

        return "healthy";

    }

}